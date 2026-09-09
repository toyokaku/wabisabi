import 'package:flutter/material.dart';

import '../theme/typography.dart';
import '../theme/wab_theme.dart';

/// 印體 — a readable seal-adjacent display treatment built from the bundled
/// WabKai face. The glyph is slightly widened/flattened and reinforced with a
/// thin ink stroke so it sits between regular kai and a carved clerical/seal
/// impression without depending on a platform font.
class WabSealText extends StatelessWidget {
  const WabSealText(
    this.text, {
    super.key,
    this.fontSize = 22,
    this.color,
    this.strokeWidth = .65,
    this.widthScale = 1.08,
    this.heightScale = .94,
  });

  final String text;
  final double fontSize;
  final Color? color;
  final double strokeWidth;
  final double widthScale;
  final double heightScale;

  @override
  Widget build(BuildContext context) {
    final ink = color ?? WabTheme.textColor;
    final base = TextStyle(
      fontFamily: kWabDisplayFamily,
      fontFamilyFallback: kWabKaiFallback,
      fontSize: fontSize,
      fontWeight: FontWeight.w500,
      height: .96,
      letterSpacing: .15,
    );

    return Transform.scale(
      scaleX: widthScale,
      scaleY: heightScale,
      alignment: Alignment.center,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Text(
            text,
            textAlign: TextAlign.center,
            style: base.copyWith(
              foreground: Paint()
                ..style = PaintingStyle.stroke
                ..strokeWidth = strokeWidth
                ..color = ink,
            ),
          ),
          Text(
            text,
            textAlign: TextAlign.center,
            style: base.copyWith(color: ink),
          ),
        ],
      ),
    );
  }
}
