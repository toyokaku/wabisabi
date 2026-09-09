import 'dart:math' as math;
import 'package:flutter/material.dart';

import '../tokens/texture.dart';

/// 拓片 / 白文石面 — dense charcoal rubbing, stone bloom, rubbed paper fibres.
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
    if (size.isEmpty) return;
    final rnd = math.Random(seed);
    canvas.drawRect(Offset.zero & size, Paint()..color = WAB_TEXTURE_RUBBING_BASE);

    // Stone bloom: overlapping black and grey pressure patches.
    for (var i = 0; i < 16; i++) {
      final rx = math.max(8.0, size.width * (.07 + rnd.nextDouble() * .18));
      final ry = math.max(7.0, size.height * (.08 + rnd.nextDouble() * .20));
      canvas.drawOval(
        Rect.fromCenter(
          center: Offset(rnd.nextDouble() * size.width, rnd.nextDouble() * size.height),
          width: rx * 2,
          height: ry * 2,
        ),
        Paint()
          ..color = (i % 3 == 0 ? WAB_TEXTURE_RUBBING_DUST : WAB_TEXTURE_RUBBING_DEEP)
              .withOpacity(i % 3 == 0 ? .18 : .34)
          ..maskFilter = MaskFilter.blur(BlurStyle.normal, math.max(3, rx * .42)),
      );
    }

    // Rubbed pinholes / exposed stone.
    final specks = (size.width * size.height / 55).clamp(45, 1200).round();
    for (var i = 0; i < specks; i++) {
      final r = .25 + rnd.nextDouble() * (i % 17 == 0 ? 1.8 : .75);
      canvas.drawCircle(
        Offset(rnd.nextDouble() * size.width, rnd.nextDouble() * size.height),
        r,
        Paint()..color = WAB_TEXTURE_RUBBING_DUST.withOpacity(.07 + rnd.nextDouble() * .16),
      );
    }

    // Fibres and scratches from the rubbing paper.
    final fibres = (size.width * size.height / 720).clamp(20, 230).round();
    for (var i = 0; i < fibres; i++) {
      final p = Offset(rnd.nextDouble() * size.width, rnd.nextDouble() * size.height);
      final a = rnd.nextDouble() * math.pi * 2;
      final len = 5.0 + rnd.nextDouble() * 28;
      final end = p + Offset(math.cos(a) * len, math.sin(a) * len);
      final ctrl = Offset.lerp(p, end, .5)! + Offset((rnd.nextDouble() - .5) * 6, (rnd.nextDouble() - .5) * 6);
      canvas.drawPath(
        Path()..moveTo(p.dx, p.dy)..quadraticBezierTo(ctrl.dx, ctrl.dy, end.dx, end.dy),
        Paint()
          ..color = WAB_TEXTURE_RUBBING_FIBER.withOpacity(.06 + rnd.nextDouble() * .16)
          ..style = PaintingStyle.stroke
          ..strokeWidth = .35 + rnd.nextDouble() * .75,
      );
    }
  }

  @override
  bool shouldRepaint(_RubbingPainter old) => old.seed != seed;
}
