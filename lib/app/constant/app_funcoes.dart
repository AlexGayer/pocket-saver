// ignore_for_file: depend_on_referenced_packages, avoid_print

import 'package:flutter_pocket_saver/app/constant/app_shared_preferences.dart';

class AppFuncoes {
  Future<bool> isConfigured() async {
    final handler = AppSharedPreferences();
    final String edtMail = await handler.redPreferences("mail");
    final String edtPwd = await handler.redPreferences("password");

    if (edtMail.isNotEmpty && edtPwd.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }
}
