import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencePuller {
  Future<SharedPreferences> fetchSharedPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs;
  }

  void saveString(String key, String value) async {
    final SharedPreferences prefs = await fetchSharedPreferences();
    prefs.setString(key, value);
  }

  void saveInt(String key, int value) async {
    final SharedPreferences prefs = await fetchSharedPreferences();
    prefs.setInt(key, value);
  }

  void saveBool(String key, bool value) async {
    final SharedPreferences prefs = await fetchSharedPreferences();
    prefs.setBool(key, value);
  }

  Future<String?> getString(String key) async {
    final SharedPreferences prefs = await fetchSharedPreferences();
    return prefs.getString(key);
  }

  Future<int?> getInt(String key) async {
    final SharedPreferences prefs = await fetchSharedPreferences();
    return prefs.getInt(key);
  }

  Future<bool?> getBool(String key) async {
    final SharedPreferences prefs = await fetchSharedPreferences();
    return prefs.getBool(key);
  }
}