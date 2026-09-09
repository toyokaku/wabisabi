import 'dart:math' as math;
import 'package:flutter/material.dart';

import '../theme/wab_theme.dart';
import '../tokens/texture.dart';

/// 靛布布紋 — dyed warp/weft with over-under relief, uneven yarn and dye clouds.
class WabClothWeave extends CustomPainter {
  const WabClothWeave({this.isDark = false, this.seed = 509});

  final bool isDark;
  final int seed;

  @override
  void paint(Canvas canvas, Size size) {
    if (size.isEmpty) return;
    final rnd = math.Random(seed);
    final base = isDark ? WAB_TEXTURE_CLOTH_BASE_DARK : WAB_TEXTURE_CLOTH_BASE_LIGHT;
    final deep = isDark ? WAB_TEXTURE_CLOTH_DEEP_DARK : WAB_TEXTURE_CLOTH_DEEP_LIGHT;
    final thread = isDark ? WAB_TEXTURE_CLOTH_THREAD_DARK : WAB_TEXTURE_CLOTH_THREAD_LIGHT;
    canvas.drawRect(Offset.zero & size, Paint()..color = base);

    // Uneven indigo dye patches beneath the weave.
    for (var i = 0; i < 7; i++) {
      final r = math.min(size.width, size.height) * (.14 + rnd.nextDouble() * .24);
      canvas.drawCircle(
        Offset(rnd.nextDouble() * size.width, rnd.nextDouble() * size.height),
        r,
        Paint()
          ..color = (i.isEven ? deep : thread).withOpacity(i.isEven ? .18 : .07)
          ..maskFilter = MaskFilter.blur(BlurStyle.normal, math.max(4, r * .7)),
      );
    }

    const pitch = 3.05;
    // Draw short alternating segments instead of a perfect graph-paper grid.
    var row = 0;
    for (var y = -pitch; y <= size.height + pitch; y += pitch, row++) {
      var col = 0;
      for (var x = -pitch; x <= size.width + pitch; x += pitch, col++) {
        final over = (row + col).isEven;
        final jy = (rnd.nextDouble() - .5) * .35;
        final jx = (rnd.nextDouble() - .5) * .30;
        canvas.drawLine(
          Offset(x + jx, y + jy),
          Offset(x + pitch * .92 + jx, y + jy),
          Paint()
            ..color = (over ? thread : deep).withOpacity(over ? .38 : .31)
            ..strokeWidth = over ? .82 : .62
            ..strokeCap = StrokeCap.round,
        );
        canvas.drawLine(
          Offset(x + pitch * .48 + jx, y - pitch * .48 + jy),
          Offset(x + pitch * .48 + jx, y + pitch * .48 + jy),
          Paint()
            ..color = (over ? deep : thread).withOpacity(over ? .29 : .34)
            ..strokeWidth = over ? .58 : .76
            ..strokeCap = StrokeCap.round,
        );
      }
    }

    final slubs = (size.width * size.height / 1500).clamp(8, 70).round();
    for (var i = 0; i < slubs; i++) {
      final x = rnd.nextDouble() * size.width;
      final y = rnd.nextDouble() * size.height;
      final len = 4.0 + rnd.nextDouble() * 13;
      canvas.drawLine(
        Offset(x, y),
        Offset(x + len, y + (rnd.nextDouble() - .5) * 1.7),
        Paint()
          ..color = thread.withOpacity(.13 + rnd.nextDouble() * .18)
          ..strokeWidth = .75 + rnd.nextDouble() * 1.1
          ..strokeCap = StrokeCap.round,
      );
    }
  }

  @override
  bool shouldRepaint(WabClothWeave old) => old.isDark != isDark || old.seed != seed;
}

class WabClothTexture extends StatelessWidget {
  WabClothTexture({super.key, this.isDark, this.child, this.seed = 509});
  final bool? isDark;
  final Widget? child;
  final int seed;

  @override
  Widget build(BuildContext context) => CustomPaint(
        painter: WabClothWeave(isDark: isDark ?? WabTheme.isDark, seed: seed),
        child: child,
      );
}
