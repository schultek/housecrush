import 'package:flutter/material.dart';
import 'colors.dart';

final hcTheme = ThemeData(
  colorSchemeSeed: hcOrange,
  fontFamily: 'Axel',
  hintColor: Colors.white24,
  canvasColor: hcDark[500],
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
  unselectedWidgetColor: hcDark[300],
);
