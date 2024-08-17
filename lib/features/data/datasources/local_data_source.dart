import 'package:shared_preferences/shared_preferences.dart';

class LocalDataSource {
  Future<bool> setLocalConvertors(List<String> localConvertors) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return await prefs.setStringList('local', localConvertors);
  }

  Future<List<String>?> getLocalConvertors() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return await prefs!.getStringList('local');
  }
}
