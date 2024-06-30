// for handling json strings
import 'dart:convert';

// for loading data into their appropriate data models
import 'package:dy_integrated_5/models/CourseMaterial.dart';
import 'package:dy_integrated_5/models/Semester.dart';
import 'package:dy_integrated_5/services/file_handler.dart';


// Custom Http for separating the exception handling logic
import 'package:dy_integrated_5/utils/customHttp.dart';

//for caching data
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';


/// Simple Static Class for handling data returned from the backend API.
class ApiService{

  //Variables for cookie persistence across subsequent requests.
  // Chose to avoid the overhead of a library, since there will only ever be these two cookies needed
  // The API deals with the rest.
  static late String sessionCookie;
  static late String moodleCookie;
  
  //Im assuming the actual official session limit is longer but eh.
  static const Duration _sessionLength = Duration(minutes: 30);

  //Variables for handling the automatic login
  static DateTime lastLoginAttempt = DateTime.now().subtract(_sessionLength*2); // Just to be safe.

  //  !!!Subject to change or move out of this Class entirely!!!
  static String host = "192.168.29.137:5000";
  // REMEMBER TO CHANGE THIS WHEN TESTING ON EMULATOR VS WHEN ON USB DEBUGGING !!!

  // Secure storage to store and access the username and password for future automated login.
  static const FlutterSecureStorage _storage = FlutterSecureStorage();


  /// Writes the username and password into flutter secure storage.
  static Future<void> saveCredentials(String username, String password) async {
    await _storage.write(key: 'username', value: username);
    await _storage.write(key: 'password', value: password);
  }


  /// Fetches the username and password, for automatic login
  static Future<Map<String, String?>> getCredentials() async {
    String? username = await _storage.read(key: 'username');
    String? password = await _storage.read(key: 'password');
    print("Stored username: $username");
    print(password);
    return {'username': username, 'password': password};
  }


  /// Uses the [LastLoginAttempt] attribute to check whether if a Re-Authentication is necessary.
  /// Returns a true if it does need re-auth, false if it doesn't.
  static bool needsReAuthentication(){
    //Time elapsed since the last successful login
    Duration timeElapsed = DateTime.now().difference(lastLoginAttempt);

    if( timeElapsed > _sessionLength){
      return true;
    }
    return false;
  }


  /// Runs the [needsReAuthentication] function check, and creates a new
  /// Re-Authentication request if necessary
  static Future<void> ensureSessionValidity() async {

    if(needsReAuthentication()){
      print("Re-authentication was needed");
      Map<String, String?> credentials = await getCredentials();
      String? username = credentials['username'];
      String? password = credentials['password'];
      print("Relogging !!!!");
      await attemptLogin(
          username!,
          password!,
          storePassword: false, // Don't need to write the same credentials to storage again
      );
    }
    print("Re-authentication wasn't needed");

  }


  /// Returns a boolean based on whether the login was successful or not.
  static Future<bool> attemptLogin(String username, String password, {bool storePassword = true}) async {
    Uri baseUri = Uri.http(host, '/login');
    print(baseUri);
    var response = await CustomHttp.post(
      baseUri,
      body: {
        'username':username,
        'password':password
      }
    );

    if( response.statusCode == 200) {
      // For a valid login, parse the cookies, and store them for future data requests
      Map<String, dynamic> responseBody = jsonDecode(response.body);
      sessionCookie = response.headers['set-cookie']!;
      moodleCookie = "MoodleSession=${responseBody['MoodleSession']}";

      //Update the last successful login time
      lastLoginAttempt = DateTime.now();

      //Store the username and password in secure_storage.
      print("Writing data");
      if(storePassword == true) {
        await saveCredentials(username, password);
      }


      print("Login success");
      return true;

    }else{
      print("Login failed");
      return false;
    }


  }


  /// Get Subjects as a list of objects (called a semester)
  /// return format is a JSON Object like
  /// { name, instructor, course_code, link, attendance }
  static Future<Semester> getSemesterData({bool forceReFetch = false}) async {
    print("Fetching sem data");
    //See if we already have a cached version of the Subject Information.
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString('Subjects');

    // if user didn't explicitly specify a re-fetch AND we have a valid cache, no request is made.
    if ((jsonString != null) && (forceReFetch == false)) {
      print("Subject Cache hit!");
      List<Map<String, dynamic>> jsonData = jsonDecode(jsonString).cast<Map<String, dynamic>>();
      Semester semester = Semester.fromJSON(jsonData);
      print(jsonData);
      return semester;
    }


    // If data wasn't in shared preferences, we just get the data by calling the API
    await ensureSessionValidity();

    Uri uri = Uri.http(host, '/subjects');

    var response = await CustomHttp.get(
      uri,
      headers: {
        'Cookie':sessionCookie,
      }
    );
    print(response.body);

    //Successful request
    if(response.statusCode == 200){
      List<Map<String, dynamic>> jsonData = jsonDecode(response.body).cast<Map<String,dynamic>>();
      prefs.setString('Subjects', jsonEncode(jsonData));
      Semester semester = Semester.fromJSON(jsonData);

      return semester;
    }

    //If the request fails, return empty semester
    return Semester();

  }


  /// Fetches Materials for a given subject, returns a List of JSON Objects
  /// Each JSON Object within the list is of the form: { name, link, type }
  static Future<List<CourseMaterial>> getSubjectMaterial(String link, {bool forceReFetch = false}) async {
    print("Attempting material fetch for $link");
    //Check if there's a cached version
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString(link);
    if(jsonString != null && forceReFetch == false){
      List<Map<String, dynamic>> jsonData = jsonDecode(jsonString).cast<Map<String, dynamic>>();
      List<CourseMaterial> materials = jsonData.map((jsonObject)=>CourseMaterial.fromJSON(jsonObject)).toList();
      print("cache hit for material with $link");
      print(jsonData);
      return materials;
    }

    await ensureSessionValidity();

    Uri uri = Uri.http(host, '/materials');


    var response = await CustomHttp.post(
      uri,
      body: {
        'link':link
      },
      headers: {
        'Cookie':sessionCookie,
      }
    );

    if (response.statusCode == 200){
      List<Map<String, dynamic>> jsonData = jsonDecode(response.body).cast<Map<String,dynamic>>();
      List<CourseMaterial> materials = jsonData.map((jsonObject)=>CourseMaterial.fromJSON(jsonObject)).toList(); // Putting data into Course Material class
      prefs.setString(link, jsonEncode(jsonData));
      print(materials);
      return materials;
    }

    //Failed request
    return [];


  }


  /// Downloads a pdf based on the link returned by the external api call
  /// and stores it to a path
  static void downloadResource(String subject, String name, String link, {bool forceReFetch = false}) async {

    //Try opening the file, if it exists, it will be opened, otherwise, we make a fetch
    if(forceReFetch == false){
      print("attempting - Reading $subject, $name ");
      if(await FileHandler.readFile(subject, name)){
        print("Cache hit");
        //successful read, no need to proceed further and download again
        return;
      }
    }
    print("Cache miss");
    await ensureSessionValidity(); // Make sure we are logged in before sending the download request.

    Uri uri = Uri.http(host, '/download');
    String type = link.split("/")[5]; // Extracting the type of the resource

    var response = await CustomHttp.post(
      uri,
      body: {
        'link':link,
        'type':type
      },
      headers: {
        'Cookie':sessionCookie
      }
    );

    if(response.statusCode == 200){

      Map<String, dynamic> resourceData = jsonDecode(response.body);
      String link = resourceData['link'];
      String name = resourceData['name'];
      name = Uri.decodeComponent(name); // Convert to a normal string [Eg. week%201%20ppython_uw.pdf ===> week 1 ppython_uw.pdf ]

      Uri uri = Uri.parse(link);

      // Once the resource link is received, we can initiate a download
      response = await CustomHttp.get(
        uri,
        headers: {
          'Cookie':moodleCookie,
        }
      );
      print('$subject, $name!!!!!!!!!!!!!!!!!!!');
      FileHandler.writeThenReadFile(subject, name, response.bodyBytes);

    }

  }

}