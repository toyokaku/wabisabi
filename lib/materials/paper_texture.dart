import 'dart:math' as math;
import 'package:flutter/material.dart';

import '../theme/wab_theme.dart';
import '../tokens/material.dart';
import '../tokens/texture.dart';

enum WabPaperTextureKind { paper, mottle }

/// 宣紙紙紋 — pulp clouds, tiny inclusions and sparse shallow dry creases.
class WabPaperTexture extends StatelessWidget {
  WabPaperTexture({
    super.key,
    this.isDark,
    this.child,
    this.kind = WabPaperTextureKind.paper,
    this.strength = 1,
  });

  final bool? isDark;
  final Widget? child;
  final WabPaperTextureKind kind;
  final double strength;

  @override
  Widget build(BuildContext context) => CustomPaint(
        painter: _PaperTexturePainter(
          isDark: isDark ?? WabTheme.isDark,
          kind: kind,
          strength: strength,
        ),
        child: child,
      );
}

class _PaperTexturePainter extends CustomPainter {
  const _PaperTexturePainter({
    required this.isDark,
    required this.kind,
    required this.strength,
  });

  final bool isDark;
  final WabPaperTextureKind kind;
  final double strength;

  @override
  void paint(Canvas canvas, Size size) {
    if (size.isEmpty) return;
    final rnd = math.Random(WAB_PAPER_TEXTURE_SEED + kind.index * 97);
    final area10k = size.width * size.height / 10000;
    final strong = kind == WabPaperTextureKind.mottle;
    final deep = isDark ? WAB_TEXTURE_PAPER_PULP_DARK : WAB_TEXTURE_PAPER_PULP_LIGHT;
    final age = isDark ? WAB_TEXTURE_PAPER_AGE_DARK : WAB_TEXTURE_PAPER_AGE_LIGHT;
    final pale = isDark
        ? WAB_TEXTURE_PAPER_HIGHLIGHT_DARK
        : WAB_TEXTURE_PAPER_HIGHLIGHT_LIGHT;

    final clouds = (area10k * (strong ? 1.65 : .78))
        .round()
        .clamp(4, strong ? 24 : 14);
    for (var i = 0; i < clouds; i++) {
      final rx = size.width * (.07 + rnd.nextDouble() * (strong ? .28 : .20));
      final ry = size.height * (.06 + rnd.nextDouble() * (strong ? .25 : .17));
      final tone = i % 3 == 0 ? age : (i.isEven ? deep : pale);
      final opacity =
          ((strong ? .09 : .055) + rnd.nextDouble() * (strong ? .11 : .065)) *
              strength;
      canvas.drawOval(
        Rect.fromCenter(
          center: Offset(
            rnd.nextDouble() * size.width,
            rnd.nextDouble() * size.height,
          ),
          width: math.max(16, rx * 2),
          height: math.max(12, ry * 2),
        ),
        Paint()
          ..color = tone.withOpacity(opacity.clamp(0, .32))
          ..maskFilter = MaskFilter.blur(
            BlurStyle.normal,
            math.max(5, rx * .42),
          ),
      );
    }

    final inclusions =
        (area10k * (strong ? 18 : 11)).round().clamp(10, 240);
    for (var i = 0; i < inclusions; i++) {
      final c = Offset(
        rnd.nextDouble() * size.width,
        rnd.nextDouble() * size.height,
      );
      final w = .45 + rnd.nextDouble() * 2.7;
      final h = .25 + rnd.nextDouble() * 1.15;
      canvas.save();
      canvas.translate(c.dx, c.dy);
      canvas.rotate((rnd.nextDouble() - .5) * 1.4);
      canvas.drawOval(
        Rect.fromCenter(center: Offset.zero, width: w, height: h),
        Paint()
          ..color = deep.withOpacity(
            (.07 + rnd.nextDouble() * .10) * strength,
          ),
      );
      canvas.restore();
    }

    // Structural folds belong to WabPaperSheet/WabPaperFold. These traces are
    // deliberately sparse so a material never reads as scratched plastic.
    final crease = isDark
        ? WAB_TEXTURE_PAPER_CREASE_DARK
        : WAB_TEXTURE_PAPER_CREASE_LIGHT;
    final highlight = isDark
        ? WAB_TEXTURE_PAPER_HIGHLIGHT_DARK
        : WAB_TEXTURE_PAPER_HIGHLIGHT_LIGHT;
    final count = (area10k * (strong ? .34 : .12))
        .round()
        .clamp(1, strong ? 8 : 3);
    for (var i = 0; i < count; i++) {
      final p0 = Offset(
        rnd.nextDouble() * size.width,
        rnd.nextDouble() * size.height,
      );
      final len = 10.0 +
          rnd.nextDouble() * math.min(58.0, size.shortestSide * .45);
      final a = rnd.nextDouble() * math.pi * 2;
      final p2 = p0 + Offset(math.cos(a) * len, math.sin(a) * len);
      final p1 = Offset.lerp(p0, p2, .5)! +
          Offset(
            (rnd.nextDouble() - .5) * 6,
            (rnd.nextDouble() - .5) * 6,
          );
      final path = Path()
        ..moveTo(p0.dx, p0.dy)
        ..quadraticBezierTo(p1.dx, p1.dy, p2.dx, p2.dy);
      canvas.drawPath(
        path,
        Paint()
          ..color = crease.withOpacity(.04 * strength)
          ..style = PaintingStyle.stroke
          ..strokeWidth = .45,
      );
      canvas.save();
      canvas.translate(.6, -.45);
      canvas.drawPath(
        path,
        Paint()
          ..color = highlight.withOpacity(.10 * strength)
          ..style = PaintingStyle.stroke
          ..strokeWidth = .38,
      );
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(_PaperTexturePainter old) =>
      old.isDark != isDark ||
      old.kind != kind ||
      old.strength != strength;
}
