import 'dart:ui' as ui show Gradient;

import 'package:flutter/material.dart';

import '../theme/wab_theme.dart';
import '../tokens/material.dart';

/// 墨暈 ink wash — three fixed radial ink blobs for a page background.
/// The ink color follows the theme text color; per-blob opacities come from
/// the material tokens.
class WabInkWash extends CustomPainter {
  // Non-const by design: reads WabTheme.isDark at paint when isDark is null.
  WabInkWash({this.isDark});

  /// Theme override; defaults to the current `WabTheme.isDark` when painted.
  final bool? isDark;

  @override
  void paint(Canvas canvas, Size size) {
    final dark = isDark ?? WabTheme.isDark;
    final ink = WabTheme.textColor;
    void blob(Offset c, double r, double op, double sx, double sy) {
      final paint = Paint()
        ..shader = ui.Gradient.radial(c, r, [
          ink.withOpacity(op),
          ink.withOpacity(op * 0.4),
          ink.withOpacity(0),
        ], const [0.0, 0.55, 1.0]);
      canvas.save();
      canvas.translate(c.dx, c.dy);
      canvas.scale(sx, sy);
      canvas.translate(-c.dx, -c.dy);
      canvas.drawCircle(c, r, paint);
      canvas.restore();
    }

    blob(
        Offset(size.width * 0.88, size.height * 0.15),
        170,
        dark ? WAB_INK_WASH_OPACITY_DARK1 : WAB_INK_WASH_OPACITY_LIGHT1,
        1.25,
        0.8);
    blob(
        Offset(size.width * 0.95, size.height * 0.30),
        100,
        dark ? WAB_INK_WASH_OPACITY_DARK2 : WAB_INK_WASH_OPACITY_LIGHT2,
        1.1,
        0.9);
    blob(
        Offset(size.width * 0.06, size.height * 0.88),
        150,
        dark ? WAB_INK_WASH_OPACITY_DARK3 : WAB_INK_WASH_OPACITY_LIGHT3,
        1.3,
        0.75);
  }

  @override
  bool shouldRepaint(WabInkWash old) => old.isDark != isDark;
}
