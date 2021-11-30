import 'package:http/http.dart' as http;

abstract class PythonRepo {
  Future<http.Response> submitPythonCode(String code);
}
