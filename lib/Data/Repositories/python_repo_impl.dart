import 'package:replit/Data/Data%20Sources/Remote/python_data_source.dart';
import 'package:replit/Domain/Repositories/python_repo.dart';
import 'package:http/http.dart' as http;

class PythonRepoImpl extends PythonRepo {
  // Required Data Source
  final PythonDataSource pythonDataSource;
  PythonRepoImpl({required this.pythonDataSource});

  @override
  Future<http.Response> submitPythonCode(String code) async {
    return await pythonDataSource.submitPythonCode(code);
  }
}
