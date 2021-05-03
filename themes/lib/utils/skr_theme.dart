import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class SkrTheme {

  static late Color primaryColor;
  static late Color secondaryColor;
  static late Color hintColor;


  static ThemeData materialTheme(
      {Color? primaryColor, Color? secondaryColor, bool lightTheme = false}) {
    // Optional light or dark theme, default = dark.
    var base = lightTheme ? ThemeData.light() : ThemeData.dark();

    SkrTheme.primaryColor = primaryColor ?? base.primaryColor;
    SkrTheme.secondaryColor = secondaryColor ?? base.accentColor;
    SkrTheme.hintColor = base.hintColor;

    TextTheme _baseTextTheme(TextTheme base) {
      return base.copyWith(
        headline4: base.headline4!.copyWith(
          fontWeight: FontWeight.bold,
        ),
        headline6: base.headline6!.copyWith(
          fontWeight: FontWeight.bold,
          fontSize: 16.0,
        ),
        headline1: base.headline1!.copyWith(
          fontSize: 24.0,
        ),
        button: base.button!.copyWith(
          fontSize: 16.0,
        ),
      );
    }

    var baseTextTheme = _baseTextTheme(base.textTheme);

    AppBarTheme _baseAppBarTheme(AppBarTheme base) {
      return base.copyWith(
        textTheme: baseTextTheme,
        elevation: 5.0,
      );
    }

    return base.copyWith(
      appBarTheme: _baseAppBarTheme(base.appBarTheme),
      textTheme: baseTextTheme,
      primaryColor: primaryColor,
      accentColor: secondaryColor,
      colorScheme: base.colorScheme.copyWith(
        secondary: secondaryColor,
      ),
      scaffoldBackgroundColor: Colors.amberAccent[50],
      inputDecorationTheme: base.inputDecorationTheme.copyWith(),
    );
  }

  static CupertinoThemeData cupertinoTheme(
      {Color? primaryColor, Color? secondaryColor, bool lightTheme = false}) {
    var base = CupertinoThemeData(
        brightness: lightTheme ? Brightness.light : Brightness.dark);
    SkrTheme.primaryColor = primaryColor ?? base.primaryColor;
    SkrTheme.secondaryColor = secondaryColor ?? base.primaryContrastingColor;
    SkrTheme.hintColor = base.textTheme.textStyle.color!;
    return base.copyWith(
      primaryColor: primaryColor,
      primaryContrastingColor: secondaryColor
    );
  }

}
