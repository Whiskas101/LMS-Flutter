import 'dart:convert';
import 'package:dy_integrated_5/utils/customHttp.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// import 'package:http/http.dart' as http;

/// Simple Static Class for handling data returned from the backend API.
class ApiService{

  //Variables for cookie persistence across subsequent requests.
  // Chose to avoid the overhead of a library, since there will only ever be these two cookies needed
  // The API deals with the rest.
  static late String sessionCookie;
  static late String moodleCookie;

  //Variables for handling the automatic login
  static late DateTime? lastLoginAttempt;

  //Im assuming the actual official session limit is longer but eh.
  static const Duration _sessionLength = Duration(minutes: 30);

  //  !!!Subject to change or move out of this Class entirely!!!
  static String host = "10.0.2.2:5000";

  // Secure storage to store and access the username and password for future automated login
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
    print(username);
    print(password);
    return {'username': username, 'password': password};
  }


  /// Uses the [LastLoginAttempt] attribute to check whether if a Re-Authentication is necessary.
  /// Returns a true if it does need re-auth, false if it doesn't.
  static bool needsReAuthentication(){
    //Time elapsed since the last successful login


    Duration timeElapsed = DateTime.now().difference(lastLoginAttempt!);
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
    //this is meant to the doc
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
      moodleCookie = "MoodleSession=$responseBody['MoodleSession']";

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


  /// Get Subjects data as a list of objects
  /// return format is a JSON Object like
  /// { name, instructor, course_code, link, attendance }
  static Future<List<Map<String,dynamic>>> getSubjectData() async {
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
      return jsonData;
    }

    //If the request fails, return empty
    return [];

  }


  /// Fetches Materials for a given subject, returns a List of JSON Objects
  /// Each JSON is like: { name, link, type }
  static Future<List<Map<String, dynamic>>> getSubjectMaterial(String link) async {
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
      return jsonData;
    }

    //Failed request
    return [];


  }


  /// Downloads a pdf based on the link returned by the external api call
  /// and stores it to a path
  static void downloadResource(String subject, String link) async {
    await ensureSessionValidity();

    Uri uri = Uri.http(host, '/download');

    var response = await CustomHttp.post(
      uri,
      body: {
        'link':link,
      },
      headers: {
        'Cookie':sessionCookie
      }
    );

    if(response.statusCode == 200){
      //Need to work on this section, it makes two request and saving logic must
      // be separate from this api service.
    }



  }

}