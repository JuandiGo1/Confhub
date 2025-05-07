import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';

class LocalPreferences {
  Future<T?> retrieveData<T>(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (T == bool) {
      return prefs.getBool(key) as T?;
    } else if (T == double) {
      return prefs.getDouble(key) as T?;
    } else if (T == int) {
      return prefs.getInt(key) as T?;
    } else if (T == String) {
      return prefs.getString(key) as T?;
    } else if (T == List<String>) {
      return prefs.getStringList(key) as T?;
    } else {
      throw Exception("Unsupported type");
    }
  }

  Future<void> storeData(String key, dynamic value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool result = false;

    if (value is bool) {
      result = await prefs.setBool(key, value);
      log("LocalPreferences setBool with key $key got $result");
    } else if (value is double) {
      result = await prefs.setDouble(key, value);
      log("LocalPreferences setDouble with key $key got $result");
    } else if (value is int) {
      result = await prefs.setInt(key, value);
      log("LocalPreferences setInt with key $key got $result");
    } else if (value is String) {
      result = await prefs.setString(key, value);
      log("LocalPreferences setString with key $key got $result");
    } else if (value is List<String>) {
      result = await prefs.setStringList(key, value);
      log("LocalPreferences setStringList with key $key got $result");
    } else {
      throw Exception("Unsupported type");
    }

    if (!result) {
      log("Failed to store $key with value $value");
    }
  }
}