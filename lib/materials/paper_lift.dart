import 'package:flutter/material.dart';

import '../theme/wab_theme.dart';

/// 紙翹陰影 — an irregular contact shadow made by a slightly lifted paper edge.
///
/// Unlike a rectangular BoxShadow, the shadow bows and changes density along
/// the lower edge, matching a real sheet that is not perfectly flat.
class WabPaperLift extends StatelessWidget {
  const WabPaperLift({
    super.key,
    required this.child,
    this.depth = 8,
    this.seed = 31,
  });

  final Widget child;
  final double depth;
  final int seed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: depth),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: 2,
            right: 2,
            bottom: -depth * .72,
            height: depth * 1.45,
            child: IgnorePointer(
              child: CustomPaint(
                painter: _PaperLiftPainter(
                  dark: WabTheme.isDark,
                  seed: seed,
                ),
              ),
            ),
          ),
          child,
        ],
      ),
    );
  }
}

class _PaperLiftPainter extends CustomPainter {
  const _PaperLiftPainter({required this.dark, required this.seed});

  final bool dark;
  final int seed;

  @override
  void paint(Canvas canvas, Size size) {
    if (size.isEmpty) return;
    final phase = (seed % 17) / 17.0;
    final y = size.height * .18;

    final soft = Path()
      ..moveTo(0, y + 1.2)
      ..cubicTo(
        size.width * (.20 + phase * .04),
        y + 3.8,
        size.width * .38,
        y + 5.4,
        size.width * .54,
        y + 3.4,
      )
      ..cubicTo(
        size.width * .70,
        y + .7,
        size.width * (.83 - phase * .03),
        y + 4.8,
        size.width,
        y + 2.0,
      )
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    canvas.drawPath(
      soft,
      Paint()
        ..color = Colors.black.withOpacity(dark ? .27 : .115)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4.8),
    );

    final contact = Path()
      ..moveTo(0, y)
      ..cubicTo(size.width * .24, y + 1.5, size.width * .42, y + 2.4, size.width * .56, y + 1.0)
      ..cubicTo(size.width * .72, y - .2, size.width * .86, y + 1.9, size.width, y + .5);
    canvas.drawPath(
      contact,
      Paint()
        ..color = Colors.black.withOpacity(dark ? .24 : .105)
        ..style = PaintingStyle.stroke
        ..strokeWidth = .75
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 1.3),
    );
  }

  @override
  bool shouldRepaint(_PaperLiftPainter old) =>
      old.dark != dark || old.seed != seed;
}
