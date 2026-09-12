import 'dart:math' as math;
import 'package:flutter/material.dart';

import '../theme/wab_theme.dart';

/// 墨暈 — layered wet-ink clouds with soft capillary spread.
///
/// No scratch or contour lines are drawn; the material reads through density,
/// overlap and blur alone.
class WabInkWash extends CustomPainter {
  /// Resolves the theme once, at construction, so [shouldRepaint] can compare
  /// what the painter will actually draw with. Reading the theme inside
  /// [paint] leaves a stale wash behind when light/dark flips.
  factory WabInkWash({bool? isDark, int seed = 943}) {
    final dark = isDark ?? WabTheme.isDark;
    return WabInkWash._(
      dark,
      dark ? WabTheme.mutedLight : WabTheme.textColor,
      seed,
    );
  }

  const WabInkWash._(this.isDark, this.ink, this.seed);

  final bool isDark;

  /// The wash colour, resolved from the theme at construction.
  final Color ink;
  final int seed;

  @override
  void paint(Canvas canvas, Size size) {
    final dark = isDark;
    final rnd = math.Random(seed);

    for (var i = 0; i < 9; i++) {
      final rx = size.width * (.10 + rnd.nextDouble() * .20);
      final ry = size.height * (.13 + rnd.nextDouble() * .25);
      final center = Offset(rnd.nextDouble() * size.width, rnd.nextDouble() * size.height);
      final op = (dark ? .050 : .065) + rnd.nextDouble() * (dark ? .05 : .085);
      canvas.drawOval(
        Rect.fromCenter(center: center, width: rx * 2, height: ry * 2),
        Paint()
          ..color = ink.withOpacity(op)
          ..maskFilter = MaskFilter.blur(BlurStyle.normal, math.min(rx, ry) * .46),
      );
    }

    // A few lighter bloom centers create water-loaded edges without linework.
    for (var i = 0; i < 3; i++) {
      final r = math.min(size.width, size.height) * (.08 + rnd.nextDouble() * .10);
      canvas.drawCircle(
        Offset(rnd.nextDouble() * size.width, rnd.nextDouble() * size.height),
        r,
        Paint()
          ..color = (dark ? Colors.black : Colors.white).withOpacity(dark ? .035 : .10)
          ..maskFilter = MaskFilter.blur(BlurStyle.normal, r * .65),
      );
    }
  }

  @override
  bool shouldRepaint(WabInkWash old) =>
      old.isDark != isDark || old.ink != ink || old.seed != seed;
}
