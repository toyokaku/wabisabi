import 'dart:math' as math;
import 'package:flutter/material.dart';

import '../theme/wab_theme.dart';
import '../tokens/texture.dart';

/// 布紋 — visible indigo warp/weft with alternating thread relief and small
/// slubs. This is intentionally textile, not a blue fill.
class WabClothWeave extends CustomPainter {
  const WabClothWeave({this.isDark = false, this.seed = 509});

  final bool isDark;
  final int seed;

  @override
  void paint(Canvas canvas, Size size) {
    final rnd = math.Random(seed);
    final base = isDark ? WAB_TEXTURE_CLOTH_BASE_DARK : WAB_TEXTURE_CLOTH_BASE_LIGHT;
    final deep = isDark ? WAB_TEXTURE_CLOTH_DEEP_DARK : WAB_TEXTURE_CLOTH_DEEP_LIGHT;
    final thread = isDark ? WAB_TEXTURE_CLOTH_THREAD_DARK : WAB_TEXTURE_CLOTH_THREAD_LIGHT;
    canvas.drawRect(Offset.zero & size, Paint()..color = base);

    const pitch = 2.35;
    var i = 0;
    for (var x = 0.0; x <= size.width; x += pitch, i++) {
      canvas.drawLine(
        Offset(x, 0),
        Offset(x + math.sin(i * .7) * .45, size.height),
        Paint()
          ..color = (i.isEven ? thread : deep).withOpacity(i.isEven ? .22 : .34)
          ..strokeWidth = i % 5 == 0 ? .75 : .45,
      );
    }
    i = 0;
    for (var y = 0.0; y <= size.height; y += pitch, i++) {
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y + math.cos(i * .61) * .38),
        Paint()
          ..color = (i.isEven ? deep : thread).withOpacity(i.isEven ? .30 : .16)
          ..strokeWidth = i % 6 == 0 ? .72 : .42,
      );
    }

    final slubs = (size.width * size.height / 2400).clamp(5, 45).round();
    for (var s = 0; s < slubs; s++) {
      final x = rnd.nextDouble() * size.width;
      final y = rnd.nextDouble() * size.height;
      final len = 3.0 + rnd.nextDouble() * 10;
      canvas.drawLine(
        Offset(x, y),
        Offset(x + len, y + (rnd.nextDouble() - .5) * 1.5),
        Paint()
          ..color = thread.withOpacity(.10 + rnd.nextDouble() * .13)
          ..strokeWidth = .7 + rnd.nextDouble() * .7
          ..strokeCap = StrokeCap.round,
      );
    }
  }

  @override
  bool shouldRepaint(WabClothWeave old) =>
      old.isDark != isDark || old.seed != seed;
}

class WabClothTexture extends StatelessWidget {
  WabClothTexture({super.key, this.isDark, this.child, this.seed = 509});

  final bool? isDark;
  final Widget? child;
  final int seed;

  @override
  Widget build(BuildContext context) => CustomPaint(
        painter: WabClothWeave(
          isDark: isDark ?? WabTheme.isDark,
          seed: seed,
        ),
        child: child,
      );
}
