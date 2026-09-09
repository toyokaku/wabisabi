import 'dart:math' as math;
import 'package:flutter/material.dart';

import '../theme/wab_theme.dart';
import '../tokens/texture.dart';

/// 宣紙纖維 — irregular pulp threads embedded in the sheet.
/// Fibres use varied angle, length, curvature and opacity; there is deliberately
/// no repeated horizontal stripe pattern.
class WabFiberTexture extends StatelessWidget {
  WabFiberTexture({super.key, this.isDark, this.child, this.seed = 731});

  final bool? isDark;
  final Widget? child;
  final int seed;

  @override
  Widget build(BuildContext context) => CustomPaint(
        painter: _FiberTexturePainter(
          isDark: isDark ?? WabTheme.isDark,
          seed: seed,
        ),
        child: child,
      );
}

class _FiberTexturePainter extends CustomPainter {
  const _FiberTexturePainter({required this.isDark, required this.seed});

  final bool isDark;
  final int seed;

  @override
  void paint(Canvas canvas, Size size) {
    final rnd = math.Random(seed);
    final area = (size.width * size.height / 2600).clamp(18, 170).round();
    final tint = isDark ? WAB_TEXTURE_FIBER_DARK : WAB_TEXTURE_FIBER_LIGHT;

    for (var i = 0; i < area; i++) {
      final x = rnd.nextDouble() * size.width;
      final y = rnd.nextDouble() * size.height;
      final angle = rnd.nextDouble() * math.pi * 2;
      final len = 5.0 + rnd.nextDouble() * 26;
      final bend = (rnd.nextDouble() - .5) * 8;
      final dx = math.cos(angle) * len;
      final dy = math.sin(angle) * len;
      final normalX = -math.sin(angle) * bend;
      final normalY = math.cos(angle) * bend;
      final path = Path()
        ..moveTo(x, y)
        ..quadraticBezierTo(
          x + dx * .48 + normalX,
          y + dy * .48 + normalY,
          x + dx,
          y + dy,
        );
      canvas.drawPath(
        path,
        Paint()
          ..color = tint.withOpacity(.08 + rnd.nextDouble() * .14)
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round
          ..strokeWidth = .35 + rnd.nextDouble() * .75,
      );
    }

    // Occasional compressed pulp knots make the material feel handmade.
    for (var i = 0; i < (area / 9).round(); i++) {
      final c = Offset(rnd.nextDouble() * size.width, rnd.nextDouble() * size.height);
      canvas.drawOval(
        Rect.fromCenter(
          center: c,
          width: 1.5 + rnd.nextDouble() * 5,
          height: .7 + rnd.nextDouble() * 2.2,
        ),
        Paint()..color = tint.withOpacity(.06 + rnd.nextDouble() * .08),
      );
    }
  }

  @override
  bool shouldRepaint(_FiberTexturePainter old) =>
      old.isDark != isDark || old.seed != seed;
}
