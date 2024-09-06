import "package:flutter/material.dart";

final ThemeData appThemeLight = ThemeData(
  useMaterial3: true,
  fontFamily: "PT_Sans-Narrow-Web",
  brightness: Brightness.dark,
  primaryColor: Colors.black,
  appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black,
      iconTheme: IconThemeData(color: Colors.white)),
  scaffoldBackgroundColor: Colors.black,
  iconTheme: const IconThemeData(color: Colors.white),
  textTheme: const TextTheme(
    titleLarge: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    titleMedium: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    titleSmall: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
  ),
);

final ThemeData appThemeDark = ThemeData(
  useMaterial3: true,
  fontFamily: "PT_Sans-Narrow-Web",
  brightness: Brightness.dark,
  primaryColor: Colors.black,
  appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black,
      iconTheme: IconThemeData(color: Colors.white)),
  scaffoldBackgroundColor: Colors.black,
  iconTheme: const IconThemeData(color: Colors.white),
  textTheme: const TextTheme(
    titleLarge: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    titleMedium: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    titleSmall: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
  ),
);
