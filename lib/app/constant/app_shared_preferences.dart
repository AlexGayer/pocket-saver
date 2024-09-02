import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPreferences {
  Future savePreferences(String key, String value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(key, value);
  }

  Future<String> redPreferences(String key) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    String? sRetorno = sharedPreferences.getString(key);

    if (sRetorno == null) {
      return "";
    } else {
      return sRetorno;
    }
  }

  Future<void> removePreferences(String key) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove(key);
  }
}
