import 'dart:async';
import 'dart:io';

import 'package:dy_integrated_5/utils/snackbar.dart';
import 'package:http/http.dart' as http;

/// Helper class so I can handle any exceptions originating from the http class
/// Without cluttering the apiService Class.
class CustomHttp {
  static Future<http.Response> get(Uri uri,
      {Map<String, String>? headers}) async {
    try {
      return http.get(
        uri,
        headers: headers,
      );
    } on SocketException catch (error) {
      showSnackBar("Socket Exception", 2000);
      print("Socket Exception: $error");
    } on TimeoutException catch (error) {
      print("Timed Out: $error");
      showSnackBar("Connection Timed out", 2000);
    } on http.ClientException catch (error) {
      showSnackBar("Client Error", 2000);
      print("Client Exception: $error");
    } on FormatException catch (error) {
      showSnackBar("Format Exception Occurred", 2000);
    } on HttpException catch (error) {
      print("Http Exception: $error");
      showSnackBar("Http Exception Occurred", 2000);
    } catch (error) {
      print("Unexpected Exception Idk how: $error");
      showSnackBar("Something went wrong", 2000);
    }
    return http.Response("Failed", 500);
  }

  static Future<http.Response> post(Uri uri,
      {Map<String, String>? body, Map<String, String>? headers}) async {
    try {
      return http.post(
        uri,
        body: body,
        headers: headers,
      );
    } on SocketException catch (error) {
      showSnackBar("Socket Exception", 2000);
      print("Socket Exception: $error");
    } on TimeoutException catch (error) {
      print("Timed Out: $error");
      showSnackBar("Connection Timed out", 2000);
    } on http.ClientException catch (error) {
      showSnackBar("Client Error", 2000);
      print("Client Exception: $error");
    } on FormatException catch (error) {
      showSnackBar("Format Exception Occurred", 2000);
    } on HttpException catch (error) {
      print("Http Exception: $error");
      showSnackBar("Http Exception Occurred", 2000);
    } catch (error) {
      print("Unexpected Exception Idk how: $error");
      showSnackBar("Something went wrong", 2000);
    }
    return http.Response("Failed", 500);
  }
}
