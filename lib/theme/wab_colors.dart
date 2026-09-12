import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../tokens/palette.dart';

/// The kit's palette, carried on [ThemeData] as a [ThemeExtension] instead of
/// on mutable statics.
///
/// Reach it with `WabTheme.of(context)`. Because it travels with the theme, an
/// app can hold a light and a dark one at once — `MaterialApp(theme:,
/// darkTheme:)` and `themeMode: system` work — and a widget that reads it
/// registers a dependency, so it rebuilds when the theme changes.
///
/// Field names match the old `WabTheme.<name>` statics exactly, so migrating a
/// call site is `WabTheme.textColor` to `WabTheme.of(context).textColor` and
/// nothing else.
@immutable
class WabColors extends ThemeExtension<WabColors> {
  const WabColors({
    required this.brightness,
    required this.primaryColor,
    required this.secondaryColor,
    required this.hintColor,
    required this.backgroundColor,
    required this.surfaceColor,
    required this.accentColor,
    required this.onColor,
    required this.offColor,
    required this.textColor,
    required this.woodyColor,
    required this.progressColor,
    required this.mutedColor,
    required this.scratchColor,
    required this.sealColor,
    required this.lineColor,
    required this.paperWhite,
    required this.mutedLight,
  });

  /// The day palette. [primaryColor] and [secondaryColor] may be overridden by
  /// the app; everything else is the kit's.
  factory WabColors.light({Color? primaryColor, Color? secondaryColor}) =>
      WabColors(
        brightness: Brightness.light,
        primaryColor: primaryColor ?? WAB_LIGHT_PRIMARY,
        secondaryColor: secondaryColor ?? WAB_LIGHT_SECONDARY,
        hintColor: WAB_LIGHT_TEXT.withOpacity(0.6),
        backgroundColor: WAB_LIGHT_BACKGROUND,
        surfaceColor: WAB_LIGHT_SURFACE,
        accentColor: WAB_LIGHT_ACCENT,
        onColor: WAB_LIGHT_ON,
        offColor: WAB_LIGHT_OFF,
        textColor: WAB_LIGHT_TEXT,
        woodyColor: WAB_LIGHT_WOODY,
        progressColor: WAB_LIGHT_PROGRESS,
        mutedColor: WAB_LIGHT_MUTED,
        scratchColor: WAB_LIGHT_SCRATCH,
        sealColor: WAB_LIGHT_SEAL,
        lineColor: WAB_LIGHT_LINE,
        paperWhite: WabiSabiColors.paperWhite,
        mutedLight: WabiSabiColors.mutedLight,
      );

  /// The night palette — 拓片 rather than 宣紙.
  factory WabColors.dark({Color? primaryColor, Color? secondaryColor}) =>
      WabColors(
        brightness: Brightness.dark,
        primaryColor: primaryColor ?? WAB_DARK_PRIMARY,
        secondaryColor: secondaryColor ?? WAB_DARK_SECONDARY,
        hintColor: WAB_DARK_TEXT.withOpacity(0.6),
        backgroundColor: WAB_DARK_BACKGROUND,
        surfaceColor: WAB_DARK_SURFACE,
        accentColor: WAB_DARK_ACCENT,
        onColor: WAB_DARK_ON,
        offColor: WAB_DARK_OFF,
        textColor: WAB_DARK_TEXT,
        woodyColor: WAB_DARK_WOODY,
        progressColor: WAB_DARK_PROGRESS,
        mutedColor: WAB_DARK_MUTED,
        scratchColor: WAB_DARK_SCRATCH,
        sealColor: WAB_DARK_SEAL,
        lineColor: WAB_DARK_LINE,
        paperWhite: WAB_DARK_PAPER,
        mutedLight: WAB_DARK_MUTED,
      );

  factory WabColors.of(BuildContext context) {
    final fromTheme = Theme.of(context).extension<WabColors>();
    if (fromTheme != null) return fromTheme;
    // A CupertinoApp carries no ThemeData extensions, so fall back to the
    // palette matching the ambient brightness.
    final brightness = CupertinoTheme.of(context).brightness ??
        MediaQuery.platformBrightnessOf(context);
    return brightness == Brightness.dark ? WabColors.dark() : WabColors.light();
  }

  final Brightness brightness;
  final Color primaryColor;
  final Color secondaryColor;
  final Color hintColor;
  final Color backgroundColor;
  final Color surfaceColor;
  final Color accentColor;
  final Color onColor;
  final Color offColor;
  final Color textColor;
  final Color woodyColor;
  final Color progressColor;
  final Color mutedColor;
  final Color scratchColor;
  final Color sealColor;
  final Color lineColor;
  final Color paperWhite;
  final Color mutedLight;

  bool get isDark => brightness == Brightness.dark;

  /// Drop shadow for ELEVATED surfaces — falls to the bottom-right. The stacked
  /// shadows (decreasing opacity, increasing blur) read as a soft gradient.
  List<BoxShadow> get elevationShadow {
    final base = isDark ? const Color(0xFF000000) : const Color(0xFF2E2A24);
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

  @override
  WabColors copyWith({
    Brightness? brightness,
    Color? primaryColor,
    Color? secondaryColor,
    Color? hintColor,
    Color? backgroundColor,
    Color? surfaceColor,
    Color? accentColor,
    Color? onColor,
    Color? offColor,
    Color? textColor,
    Color? woodyColor,
    Color? progressColor,
    Color? mutedColor,
    Color? scratchColor,
    Color? sealColor,
    Color? lineColor,
    Color? paperWhite,
    Color? mutedLight,
  }) =>
      WabColors(
        brightness: brightness ?? this.brightness,
        primaryColor: primaryColor ?? this.primaryColor,
        secondaryColor: secondaryColor ?? this.secondaryColor,
        hintColor: hintColor ?? this.hintColor,
        backgroundColor: backgroundColor ?? this.backgroundColor,
        surfaceColor: surfaceColor ?? this.surfaceColor,
        accentColor: accentColor ?? this.accentColor,
        onColor: onColor ?? this.onColor,
        offColor: offColor ?? this.offColor,
        textColor: textColor ?? this.textColor,
        woodyColor: woodyColor ?? this.woodyColor,
        progressColor: progressColor ?? this.progressColor,
        mutedColor: mutedColor ?? this.mutedColor,
        scratchColor: scratchColor ?? this.scratchColor,
        sealColor: sealColor ?? this.sealColor,
        lineColor: lineColor ?? this.lineColor,
        paperWhite: paperWhite ?? this.paperWhite,
        mutedLight: mutedLight ?? this.mutedLight,
      );

  @override
  WabColors lerp(ThemeExtension<WabColors>? other, double t) {
    if (other is! WabColors) return this;
    Color mix(Color a, Color b) => Color.lerp(a, b, t)!;
    return WabColors(
      // Brightness is a role, not a ramp: it flips at the halfway point rather
      // than blending, so materials never paint against an in-between theme.
      brightness: t < .5 ? brightness : other.brightness,
      primaryColor: mix(primaryColor, other.primaryColor),
      secondaryColor: mix(secondaryColor, other.secondaryColor),
      hintColor: mix(hintColor, other.hintColor),
      backgroundColor: mix(backgroundColor, other.backgroundColor),
      surfaceColor: mix(surfaceColor, other.surfaceColor),
      accentColor: mix(accentColor, other.accentColor),
      onColor: mix(onColor, other.onColor),
      offColor: mix(offColor, other.offColor),
      textColor: mix(textColor, other.textColor),
      woodyColor: mix(woodyColor, other.woodyColor),
      progressColor: mix(progressColor, other.progressColor),
      mutedColor: mix(mutedColor, other.mutedColor),
      scratchColor: mix(scratchColor, other.scratchColor),
      sealColor: mix(sealColor, other.sealColor),
      lineColor: mix(lineColor, other.lineColor),
      paperWhite: mix(paperWhite, other.paperWhite),
      mutedLight: mix(mutedLight, other.mutedLight),
    );
  }
}
