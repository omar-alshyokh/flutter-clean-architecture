import 'dart:async';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@LazySingleton()
class SharedPreferenceHelper {
  // shared pref instance
  final SharedPreferences _sharedPreference;
  // final NativeSharedPreferences _nativePrefs;


  // constructor
  SharedPreferenceHelper(this._sharedPreference);

  // General Method ------------------------------------------------------------

  Future<bool> saveString(String key, String value) {
     return _sharedPreference.setString(key, value);
  }

  Future<bool> removeString(String key) async {
     return _sharedPreference.remove(key);
  }

  String? getString(String key) => _sharedPreference.getString(key);


  Future<bool>  saveBoolValue(String key, bool value) async{
     return await _sharedPreference.setBool(key, value);
  }

  bool? getBool(String key)  => _sharedPreference.getBool(key);
  bool contains(String key)  => _sharedPreference.containsKey(key);


  Future<bool> saveIntValue(String key, int value) async{
     return await _sharedPreference.setInt(key, value);
  }

  int? getInt(String key) => _sharedPreference.getInt(key);
}