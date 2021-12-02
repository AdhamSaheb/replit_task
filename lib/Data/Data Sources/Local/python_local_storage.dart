import 'package:shared_preferences/shared_preferences.dart';

class PythonLocalStorageDataSource {
  // Load saved code from local storage
  Future<String?> fetchSavedCode() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      String? code = prefs.getString('code');
      return code;
    } catch (e) {
      rethrow;
    }
  }

  // Save code to local storage
  void saveCode(String code) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      prefs.setString('code', code);
    } catch (e) {
      rethrow;
    }
  }
}
