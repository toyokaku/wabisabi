import 'dart:math' as math;
import 'package:flutter/material.dart';

import '../tokens/texture.dart';

/// 拓片 / 白文石面 — charcoal stone with pale rubbed fibres and scratches.
class WabRubbingTexture extends StatelessWidget {
  const WabRubbingTexture({super.key, this.child, this.seed = 613});

  final Widget? child;
  final int seed;

  @override
  Widget build(BuildContext context) => CustomPaint(
        painter: _RubbingPainter(seed),
        child: child,
      );
}

class _RubbingPainter extends CustomPainter {
  const _RubbingPainter(this.seed);
  final int seed;

  @override
  void paint(Canvas canvas, Size size) {
    final rnd = math.Random(seed);
    canvas.drawRect(Offset.zero & size, Paint()..color = WAB_TEXTURE_RUBBING_BASE);

    for (var i = 0; i < 9; i++) {
      final r = math.min(size.width, size.height) * (.10 + rnd.nextDouble() * .18);
      canvas.drawCircle(
        Offset(rnd.nextDouble() * size.width, rnd.nextDouble() * size.height),
        r,
        Paint()
          ..color = (i.isEven ? WAB_TEXTURE_RUBBING_DEEP : WAB_TEXTURE_RUBBING_DUST)
              .withOpacity(i.isEven ? .28 : .12)
          ..maskFilter = MaskFilter.blur(BlurStyle.normal, r * .55),
      );
    }

    final count = (size.width * size.height / 1800).clamp(16, 90).round();
    for (var i = 0; i < count; i++) {
      final x = rnd.nextDouble() * size.width;
      final y = rnd.nextDouble() * size.height;
      final len = 4.0 + rnd.nextDouble() * 20;
      final angle = rnd.nextDouble() * math.pi * 2;
      final path = Path()
        ..moveTo(x, y)
        ..quadraticBezierTo(
          x + math.cos(angle) * len * .5 + (rnd.nextDouble() - .5) * 5,
          y + math.sin(angle) * len * .5 + (rnd.nextDouble() - .5) * 5,
          x + math.cos(angle) * len,
          y + math.sin(angle) * len,
        );
      canvas.drawPath(
        path,
        Paint()
          ..color = WAB_TEXTURE_RUBBING_FIBER.withOpacity(.05 + rnd.nextDouble() * .13)
          ..style = PaintingStyle.stroke
          ..strokeWidth = .35 + rnd.nextDouble() * .65,
      );
    }
  }

  @override
  bool shouldRepaint(_RubbingPainter old) => old.seed != seed;
}
