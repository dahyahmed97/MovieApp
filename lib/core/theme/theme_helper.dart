import 'package:flutter/material.dart';

class ThemeHelper{
  static bool isLightMode = false;

  ThemeData get themeDataLight {
    return ThemeData(
      scaffoldBackgroundColor: Colors.white,
      // textTheme: txtThemeLight,
      // backgroundColor: _APP_WHITE,
      brightness: Brightness.light,
      // primarySwatch: Coolors().PRIMARY_SWATCH,
    );
  }

  /// The Dark Theme
  ThemeData get themeDataDark {
    return ThemeData(
      scaffoldBackgroundColor: Colors.black87,
      // textTheme: txtThemeDark,
      //backgroundColor: APP_DARK_MODE_MAIN_COLOR,
      brightness: Brightness.dark,
      // primarySwatch: Coolors().PRIMARY_SWATCH,
    );
  }

  ThemeData getTheme({bool isLight = true}) {
    isLightMode = isLight;
    return isLight ? themeDataLight : themeDataDark;
  }
}