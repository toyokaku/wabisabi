import 'package:flutter/material.dart';

import 'wab_theme.dart';

/// Registered package family names. Use these as the primary family; fallback
/// lists are only a last resort. This keeps CJK glyphs from switching between
/// platform fonts when the system default already covers the character.
const String kWabKaiFamily = 'packages/wabisabi/WabKai';
const String kWabDisplayFamily = 'packages/wabisabi/WabKai';
const String kWabMonoFamily = 'packages/wabisabi/WabMono';

/// Enforces the bundled Wabisabi face across a subtree, including Material
/// controls that take their text style from ThemeData.
class WabTypographyScope extends StatelessWidget {
  const WabTypographyScope({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme.apply(
      fontFamily: kWabKaiFamily,
      fontFamilyFallback: kWabKaiFallback,
    );
    return Theme(
      data: theme.copyWith(textTheme: textTheme),
      child: DefaultTextStyle.merge(
        style: const TextStyle(
          fontFamily: kWabKaiFamily,
          fontFamilyFallback: kWabKaiFallback,
        ),
        child: child,
      ),
    );
  }
}
