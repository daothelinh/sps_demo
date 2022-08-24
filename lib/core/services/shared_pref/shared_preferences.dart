import 'package:shared_preferences/shared_preferences.dart';

// ignore: camel_case_types
class SharedPreferenceHelper {
  final Future<SharedPreferences> _sharedPreference;
  SharedPreferenceHelper()
      : _sharedPreference = SharedPreferences.getInstance();
  static const String fullName = "fullName";
  static const String password = "password";
  Future<String?> get getUserName async {
    SharedPreferences preference = await _sharedPreference;
    return preference.getString(fullName);
  }

  Future<bool> saveUserName(String phone) async {
    SharedPreferences preference = await _sharedPreference;
    return preference.setString(fullName, phone);
  }

  // Future<String?> get getPassword async {
  //   SharedPreferences preference = await _sharedPreference;
  //   return preference.getString(password);
  // }

  // Future<bool> savePassword(String pass) async {
  //   SharedPreferences preference = await _sharedPreference;
  //   return preference.setString(password, pass);
  // }
}
