import 'dart:async';
import 'dart:io';

import 'package:http/http.dart' as http;


/// Helper class so I can handle any exceptions originating from the http class
/// Without cluttering the apiService Class.
class CustomHttp{


  static Future<http.Response> get(
    Uri uri,
    {
      Map<String, String>? headers
    }
  ) async {

    try{
      return http.get(
        uri,
        headers: headers,
      );
    }on SocketException catch(error){
      print("Socket Exception: $error");
      rethrow;
    }on TimeoutException catch(error){
      print("Timed Out: $error");
      rethrow;
    } on http.ClientException catch(error){
      print("Client Exception: $error");
      rethrow;
    } on FormatException catch(error){
      print("Format Exception: $error");
      rethrow;
    } on HttpException catch(error){
      print("Http Exception: $error");
      rethrow;
    } catch(error){
      print("Unexpected Exception Idk how: $error");
      rethrow;
    }
  }

  static Future<http.Response> post(
      Uri uri,
      {
        Map<String, String>? body,
        Map<String, String>? headers
      }
  ) async {

    try{
      return http.post(
        uri,
        body: body,
        headers: headers,
      );
    }on SocketException catch(error){
      print("Socket Exception: $error");
      rethrow;
    }on TimeoutException catch(error){
      print("Timed Out: $error");
      rethrow;
    } on http.ClientException catch(error){
      print("Client Exception: $error");
      rethrow;
    } on FormatException catch(error){
      print("Format Exception: $error");
      rethrow;
    } on HttpException catch(error){
      print("Http Exception: $error");
      rethrow;
    } catch(error){
      print("Unexpected Exception Idk how: $error");
      rethrow;
    }
  }
}
