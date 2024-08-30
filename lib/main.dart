import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pocket_saver/app/constant/app_constants.dart';
import 'package:flutter_pocket_saver/app/constant/app_routes.dart';
import 'package:flutter_pocket_saver/app/constant/app_theme.dart';
import 'package:flutter_pocket_saver/app/pages/pocket_page.dart';
import 'package:flutter_pocket_saver/di/di.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  configureInjection();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pocket Saver',
      theme: appThemeLight,
      darkTheme: appThemeDark,
      themeMode: ThemeMode.system,
      home: const PocketPage(),
      navigatorKey: navigatorKey,
      onGenerateRoute: Routes.generateRoute,
    );
  }
}
