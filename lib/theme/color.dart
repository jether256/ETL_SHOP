

import 'package:edge_app/theme/theme.dart';
import 'package:flutter/material.dart';

late ThemeData activeTheme;

final darkTheme=ThemeData(
  primarySwatch: Colors.grey,
  primaryColor: Colors.black,
  brightness: Brightness.dark,
  backgroundColor: const Color(0xFF212121),
  accentColor: Colors.white,
  accentIconTheme: const IconThemeData(color: Colors.black),
  fontFamily: 'Gothic',
  dividerColor: Colors.black12,
);
final lightTheme=ThemeData(
  primarySwatch: Colors.grey,
  primaryColor: Colors.white,
  brightness: Brightness.light,
  backgroundColor: const Color(0xFFE5E5E5),
  accentColor: Colors.black,
    fontFamily: 'Gothic',
  accentIconTheme: const IconThemeData(color: Colors.white),
  dividerColor: Colors.white54,
);
final blueTheme=ThemeData();
final greenTheme=ThemeData();