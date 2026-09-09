import 'dart:math' as math;
import 'package:flutter/material.dart';

import '../theme/wab_theme.dart';
import '../tokens/texture.dart';

/// 宣紙纖維 — sparse plant fibres, broken pulp strands and compressed knots.
class WabFiberTexture extends StatelessWidget {
  WabFiberTexture({
    super.key,
    this.isDark,
    this.child,
    this.seed = 731,
    this.strength = 1,
  });

  final bool? isDark;
  final Widget? child;
  final int seed;
  final double strength;

  @override
  Widget build(BuildContext context) => CustomPaint(
        painter: _FiberTexturePainter(
          isDark: isDark ?? WabTheme.isDark,
          seed: seed,
          strength: strength,
        ),
        child: child,
      );
}

class _FiberTexturePainter extends CustomPainter {
  const _FiberTexturePainter({
    required this.isDark,
    required this.seed,
    required this.strength,
  });

  final bool isDark;
  final int seed;
  final double strength;

  @override
  void paint(Canvas canvas, Size size) {
    if (size.isEmpty) return;
    final rnd = math.Random(seed);
    final count = (size.width * size.height / 2400).clamp(12, 150).round();
    final tint = isDark ? WAB_TEXTURE_FIBER_DARK : WAB_TEXTURE_FIBER_LIGHT;
    final pale = isDark
        ? WAB_TEXTURE_PAPER_HIGHLIGHT_DARK
        : WAB_TEXTURE_PAPER_HIGHLIGHT_LIGHT;

    for (var i = 0; i < count; i++) {
      final x = rnd.nextDouble() * size.width;
      final y = rnd.nextDouble() * size.height;
      final angle = rnd.nextDouble() * math.pi * 2;
      final len = (i % 9 == 0 ? 14.0 : 5.0) +
          rnd.nextDouble() * (i % 9 == 0 ? 34 : 19);
      final dx = math.cos(angle) * len;
      final dy = math.sin(angle) * len;
      final bend = (rnd.nextDouble() - .5) * 7;
      final path = Path()
        ..moveTo(x, y)
        ..quadraticBezierTo(
          x + dx * .42 - math.sin(angle) * bend,
          y + dy * .42 + math.cos(angle) * bend,
          x + dx,
          y + dy,
        );
      final opacity = (.07 + rnd.nextDouble() * .11) * strength;
      canvas.drawPath(
        path,
        Paint()
          ..color = (i % 5 == 0 ? pale : tint)
              .withOpacity(opacity.clamp(0, .28))
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round
          ..strokeWidth = .32 + rnd.nextDouble() * .72,
      );
    }

    for (var i = 0; i < (count / 10).round(); i++) {
      final c = Offset(
        rnd.nextDouble() * size.width,
        rnd.nextDouble() * size.height,
      );
      canvas.drawOval(
        Rect.fromCenter(
          center: c,
          width: 1.5 + rnd.nextDouble() * 5,
          height: .6 + rnd.nextDouble() * 2,
        ),
        Paint()
          ..color = tint.withOpacity(
            (.07 + rnd.nextDouble() * .08) * strength,
          ),
      );
    }
  }

  @override
  bool shouldRepaint(_FiberTexturePainter old) =>
      old.isDark != isDark ||
      old.seed != seed ||
      old.strength != strength;
}
