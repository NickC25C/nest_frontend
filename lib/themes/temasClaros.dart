import 'package:flutter/material.dart';

ThemeData cafe = ThemeData.from(
    colorScheme: const ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xff96673D),
  onPrimary: Color(0xff150A00),
  secondary: Color(0xff291400),
  onSecondary: Color(0xffB87E49),
  error: Color(0xff551709),
  onError: Colors.white,
  background: Color(0xffCFB9A6),
  onBackground: Colors.black,
  surface: Color(0xffB87E49),
  onSurface: Colors.black,
));

ThemeData matcha = ThemeData.from(
    colorScheme: const ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xff768F55),
  onPrimary: Color(0xff080E00),
  secondary: Color(0xff142104),
  onSecondary: Color(0xff8CA26F),
  error: Color(0xffCE9A15),
  onError: Colors.white,
  background: Color(0xffD8E4C7),
  onBackground: Colors.black,
  surface: Color(0xff8CA26F),
  onSurface: Colors.black,
));

ThemeData bellasArtes = ThemeData.from(
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xffAE93FF),
    onPrimary: Color(0xff080E00),
    secondary: Color(0xff8574EE),
    onSecondary: Color(0xffF9F9F9),
    error: Colors.white,
    onError: Colors.redAccent,
    background: Color(0xffF9F9F9),
    onBackground: Colors.black,
    surface: Color(0xffffffff),
    onSurface: Colors.black,
  ),
  textTheme: TextTheme().copyWith(
    headlineLarge: TextStyle(fontFamily: 'LeagueSpartan'),
    headlineMedium: TextStyle(fontFamily: 'LeagueSpartan'),
    headlineSmall: TextStyle(fontFamily: 'LeagueSpartan'),
    titleLarge: TextStyle(fontFamily: 'LeagueSpartan'),
    titleMedium: TextStyle(fontFamily: 'LeagueSpartan'),
    titleSmall: TextStyle(fontFamily: 'LeagueSpartan'),
    bodyLarge: TextStyle(fontFamily: 'LeagueSpartan'),
    bodyMedium: TextStyle(fontFamily: 'LeagueSpartan'),
    bodySmall: TextStyle(fontFamily: 'LeagueSpartan'),
    labelLarge: TextStyle(fontFamily: 'LeagueSpartan'),
    labelMedium: TextStyle(fontFamily: 'LeagueSpartan'),
    labelSmall: TextStyle(fontFamily: 'LeagueSpartan'),
  ),
);
