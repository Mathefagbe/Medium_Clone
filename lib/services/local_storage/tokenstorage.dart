import 'package:shared_preferences/shared_preferences.dart';

class LocalDatabase {
  LocalDatabase._();
  static final LocalDatabase init = LocalDatabase._();

  void setToken(String token) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString("accesstoken", token);
  }

  void getToken() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.getString("accesstoken") ?? "";
  }
}
