import 'package:shared_preferences/shared_preferences.dart';

mixin Token {
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<void> setToken(String token) async {
    await SharedPreferences.getInstance().then((prefs) => prefs.setString('token',token));
  }
}