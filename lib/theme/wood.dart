import 'package:flutter/material.dart';
import 'wab_theme.dart';

/// Paints a subtle wood-grain background behind [child], using the theme's
/// [WabTheme.woodColor] (light wood in the light theme, dark wood in the dark).
/// Used for framing surfaces like the banner and the sidebar.
class WabWood extends StatelessWidget {
  const WabWood({super.key, required this.child, this.grain = Axis.vertical});

  final Widget child;

  /// Direction the grain lines run.
  final Axis grain;

  @override
  Widget build(BuildContext context) => CustomPaint(
        painter: _WabWoodPainter(base: WabTheme.woodColor, grain: grain),
        child: child,
      );
}

class _WabWoodPainter extends CustomPainter {
  _WabWoodPainter({required this.base, required this.grain});

  final Color base;
  final Axis grain;

  double _r(int a, int b) =>
      ((a * 1664525 + b * 1013904223 + 42) & 0x7FFFFFFF) / 0x7FFFFFFF;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(Offset.zero & size, Paint()..color = base);

    final dark = Color.lerp(base, Colors.black, 0.30)!;
    final light = Color.lerp(base, Colors.white, 0.12)!;
    final stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.1;

    if (grain == Axis.vertical) {
      for (double x = 0; x < size.width; x += 3 + _r(x.toInt(), 1) * 5) {
        final shade = _r(x.toInt(), 2);
        stroke.color =
            (shade > 0.72 ? light : dark).withOpacity(0.05 + shade * 0.10);
        final path = Path()..moveTo(x, 0);
        for (double y = 0; y < size.height; y += 26) {
          final wob = (_r(x.toInt(), y.toInt()) - 0.5) * 3;
          path.lineTo(x + wob, y + 26);
        }
        canvas.drawPath(path, stroke);
      }
    } else {
      for (double y = 0; y < size.height; y += 3 + _r(y.toInt(), 1) * 5) {
        final shade = _r(y.toInt(), 2);
        stroke.color =
            (shade > 0.72 ? light : dark).withOpacity(0.05 + shade * 0.10);
        final path = Path()..moveTo(0, y);
        for (double x = 0; x < size.width; x += 26) {
          final wob = (_r(y.toInt(), x.toInt()) - 0.5) * 3;
          path.lineTo(x + 26, y + wob);
        }
        canvas.drawPath(path, stroke);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _WabWoodPainter old) =>
      old.base != base || old.grain != grain;
}
