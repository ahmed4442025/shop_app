import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyThemes {
  static ThemeData themeDark() => ThemeData(
      brightness: Brightness.dark,
      floatingActionButtonTheme:
          FloatingActionButtonThemeData(backgroundColor: Colors.grey[400]),
      appBarTheme: const AppBarTheme(
        centerTitle: true,
      ));

  static AppBarTheme appBarThemeNoClr() => const AppBarTheme(
      centerTitle: true,
      // backwardsCompatibility: false,
      color: Colors.transparent,
      titleTextStyle: TextStyle(color: Colors.black),
      // actionsIconTheme: IconThemeData(color: Colors.black),
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ));

  static ThemeData themeLight() => ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: MyThemes.appBarThemeNoClr(),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          type: BottomNavigationBarType.fixed,
            unselectedItemColor: Colors.grey,
            selectedItemColor: Colors.blue,
        ),
      );
}
