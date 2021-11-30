import 'dart:async';
import 'dart:io';

import 'package:replit/Domain/Repositories/python_repo.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PythonDataSource implements PythonRepo {
  // No arg constructor
  PythonDataSource();

  var client = http.Client();

  var url = Uri.parse('https://eval-backend.AdhamSaheb.repl.co/exec');

  @override
  Future<http.Response> submitPythonCode(String code) async {
    // Request body
    Map body = {
      'language': "python",
      'command': code,
    };
    try {
      var response = await client
          .put(url,
              headers: {HttpHeaders.contentTypeHeader: 'application/json'},
              body: json.encode(body))
          .timeout(const Duration(seconds: 10));
      return response;
    } on TimeoutException catch (e) {
      return http.Response("Request Timeout : " + e.toString(), 500);
    } on Exception catch (e) {
      return http.Response("Unknown error : " + e.toString(), 500);
    }
  }
}
