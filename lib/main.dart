import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_pocket_saver/app/constant/app_constants.dart';
import 'package:flutter_pocket_saver/app/constant/app_funcoes.dart';
import 'package:flutter_pocket_saver/app/constant/app_routes.dart';
import 'package:flutter_pocket_saver/app/constant/app_theme.dart';
import 'package:flutter_pocket_saver/di/di.dart';

String tela = "";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  configureInjection();

  tela = await AppFuncoes().isConfigured() ? "/home" : "/acesso";
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
      initialRoute: tela,
      navigatorKey: navigatorKey,
      onGenerateRoute: Routes.generateRoute,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('pt', 'BR'),
        Locale('en', 'US'),
        Locale('es', 'ES'),
      ],
    );
  }
}
