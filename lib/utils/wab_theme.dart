import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../const.dart';

class WabTheme {

  static late Color primaryColor;
  static late Color secondaryColor;
  static late Color hintColor;
  static late Color backgroundColor;
  static late Color surfaceColor;
  static late Color accentColor;
  static late Color onColor;
  static late Color offColor;
  static late Color textColor;
  static late Color woodyColor;
  static bool isDark = true;

  static ThemeData materialTheme (
      {Color? primaryColor, Color? secondaryColor, bool lightTheme = true}) {
    // Optional light or dark theme, default = light.
    var base = lightTheme ? ThemeData.light(useMaterial3: true): ThemeData.dark(useMaterial3: true);
    
    // Set isDark property for use in components
    WabTheme.isDark = !lightTheme;

    // Set theme colors based on light/dark mode
    if (lightTheme) {
      WabTheme.primaryColor = primaryColor ?? WAB_LIGHT_PRIMARY;
      WabTheme.secondaryColor = secondaryColor ?? WAB_LIGHT_SECONDARY;
      WabTheme.backgroundColor = WAB_LIGHT_BACKGROUND;
      WabTheme.surfaceColor = WAB_LIGHT_SURFACE;
      WabTheme.accentColor = WAB_LIGHT_ACCENT;
      WabTheme.onColor = WAB_LIGHT_ON;
      WabTheme.offColor = WAB_LIGHT_OFF;
      WabTheme.textColor = WAB_LIGHT_TEXT;
      WabTheme.woodyColor = WAB_LIGHT_WOODY;
    } else {
      WabTheme.primaryColor = primaryColor ?? WAB_DARK_PRIMARY;
      WabTheme.secondaryColor = secondaryColor ?? WAB_DARK_SECONDARY;
      WabTheme.backgroundColor = WAB_DARK_BACKGROUND;
      WabTheme.surfaceColor = WAB_DARK_SURFACE;
      WabTheme.accentColor = WAB_DARK_ACCENT;
      WabTheme.onColor = WAB_DARK_ON;
      WabTheme.offColor = WAB_DARK_OFF;
      WabTheme.textColor = WAB_DARK_TEXT;
      WabTheme.woodyColor = WAB_DARK_WOODY;
    }
    
    WabTheme.hintColor = lightTheme ? WAB_LIGHT_TEXT.withOpacity(0.6) : WAB_DARK_TEXT.withOpacity(0.6);

    TextTheme _baseTextTheme(TextTheme base) {
      return base.copyWith(
        headlineMedium: base.headlineMedium!.copyWith(
          fontWeight: FontWeight.bold,
          color: WabTheme.textColor,
        ),
        titleLarge: base.titleLarge!.copyWith(
          fontWeight: FontWeight.bold,
          fontSize: 16.0,
          color: WabTheme.textColor,
        ),
        displayLarge: base.displayLarge!.copyWith(
          fontSize: 24.0,
          color: WabTheme.textColor,
        ),
        labelLarge: base.labelLarge!.copyWith(
          fontSize: 16.0,
          color: WabTheme.textColor,
        ),
        bodyMedium: base.bodyMedium!.copyWith(
          color: WabTheme.textColor,
        ),
      );
    }

    var baseTextTheme = _baseTextTheme(base.textTheme);

    return base.copyWith(
      appBarTheme: base.appBarTheme.copyWith(
        elevation: 0.0,
        backgroundColor: WabTheme.surfaceColor,
        toolbarTextStyle: baseTextTheme.bodyMedium,
        titleTextStyle: baseTextTheme.titleLarge,
      ),
      textTheme: baseTextTheme,
      primaryColor: WabTheme.primaryColor,
      scaffoldBackgroundColor: WabTheme.backgroundColor,
      cardColor: WabTheme.surfaceColor,
      dialogBackgroundColor: WabTheme.surfaceColor,
      dividerColor: WabTheme.secondaryColor,
      inputDecorationTheme: base.inputDecorationTheme.copyWith(
        fillColor: WabTheme.woodyColor,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(WAB_CARD_BORDER_RADIUS),
          borderSide: BorderSide.none,
        ),
      ),
      colorScheme: base.colorScheme.copyWith(
        primary: WabTheme.primaryColor,
        secondary: WabTheme.secondaryColor,
        surface: WabTheme.surfaceColor,
        background: WabTheme.backgroundColor,
        error: Colors.redAccent,
        onPrimary: WabTheme.textColor,
        onSecondary: WabTheme.textColor,
        onSurface: WabTheme.textColor,
        onBackground: WabTheme.textColor,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: WabTheme.woodyColor,
          foregroundColor: WabTheme.textColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(WAB_CARD_BORDER_RADIUS),
          ),
          padding: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: WabTheme.textColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(WAB_CARD_BORDER_RADIUS),
          ),
          padding: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        ),
      ),
    );
  }

  static CupertinoThemeData cupertinoTheme (
      {Color? primaryColor, Color? secondaryColor, bool lightTheme = false}) {
    var base = CupertinoThemeData(
        brightness: lightTheme ? Brightness.light : Brightness.dark);
    
    // Set isDark property for use in components
    WabTheme.isDark = !lightTheme;
        
    // Set theme colors based on light/dark mode
    if (lightTheme) {
      WabTheme.primaryColor = primaryColor ?? WAB_LIGHT_PRIMARY;
      WabTheme.secondaryColor = secondaryColor ?? WAB_LIGHT_SECONDARY;
      WabTheme.backgroundColor = WAB_LIGHT_BACKGROUND;
      WabTheme.surfaceColor = WAB_LIGHT_SURFACE;
      WabTheme.accentColor = WAB_LIGHT_ACCENT;
      WabTheme.onColor = WAB_LIGHT_ON;
      WabTheme.offColor = WAB_LIGHT_OFF;
      WabTheme.textColor = WAB_LIGHT_TEXT;
      WabTheme.woodyColor = WAB_LIGHT_WOODY;
    } else {
      WabTheme.primaryColor = primaryColor ?? WAB_DARK_PRIMARY;
      WabTheme.secondaryColor = secondaryColor ?? WAB_DARK_SECONDARY;
      WabTheme.backgroundColor = WAB_DARK_BACKGROUND;
      WabTheme.surfaceColor = WAB_DARK_SURFACE;
      WabTheme.accentColor = WAB_DARK_ACCENT;
      WabTheme.onColor = WAB_DARK_ON;
      WabTheme.offColor = WAB_DARK_OFF;
      WabTheme.textColor = WAB_DARK_TEXT;
      WabTheme.woodyColor = WAB_DARK_WOODY;
    }
    
    WabTheme.hintColor = lightTheme ? WAB_LIGHT_TEXT.withOpacity(0.6) : WAB_DARK_TEXT.withOpacity(0.6);
    
    return base.copyWith(
      primaryColor: WabTheme.primaryColor,
      primaryContrastingColor: WabTheme.secondaryColor,
      barBackgroundColor: WabTheme.surfaceColor,
      scaffoldBackgroundColor: WabTheme.backgroundColor,
      textTheme: CupertinoTextThemeData(
        textStyle: TextStyle(color: WabTheme.textColor),
        actionTextStyle: TextStyle(color: WabTheme.accentColor),
        navTitleTextStyle: TextStyle(
          color: WabTheme.textColor,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
