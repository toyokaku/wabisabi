import 'package:flutter/material.dart';

import '../theme/wab_theme.dart';
import '../tokens/material.dart';

/// 布紋 cloth weave — 漢服材質. Two perpendicular sets of fine lines at a
/// tight pitch, denser than the RAG prototype's textures. Base/deep colors
/// come from the material tokens, chosen by [isDark].
///
/// The painter fills whatever area it is given; clip with a deckle shape
/// when used on a wavy-edged cloth surface.
class WabClothWeave extends CustomPainter {
  const WabClothWeave({this.isDark = false});

  final bool isDark;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final base = isDark ? WAB_CLOTH_BASE_DARK : WAB_CLOTH_BASE_LIGHT;
    final deep = isDark ? WAB_CLOTH_DEEP_DARK : WAB_CLOTH_DEEP_LIGHT;
    final op =
        isDark ? WAB_CLOTH_WEAVE_OPACITY_DARK : WAB_CLOTH_WEAVE_OPACITY_LIGHT;

    canvas.drawRect(rect, Paint()..color = base);

    final weave = Paint()
      ..color = deep.withOpacity(op)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.6;
    // Warp (vertical) and weft (horizontal) at a fine pitch.
    for (var x = 0.0; x <= size.width; x += WAB_CLOTH_WEAVE_SPACING) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), weave);
    }
    final weft = Paint()
      ..color = deep.withOpacity(op * 0.8)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.6;
    for (var y = 0.0; y <= size.height; y += WAB_CLOTH_WEAVE_SPACING) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), weft);
    }
  }

  @override
  bool shouldRepaint(WabClothWeave old) => old.isDark != isDark;
}

/// Convenience overlay widget form of [WabClothWeave], mirroring
/// [WabPaperTexture]. [isDark] defaults to `WabTheme.isDark`.
class WabClothTexture extends StatelessWidget {
  // Non-const by design: reads WabTheme.isDark at build.
  WabClothTexture({super.key, this.isDark, this.child});

  final bool? isDark;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: WabClothWeave(isDark: isDark ?? WabTheme.isDark),
      child: child,
    );
  }
}
