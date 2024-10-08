// for handling json strings
import 'dart:convert';
import 'dart:io';

// for loading data into their appropriate data models
import 'package:dy_integrated_5/models/CourseMaterial.dart';
import 'package:dy_integrated_5/models/Semester.dart';
import 'package:dy_integrated_5/screens/WebViewScreen/WebViewScreen.dart';
import 'package:dy_integrated_5/services/file_handler.dart';

// For stuff not meant to be on github
// Do not remove.
import 'package:dy_integrated_5/secrets/secrets.dart';

// Custom Http for separating the exception handling logic
import 'package:dy_integrated_5/utils/customHttp.dart';
import 'package:dy_integrated_5/utils/globals.dart';
import 'package:dy_integrated_5/utils/snackbar.dart';
import 'package:flutter/material.dart';

//for caching data
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

/// Simple Static Class for handling data returned from the backend API.
class ApiService {
  //Variables for cookie persistence across subsequent requests.
  // Chose to avoid the overhead of a library, since there will only ever be these two cookies needed
  // The API deals with the rest.
  late String sessionCookie;
  late String moodleCookie;

  //Im assuming the actual official session limit is longer but eh.
  late Duration _sessionLength;

  //Variables for handling the automatic login
  late DateTime lastLoginAttempt;

  // Constructor needed now as the class is not static anymore.
  ApiService() {
    _sessionLength = const Duration(minutes: 30);
    lastLoginAttempt =
        DateTime.now().subtract(_sessionLength * 2); // Just to be safe.
  }
  //  !!!Subject to change or move out of this Class entirely!!!
  // REMEMBER TO CHANGE THIS WHEN TESTING ON EMULATOR VS WHEN ON USB DEBUGGING !!!
  // static String host = "192.168.29.137:8000"; //for external device
  // String host = "10.0.2.2:8000"; // for emulator
  // static String host = "127.0.0.1:8000"; // for windows executable testing
  // static String host = "dfe4-49-36-98-69.ngrok-free.app"; //ngrok for temp
  static String host = HOST;

  // Secure storage to store and access the username and password for future automated login.
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  /// Writes the username and password into flutter secure storage.
  Future<void> saveCredentials(String username, String password) async {
    await _storage.write(key: 'username', value: username);
    await _storage.write(key: 'password', value: password);
  }

  /// Fetches the username and password, for automatic login
  Future<Map<String, String?>> getCredentials() async {
    String? username = await _storage.read(key: 'username');
    String? password = await _storage.read(key: 'password');
    print("Stored username: $username");
    print(password);
    return {'username': username, 'password': password};
  }

  /// Fetches just the username
  Future<String?> getCurrentUser() async {
    String? username = await _storage.read(key: 'username');
    print("Stored username: $username");
    return username;
  }

  /// Uses the [LastLoginAttempt] attribute to check whether if a Re-Authentication is necessary.
  /// Returns a true if it does need re-auth, false if it doesn't.
  bool needsReAuthentication() {
    //Time elapsed since the last successful login
    Duration timeElapsed = DateTime.now().difference(lastLoginAttempt);

    if (timeElapsed > _sessionLength) {
      return true;
    }
    return false;
  }

  /// Runs the [needsReAuthentication] function check, and creates a new
  /// Re-Authentication request if necessary
  Future<void> ensureSessionValidity() async {
    if (needsReAuthentication()) {
      print("Re-authentication was needed");
      Map<String, String?> credentials = await getCredentials();
      String? username = credentials['username'];
      String? password = credentials['password'];
      print("Relogging !!!!");
      await attemptLogin(
        username!,
        password!,
        storePassword:
            false, // Don't need to write the same credentials to storage again
      );
    }
    print("Re-authentication wasn't needed");
  }

  /// Returns a boolean based on whether the login was successful or not.
  Future<bool> attemptLogin(String username, String password,
      {bool storePassword = true}) async {
    Uri baseUri = Uri.http(host, '/login');
    print(baseUri);
    var response = await CustomHttp.post(
      baseUri,
      body: {'username': username, 'password': password},
    );

    if (response.statusCode == 200) {
      // For a valid login, parse the cookies, and store them for future data requests
      Map<String, dynamic> responseBody = jsonDecode(response.body);
      sessionCookie = response.headers['set-cookie']!;
      moodleCookie = "MoodleSession=${responseBody['MoodleSession']}";

      //Update the last successful login time
      lastLoginAttempt = DateTime.now();

      //Store the username and password in secure_storage.
      print("Writing data");
      if (storePassword == true) {
        await saveCredentials(username, password);
      }

      print("Login success");
      return true;
    } else {
      print("Login failed");
      return false;
    }
  }

  /// Get Subjects as a list of objects (called a semester)
  /// return format is a JSON Object like
  /// { name, instructor, course_code, link, attendance }
  Future<Semester> getSemesterData({bool forceReFetch = false}) async {
    print("Fetching sem data");
    //See if we already have a cached version of the Subject Information.
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString('Subjects');

    // if user didn't explicitly specify a re-fetch AND we have a valid cache, no request is made.
    if ((jsonString != null) && (forceReFetch == false)) {
      print("Subject Cache hit!");
      List<Map<String, dynamic>> jsonData =
          jsonDecode(jsonString).cast<Map<String, dynamic>>();
      Semester semester = Semester.fromJSON(jsonData);
      print(jsonData);
      return semester;
    }

    // If data wasn't in shared preferences, we just get the data by calling the API
    await ensureSessionValidity();
    Uri uri = Uri.http(host, '/subjects');

    var response = await CustomHttp.get(uri, headers: {
      'Cookie': sessionCookie,
    });
    print(response.body);

    //Successful request
    if (response.statusCode == 200) {
      List<Map<String, dynamic>> jsonData =
          jsonDecode(response.body).cast<Map<String, dynamic>>();
      prefs.setString('Subjects', jsonEncode(jsonData));
      Semester semester = Semester.fromJSON(jsonData);
      return semester;
    }

    //If the request fails, return empty semester
    return Semester();
  }

  /// !!! UPDATE THE FUNCTION FOR THE CASE WHEN THE MATERIAL IS INCOMPATIBLE, IMPLEMENT A CACHE.
  /// Fetches Materials for a given subject, returns a List of JSON Objects
  /// Each JSON Object within the list is of the form: { name, link, type }
  Future<List<CourseMaterial>> getSubjectMaterial(String link,
      {bool forceReFetch = false}) async {
    print("Attempting material fetch for $link");
    //Check if there's a cached version
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString(link);
    if (jsonString != null && forceReFetch == false) {
      List<Map<String, dynamic>> jsonData =
          jsonDecode(jsonString).cast<Map<String, dynamic>>();
      List<CourseMaterial> materials = jsonData
          .map((jsonObject) => CourseMaterial.fromJSON(jsonObject))
          .toList();
      print("cache hit for material with $link");
      print(jsonData);
      return materials;
    }

    print("cache fail for materials $link");

    await ensureSessionValidity();

    Uri uri = Uri.http(host, '/materials');

    var response = await CustomHttp.post(uri, body: {
      'link': link
    }, headers: {
      'Cookie': sessionCookie,
    });

    if (response.statusCode == 200) {
      List<Map<String, dynamic>> jsonData =
          jsonDecode(response.body).cast<Map<String, dynamic>>();
      // print("raw data: $jsonData");
      List<CourseMaterial> materials = jsonData
          .map((jsonObject) => CourseMaterial.fromJSON(jsonObject))
          .toList(); // Putting data into Course Material class

      prefs.setString(link, jsonEncode(jsonData));
      // print(materials);
      return materials;
    }

    //Failed request
    return [];
  }

  /// Downloads a pdf based on the link returned by the external api call
  /// and stores it to a path
  void downloadResource(String subject, String name, String link,
      {bool forceReFetch = false}) async {
    // Helper function to open a link, in a compatible browser or webview, whichever is available
    void openLink(link) async {
      Uri targetUri = Uri.parse(
        link, // The link to the actual non downloadable resource, like a video embedded on the official site
      );
      if (!(Platform.isAndroid || Platform.isIOS)) {
        if (await canLaunchUrl(targetUri)) {
          await launchUrl(targetUri);
        } else {
          print("Couldn't launch");
        }
        return;
      }

      //For iOS and Android, can use webview with cookies.
      navigatorKey.currentState!.push(MaterialPageRoute(builder: (context) {
        var cookieData = moodleCookie.split("=");
        return WebViewScreen(
            cookieName: cookieData[0],
            value: cookieData[1],
            domain: "mydy.dypatil.edu",
            path: "/",

            // https://mydy.dypatil.edu/rait/mod/url/view.php?id=618621
            url: link);
      }));
    }

    //Try opening the file, if it exists, it will be opened, otherwise, we make a fetch
    if (forceReFetch == false) {
      // name = removeFileExtension(name);
      // print("attempting - Reading $subject, $name ");

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? nameWithExtension = prefs.getString(link);

      print('Trying out Key: $link');
      print('Value returned: $nameWithExtension');

      if (nameWithExtension != null) {
        // Check if it its a link type, or a saved file type
        if (nameWithExtension == "link") {
          print("Cache hit: Type: link");
          await ensureSessionValidity();
          openLink(link);
          return;
        }
        if (await FileHandler.readFile(subject, nameWithExtension)) {
          print("Cache hit");
          //successful read, no need to proceed further and download again
          return;
        }
      }
    }
    print("Cache miss");
    //If cache miss, notify the user and mention download
    showSnackBar("Opening $name", 5000);
    await ensureSessionValidity(); // Make sure we are logged in before sending the download request.

    Uri uri = Uri.http(host, '/download');
    String type = link.split("/")[5]; // Extracting the type of the resource

    var response = await CustomHttp.post(uri,
        body: {'link': link, 'type': type}, headers: {'Cookie': sessionCookie});

    if (response.statusCode == 200) {
      Map<String, dynamic> resourceData = jsonDecode(response.body);
      String resourceLink = resourceData['link'];
      String name = resourceData['name'];
      name = Uri.decodeComponent(
          name); // Convert to a normal string [Eg. week%201%20ppython_uw.pdf ===> week 1 ppython_uw.pdf ]

      Uri uri = Uri.parse(resourceLink);

      // Once the resource link is received, we can initiate a download
      response = await CustomHttp.get(uri, headers: {
        'Cookie': moodleCookie,
      });
      print('$subject, $name!!!!!!!!!!!!!!!!!!!');

      FileHandler.writeThenReadFile(subject, name, link, response.bodyBytes);
    } else {
      //TODO: Store the link to the official site resource if it is found to be an incompatible type.
      // This will prevent the need to hit DYP-Flask server, and can instead request the resource directly
      // from the official site, speeding up the whole process.

      showSnackBar("Redirecting to Official Site", 500);
      //The case where the link is not actually a downloadable resource
      print("Not making a download request, redirecting to official site.");
      print(link);

      print("Caching link");
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(link, "link");

      // For non android/ios, simple browser launch

      openLink(link);
    }
  }
}
