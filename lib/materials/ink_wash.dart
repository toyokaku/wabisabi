import 'dart:math' as math;
import 'package:flutter/material.dart';

import '../theme/wab_theme.dart';

/// 墨暈 — layered wet-ink clouds with soft capillary edges.
class WabInkWash extends CustomPainter {
  WabInkWash({this.isDark, this.seed = 943});

  final bool? isDark;
  final int seed;

  @override
  void paint(Canvas canvas, Size size) {
    final dark = isDark ?? WabTheme.isDark;
    final rnd = math.Random(seed);
    final ink = dark ? WabTheme.mutedLight : WabTheme.textColor;

    for (var i = 0; i < 9; i++) {
      final rx = size.width * (.10 + rnd.nextDouble() * .20);
      final ry = size.height * (.13 + rnd.nextDouble() * .25);
      final center = Offset(rnd.nextDouble() * size.width, rnd.nextDouble() * size.height);
      final op = (dark ? .055 : .07) + rnd.nextDouble() * (dark ? .06 : .10);
      canvas.drawOval(
        Rect.fromCenter(center: center, width: rx * 2, height: ry * 2),
        Paint()
          ..color = ink.withOpacity(op)
          ..maskFilter = MaskFilter.blur(BlurStyle.normal, math.min(rx, ry) * .42),
      );
    }

    // a few sharper wet edges stop the wash from reading as plain grey blur
    for (var i = 0; i < 4; i++) {
      final y = size.height * (.22 + i * .17);
      final path = Path()..moveTo(size.width * .08, y);
      for (var x = size.width * .08; x < size.width * .92; x += 13) {
        path.lineTo(x, y + math.sin(x * .035 + i) * 3.2);
      }
      canvas.drawPath(
        path,
        Paint()
          ..color = ink.withOpacity(dark ? .045 : .07)
          ..style = PaintingStyle.stroke
          ..strokeWidth = .65,
      );
    }
  }

  @override
  bool shouldRepaint(WabInkWash old) => old.isDark != isDark || old.seed != seed;
}
