import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../theme/wab_theme.dart';
import '../tokens/material.dart';

/// 筆觸線 brush divider — a flat, centered brush stroke: no wobble, the
/// thickness swells from a fine tip to full pressure mid-stroke and back
/// to a fine tip, like one pulled 毛筆 line. A fainter echo stroke sits
/// below it. The color defaults to the theme 淡墨 hairline
/// (`WabTheme.lineColor`).
///
/// This is the decorative divider; `WabDivider` stays the functional hairline.
class WabBrushDivider extends StatelessWidget {
  // Non-const by design: defaults color from WabTheme.lineColor at build.
  WabBrushDivider({super.key, this.color});

  /// Stroke color override; defaults to `WabTheme.lineColor`.
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 12,
      width: double.infinity,
      child: CustomPaint(
        painter: _BrushLinePainter(color ?? WabTheme.of(context).lineColor),
      ),
    );
  }
}

class _BrushLinePainter extends CustomPainter {
  const _BrushLinePainter(this.color);

  final Color color;

  /// One tapered stroke: flat baseline at [y], peak width [w], ink [op].
  /// The half-width profile follows sin(pi*t)^0.7 — blunt press mid-stroke,
  /// fine entry and exit tips.
  void _stroke(Canvas canvas, Size size, double y, double w, double op) {
    const steps = 64;
    final top = <Offset>[];
    final bottom = <Offset>[];
    for (var i = 0; i <= steps; i++) {
      final t = i / steps;
      final half = (w / 2) * math.pow(math.sin(math.pi * t), 0.7);
      final x = size.width * t;
      top.add(Offset(x, y - half));
      bottom.add(Offset(x, y + half));
    }
    final path = Path()
      ..addPolygon(top, false)
      ..addPolygon(bottom.reversed.toList(), false)
      ..close();
    canvas.drawPath(
      path,
      Paint()
        ..color = color.withValues(alpha: op)
        ..style = PaintingStyle.fill,
    );
  }

  @override
  void paint(Canvas canvas, Size size) {
    _stroke(canvas, size, WAB_BRUSH_STROKE_Y1, WAB_BRUSH_STROKE_WIDTH1,
        WAB_BRUSH_STROKE_OPACITY1);
    _stroke(canvas, size, WAB_BRUSH_STROKE_Y2, WAB_BRUSH_STROKE_WIDTH2,
        WAB_BRUSH_STROKE_OPACITY2);
  }

  @override
  bool shouldRepaint(_BrushLinePainter old) => old.color != color;
}
