import 'package:flutter/material.dart';
import 'package:flutter_pocket_saver/app/constant/app_routes.dart';
import 'package:flutter_pocket_saver/app/constant/app_theme.dart';
import 'package:flutter_pocket_saver/app/navigator/view/navigator_page.dart';
import 'package:flutter_pocket_saver/di/di.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pocket Saver',
      theme: appThemeLight,
      darkTheme: appThemeDark,
      themeMode: ThemeMode.system,
      home: const NavigatorPage(),
      onGenerateRoute: Routes.generateRoute,
    );
  }
}
