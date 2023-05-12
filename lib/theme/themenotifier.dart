
import 'package:edge_app/main.dart';
import 'package:edge_app/theme/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemePro extends ChangeNotifier{


  ThemeMode themeMode = ThemeMode.system;

  bool get isDarkMode {
    if (themeMode == ThemeMode.system) {
      final brightness = SchedulerBinding.instance.window.platformBrightness;
      return brightness == Brightness.dark;
    } else {
      return themeMode == ThemeMode.dark;
    }
  }




  void toggleTheme(bool isOn) async{

    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class MyThemes {

  static final darkTheme=ThemeData(
    primarySwatch: Colors.grey,
    primaryColor: Colors.black,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.black45,
    colorScheme: const ColorScheme.dark(),
    backgroundColor: const Color(0xFF212121),
    accentColor: Colors.white,
    accentIconTheme: const IconThemeData(color: Colors.black),
    fontFamily: 'Gothic',
    dividerColor: Colors.black12,

  );

  static final lightTheme=ThemeData(

    primarySwatch: Colors.lightBlue,
    primaryColor: mainColor,
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(),
    scaffoldBackgroundColor:mainColor,
    backgroundColor: const Color(0xFFE5E5E5),
    accentColor: Colors.black,
    fontFamily: 'Gothic',
    accentIconTheme: const IconThemeData(color: Colors.white),
    dividerColor: Colors.white54,

  );

}




