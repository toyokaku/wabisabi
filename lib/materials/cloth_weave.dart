import 'dart:math' as math;
import 'package:flutter/material.dart';

import '../theme/wab_theme.dart';
import '../tokens/texture.dart';

/// 靛布布紋 — dense dyed warp/weft with small-scale over-under relief.
///
/// There are no stray white slub lines; irregularity comes from yarn spacing
/// and dye density so the swatch still reads as cloth when scaled down.
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

    // Subtle indigo dye variation below the weave.
    for (var i = 0; i < 5; i++) {
      final r = math.min(size.width, size.height) * (.16 + rnd.nextDouble() * .20);
      canvas.drawCircle(
        Offset(rnd.nextDouble() * size.width, rnd.nextDouble() * size.height),
        r,
        Paint()
          ..color = deep.withOpacity(.075 + rnd.nextDouble() * .045)
          ..maskFilter = MaskFilter.blur(BlurStyle.normal, math.max(4, r * .8)),
      );
    }

    // Smaller pitch than before: reads as woven cloth, not graph paper.
    const pitch = 1.85;
    var row = 0;
    for (var y = -pitch; y <= size.height + pitch; y += pitch, row++) {
      var col = 0;
      for (var x = -pitch; x <= size.width + pitch; x += pitch, col++) {
        final over = (row + col).isEven;
        final jy = (rnd.nextDouble() - .5) * .16;
        final jx = (rnd.nextDouble() - .5) * .14;

        canvas.drawLine(
          Offset(x + jx, y + jy),
          Offset(x + pitch * .94 + jx, y + jy),
          Paint()
            ..color = (over ? thread : deep).withOpacity(over ? .25 : .23)
            ..strokeWidth = over ? .54 : .42
            ..strokeCap = StrokeCap.round,
        );
        canvas.drawLine(
          Offset(x + pitch * .47 + jx, y - pitch * .47 + jy),
          Offset(x + pitch * .47 + jx, y + pitch * .47 + jy),
          Paint()
            ..color = (over ? deep : thread).withOpacity(over ? .21 : .24)
            ..strokeWidth = over ? .40 : .52
            ..strokeCap = StrokeCap.round,
        );
      }
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
