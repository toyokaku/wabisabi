// The kit used to publish its palette to process-wide statics, assigned as a
// side effect of building a ThemeData. Two consequences this pins shut:
// an app could not hold a light and a dark theme at once, and a widget reading
// the palette registered no dependency, so it never rebuilt on a theme change.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wabisabi/wabisabi.dart';

void main() {
  testWidgets('theme and darkTheme each carry their own palette',
      (tester) async {
    late WabColors seen;

    Widget app(ThemeMode mode) => MaterialApp(
          theme: WabTheme.materialTheme(lightTheme: true),
          darkTheme: WabTheme.materialTheme(lightTheme: false),
          themeMode: mode,
          home: Builder(builder: (context) {
            seen = WabTheme.of(context);
            return const SizedBox.shrink();
          }),
        );

    await tester.pumpWidget(app(ThemeMode.light));
    await tester.pumpAndSettle();
    expect(seen.isDark, isFalse);
    final light = seen.backgroundColor;

    // MaterialApp animates between themes, so settle before reading: the
    // palette is lerped along with the rest of the ThemeData.
    await tester.pumpWidget(app(ThemeMode.dark));
    await tester.pumpAndSettle();
    expect(seen.isDark, isTrue);
    expect(seen.backgroundColor, isNot(light));
  });

  testWidgets('a widget reading the palette rebuilds when the theme changes',
      (tester) async {
    final seen = <Color>[];

    Widget app(bool dark) => MaterialApp(
          theme: WabTheme.materialTheme(lightTheme: !dark),
          home: Builder(builder: (context) {
            seen.add(WabTheme.of(context).textColor);
            return const SizedBox.shrink();
          }),
        );

    await tester.pumpWidget(app(false));
    await tester.pumpAndSettle();
    await tester.pumpWidget(app(true));
    await tester.pumpAndSettle();

    expect(seen.first, isNot(seen.last));
  });

  test('the palette lerps without ever landing on a half-lit brightness', () {
    final light = WabColors.light();
    final dark = WabColors.dark();

    expect(light.lerp(dark, 0).brightness, Brightness.light);
    expect(light.lerp(dark, .49).brightness, Brightness.light);
    expect(light.lerp(dark, .5).brightness, Brightness.dark);
    expect(light.lerp(dark, 1).backgroundColor, dark.backgroundColor);
  });
}
