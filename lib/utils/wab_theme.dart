import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class WabTheme {

  static late Color primaryColor;
  static late Color secondaryColor;
  static late Color hintColor;


  static ThemeData materialTheme (
      {Color? primaryColor, Color? secondaryColor, bool lightTheme = true}) {
    // Optional light or dark theme, default = light.
    var base = lightTheme ? ThemeData.light(useMaterial3: true): ThemeData.dark(useMaterial3: true);

    WabTheme.primaryColor = primaryColor ?? base.primaryColor;
    WabTheme.secondaryColor = secondaryColor ?? base.colorScheme.secondary;
    WabTheme.hintColor = base.hintColor;

    TextTheme _baseTextTheme(TextTheme base) {
      return base.copyWith(
        headlineMedium: base.headlineMedium!.copyWith(
          fontWeight: FontWeight.bold,
        ),
        titleLarge: base.titleLarge!.copyWith(
          fontWeight: FontWeight.bold,
          fontSize: 16.0,
        ),
        displayLarge: base.displayLarge!.copyWith(
          fontSize: 24.0,
        ),
        labelLarge: base.labelLarge!.copyWith(
          fontSize: 16.0,
        ),
      );
    }

    var baseTextTheme = _baseTextTheme(base.textTheme);

    AppBarTheme _baseAppBarTheme(AppBarTheme base) {
      return base.copyWith(
        elevation: 5.0, toolbarTextStyle: baseTextTheme.bodyMedium, titleTextStyle: baseTextTheme.titleLarge,
      );
    }

    return base.copyWith(
      appBarTheme: _baseAppBarTheme(base.appBarTheme),
      textTheme: baseTextTheme,
      primaryColor: primaryColor,
      scaffoldBackgroundColor: Colors.amberAccent[50],
      inputDecorationTheme: base.inputDecorationTheme.copyWith(), colorScheme: base.colorScheme.copyWith(
        secondary: secondaryColor,
      ).copyWith(secondary: secondaryColor),
    );
  }

  static CupertinoThemeData cupertinoTheme (
      {Color? primaryColor, Color? secondaryColor, bool lightTheme = false}) {
    var base = CupertinoThemeData(
        brightness: lightTheme ? Brightness.light : Brightness.dark);
    WabTheme.primaryColor = primaryColor ?? base.primaryColor;
    WabTheme.secondaryColor = secondaryColor ?? base.primaryContrastingColor;
    WabTheme.hintColor = base.textTheme.textStyle.color!;
    return base.copyWith(
      primaryColor: primaryColor,
      primaryContrastingColor: secondaryColor
    );
  }

}
