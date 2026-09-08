import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../tokens/material.dart';

/// 木紋 wood grain — sine grain lines + one knot + a lit top edge.
/// Base and deep colors come from the material tokens, chosen by [isDark].
/// Denser and finer than the RAG prototype (tight pitch, thin stroke).
///
/// Use as the background of a thick wooden surface:
/// `CustomPaint(painter: WabWoodGrain(isDark: WabTheme.isDark), child: ...)`.
class WabWoodGrain extends CustomPainter {
  const WabWoodGrain({this.isDark = false, this.seed = WAB_WOOD_SEED, this.showKnot = true});

  final bool isDark;

  /// Grain wobble seed.
  final double seed;

  /// Small surfaces (buttons) read better without a knot.
  final bool showKnot;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final base = isDark ? WAB_WOOD_BASE_DARK : WAB_WOOD_BASE_LIGHT;
    final deep = isDark ? WAB_WOOD_DEEP_DARK : WAB_WOOD_DEEP_LIGHT;

    canvas.drawRect(rect, Paint()..color = base);

    final grainPaint = Paint()
      ..color = deep.withOpacity(
          isDark ? WAB_WOOD_GRAIN_OPACITY_DARK : WAB_WOOD_GRAIN_OPACITY_LIGHT)
      ..style = PaintingStyle.stroke
      ..strokeWidth = WAB_WOOD_GRAIN_STROKE;
    final lines = (size.height / WAB_WOOD_GRAIN_SPACING).ceil();
    for (var i = 0; i < lines; i++) {
      final y0 = i * WAB_WOOD_GRAIN_SPACING + 1;
      final path = Path()..moveTo(0, y0);
      for (var x = 0.0; x <= size.width; x += WAB_WOOD_GRAIN_STEP) {
        final wobble = math.sin(x * 0.02 + i * 1.3 + seed) * 2.6 +
            math.sin(x * 0.061 + i * 0.7) * 1.2 +
            math.sin(x * 0.15 + i * 2.1) * 0.5;
        path.lineTo(x, y0 + wobble);
      }
      canvas.drawPath(path, grainPaint);
    }

    // One knot.
    if (showKnot) {
      final knotC = Offset(size.width * 0.70, size.height * 0.58);
      for (var r = 2.0; r < 17.0; r += 2.8) {
        canvas.drawOval(
          Rect.fromCenter(center: knotC, width: r * 2.5, height: r * 1.6),
          Paint()
            ..color = deep.withOpacity(WAB_WOOD_KNOT_OPACITY)
            ..style = PaintingStyle.stroke
            ..strokeWidth = 1.1,
        );
      }
    }

    // Lit top edge.
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, 1.5),
      Paint()
        ..color = Colors.white.withOpacity(
            isDark ? WAB_WOOD_EDGE_OPACITY_DARK : WAB_WOOD_EDGE_OPACITY_LIGHT),
    );
  }

  @override
  bool shouldRepaint(WabWoodGrain old) =>
      old.isDark != isDark || old.seed != seed || old.showKnot != showKnot;
}
