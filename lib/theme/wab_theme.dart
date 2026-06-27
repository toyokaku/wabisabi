import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../tokens/palette.dart';
import '../tokens/spacing.dart';

/// Modern geometric sans fallback chain (Century Gothic family look).
/// Resolved against system fonts (no bundled asset); first available wins.
const List<String> kWabFontFallback = [
  'Century Gothic',
  'Futura',
  'Avenir Next',
  'Questrial',
  'URW Gothic',
  'Helvetica Neue',
  'Arial',
  'sans-serif',
];

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
  static late Color progressColor;
  static late Color mutedColor;
  static late Color scratchColor;
  static bool isDark = true;

  /// Drop shadow for ELEVATED surfaces — falls to the bottom-right. The stacked
  /// shadows (decreasing opacity, increasing blur) read as a soft gradient.
  static List<BoxShadow> get elevationShadow {
    final base = isDark ? Colors.black : const Color(0xFF2E2A24);
    return [
      BoxShadow(
        color: base.withOpacity(isDark ? 0.50 : 0.16),
        blurRadius: 3,
        offset: const Offset(2, 2),
      ),
      BoxShadow(
        color: base.withOpacity(isDark ? 0.34 : 0.10),
        blurRadius: 9,
        offset: const Offset(4, 5),
      ),
      BoxShadow(
        color: base.withOpacity(isDark ? 0.20 : 0.05),
        blurRadius: 18,
        offset: const Offset(8, 11),
      ),
    ];
  }


  static ThemeData materialTheme(
      {Color? primaryColor, Color? secondaryColor, bool lightTheme = true}) {
    var base = lightTheme
        ? ThemeData.light(useMaterial3: true)
        : ThemeData.dark(useMaterial3: true);

    WabTheme.isDark = !lightTheme;

    if (lightTheme) {
      WabTheme.primaryColor   = primaryColor ?? WAB_LIGHT_PRIMARY;
      WabTheme.secondaryColor = secondaryColor ?? WAB_LIGHT_SECONDARY;
      WabTheme.backgroundColor = WAB_LIGHT_BACKGROUND;
      WabTheme.surfaceColor   = WAB_LIGHT_SURFACE;
      WabTheme.accentColor    = WAB_LIGHT_ACCENT;
      WabTheme.onColor        = WAB_LIGHT_ON;
      WabTheme.offColor       = WAB_LIGHT_OFF;
      WabTheme.textColor      = WAB_LIGHT_TEXT;
      WabTheme.woodyColor     = WAB_LIGHT_WOODY;
      WabTheme.progressColor  = WAB_LIGHT_PROGRESS;
      WabTheme.mutedColor     = WAB_LIGHT_MUTED;
      WabTheme.scratchColor   = WAB_LIGHT_SCRATCH;
    } else {
      WabTheme.primaryColor   = primaryColor ?? WAB_DARK_PRIMARY;
      WabTheme.secondaryColor = secondaryColor ?? WAB_DARK_SECONDARY;
      WabTheme.backgroundColor = WAB_DARK_BACKGROUND;
      WabTheme.surfaceColor   = WAB_DARK_SURFACE;
      WabTheme.accentColor    = WAB_DARK_ACCENT;
      WabTheme.onColor        = WAB_DARK_ON;
      WabTheme.offColor       = WAB_DARK_OFF;
      WabTheme.textColor      = WAB_DARK_TEXT;
      WabTheme.woodyColor     = WAB_DARK_WOODY;
      WabTheme.progressColor  = WAB_DARK_PROGRESS;
      WabTheme.mutedColor     = WAB_DARK_MUTED;
      WabTheme.scratchColor   = WAB_DARK_SCRATCH;
    }

    WabTheme.hintColor = lightTheme
        ? WAB_LIGHT_TEXT.withOpacity(0.6)
        : WAB_DARK_TEXT.withOpacity(0.6);

    TextTheme _baseTextTheme(TextTheme base) {
      return base.copyWith(
        headlineMedium: base.headlineMedium!.copyWith(
          fontWeight: FontWeight.w700,
          color: WabTheme.textColor,
        ),
        titleLarge: base.titleLarge!.copyWith(
          fontWeight: FontWeight.w700,
          fontSize: 16.0,
          letterSpacing: 0.2,
          color: WabTheme.textColor,
        ),
        displayLarge: base.displayLarge!.copyWith(
          fontSize: 24.0,
          fontWeight: FontWeight.w700,
          color: WabTheme.textColor,
        ),
        labelLarge: base.labelLarge!.copyWith(
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
          color: WabTheme.textColor,
        ),
        bodyMedium: base.bodyMedium!.copyWith(
          fontWeight: FontWeight.w500,
          color: WabTheme.textColor,
        ),
      );
    }

    var baseTextTheme =
        _baseTextTheme(base.textTheme).apply(fontFamilyFallback: kWabFontFallback);

    return base.copyWith(
      appBarTheme: base.appBarTheme.copyWith(
        elevation: 0.0,
        backgroundColor: WabTheme.backgroundColor,  // flat — matches scaffold
        toolbarTextStyle: baseTextTheme.bodyMedium,
        titleTextStyle: baseTextTheme.titleLarge,
      ),
      textTheme: baseTextTheme,
      primaryColor: WabTheme.primaryColor,
      scaffoldBackgroundColor: WabTheme.backgroundColor,
      cardColor: WabTheme.surfaceColor,
      dialogBackgroundColor: WabTheme.surfaceColor,
      dividerColor: WabTheme.secondaryColor,
      cardTheme: CardTheme(
        color: WabTheme.surfaceColor,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(WAB_CARD_BORDER_RADIUS),
          side: BorderSide(color: WabTheme.secondaryColor, width: 0.8),
        ),
        margin: EdgeInsets.zero,
      ),
      inputDecorationTheme: base.inputDecorationTheme.copyWith(
        fillColor: WabTheme.scratchColor,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(WAB_CARD_BORDER_RADIUS),
          borderSide: BorderSide.none,
        ),
        hintStyle: TextStyle(color: WabTheme.textColor.withOpacity(0.45)),
      ),
      colorScheme: base.colorScheme.copyWith(
        primary: WabTheme.accentColor,
        secondary: WabTheme.secondaryColor,
        surface: WabTheme.surfaceColor,
        error: Colors.redAccent,
        onPrimary: WabTheme.textColor,
        onSecondary: WabTheme.textColor,
        onSurface: WabTheme.textColor,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          // Light: lighter & translucent wood; dark: solid dark wood.
          backgroundColor: lightTheme
              ? WabTheme.woodyColor.withOpacity(0.55)
              : WabTheme.woodyColor,
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

  static CupertinoThemeData cupertinoTheme(
      {Color? primaryColor, Color? secondaryColor, bool lightTheme = false}) {
    var base = CupertinoThemeData(
        brightness: lightTheme ? Brightness.light : Brightness.dark);

    WabTheme.isDark = !lightTheme;

    if (lightTheme) {
      WabTheme.primaryColor   = primaryColor ?? WAB_LIGHT_PRIMARY;
      WabTheme.secondaryColor = secondaryColor ?? WAB_LIGHT_SECONDARY;
      WabTheme.backgroundColor = WAB_LIGHT_BACKGROUND;
      WabTheme.surfaceColor   = WAB_LIGHT_SURFACE;
      WabTheme.accentColor    = WAB_LIGHT_ACCENT;
      WabTheme.onColor        = WAB_LIGHT_ON;
      WabTheme.offColor       = WAB_LIGHT_OFF;
      WabTheme.textColor      = WAB_LIGHT_TEXT;
      WabTheme.woodyColor     = WAB_LIGHT_WOODY;
      WabTheme.progressColor  = WAB_LIGHT_PROGRESS;
      WabTheme.mutedColor     = WAB_LIGHT_MUTED;
      WabTheme.scratchColor   = WAB_LIGHT_SCRATCH;
    } else {
      WabTheme.primaryColor   = primaryColor ?? WAB_DARK_PRIMARY;
      WabTheme.secondaryColor = secondaryColor ?? WAB_DARK_SECONDARY;
      WabTheme.backgroundColor = WAB_DARK_BACKGROUND;
      WabTheme.surfaceColor   = WAB_DARK_SURFACE;
      WabTheme.accentColor    = WAB_DARK_ACCENT;
      WabTheme.onColor        = WAB_DARK_ON;
      WabTheme.offColor       = WAB_DARK_OFF;
      WabTheme.textColor      = WAB_DARK_TEXT;
      WabTheme.woodyColor     = WAB_DARK_WOODY;
      WabTheme.progressColor  = WAB_DARK_PROGRESS;
      WabTheme.mutedColor     = WAB_DARK_MUTED;
      WabTheme.scratchColor   = WAB_DARK_SCRATCH;
    }

    WabTheme.hintColor = lightTheme
        ? WAB_LIGHT_TEXT.withOpacity(0.6)
        : WAB_DARK_TEXT.withOpacity(0.6);

    return base.copyWith(
      primaryColor: WabTheme.primaryColor,
      primaryContrastingColor: WabTheme.secondaryColor,
      barBackgroundColor: WabTheme.surfaceColor,
      scaffoldBackgroundColor: WabTheme.backgroundColor,
      textTheme: CupertinoTextThemeData(
        textStyle: TextStyle(
          color: WabTheme.textColor,
          fontFamilyFallback: kWabFontFallback,
        ),
        actionTextStyle: TextStyle(
          color: WabTheme.accentColor,
          fontFamilyFallback: kWabFontFallback,
        ),
        navTitleTextStyle: TextStyle(
          color: WabTheme.textColor,
          fontSize: 18,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.3,
          fontFamilyFallback: kWabFontFallback,
        ),
      ),
    );
  }
}
