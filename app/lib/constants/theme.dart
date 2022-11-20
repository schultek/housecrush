import 'package:flutter/material.dart';
import 'colors.dart';

final hcTheme = ThemeData(
  colorSchemeSeed: hcRed,
  fontFamily: 'Axel',
  hintColor: Colors.white24,
  backgroundColor: Colors.white,
  textTheme: const TextTheme(
          displayLarge: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 40),
          displayMedium: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 25),
          displaySmall: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 18),
          headlineLarge: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 14, letterSpacing: 0.6),
          bodyLarge: TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 20),
          bodyMedium: TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 18),
          bodySmall: TextStyle(color: Colors.black87, fontWeight: FontWeight.w400, fontSize: 17),
          labelLarge: TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 20),
          labelMedium: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 14),
        ),
  unselectedWidgetColor: hcDark[300],
);

final hcThemeDark = ThemeData.from(
  colorScheme: ColorScheme.fromSeed(seedColor: hcRed, brightness: Brightness.dark),
  // brightness: Brightness.dark,
  // colorSchemeSeed: hcRed,
  // fontFamily: 'Axel',
  // hintColor: Colors.white24,
  // backgroundColor: hcDark[800],
  textTheme: const TextTheme(
    displayLarge: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 40),
    displayMedium: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 25),
    displaySmall: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 18),
    headlineLarge: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 14, letterSpacing: 0.6),
    bodyLarge: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 20),
    bodyMedium: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 18),
    bodySmall: TextStyle(color: Colors.white70, fontWeight: FontWeight.w400, fontSize: 17),
    labelLarge: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 20),
    labelMedium: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 14),
  ),
  //unselectedWidgetColor: hcDark[300],
);
