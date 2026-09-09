import 'dart:math' as math;
import 'package:flutter/material.dart';

import '../theme/wab_theme.dart';
import '../tokens/material.dart';
import '../tokens/texture.dart';

/// Paper has two public intensities: ordinary pulp and clouded mottle.
enum WabPaperTextureKind { paper, mottle }

/// 宣紙紙紋 — deterministic pulp, faint creases, flecks and optional 雲斑.
class WabPaperTexture extends StatelessWidget {
  WabPaperTexture({
    super.key,
    this.isDark,
    this.child,
    this.kind = WabPaperTextureKind.paper,
  });

  final bool? isDark;
  final Widget? child;
  final WabPaperTextureKind kind;

  @override
  Widget build(BuildContext context) => CustomPaint(
        painter: _PaperTexturePainter(
          isDark: isDark ?? WabTheme.isDark,
          kind: kind,
        ),
        child: child,
      );
}

class _PaperTexturePainter extends CustomPainter {
  const _PaperTexturePainter({required this.isDark, required this.kind});
  final bool isDark;
  final WabPaperTextureKind kind;

  @override
  void paint(Canvas canvas, Size size) {
    final rnd = math.Random(WAB_PAPER_TEXTURE_SEED + kind.index * 97);
    final area10k = size.width * size.height / 10000;
    final strong = kind == WabPaperTextureKind.mottle;

    final deepTint = isDark ? WAB_PAPER_MOTTLE_DEEP_DARK : WAB_PAPER_MOTTLE_DEEP_LIGHT;
    final paleTint = isDark ? WAB_PAPER_MOTTLE_SHEEN_DARK : WAB_PAPER_MOTTLE_PALE_LIGHT;
    final mottles = (area10k * (strong ? 1.1 : .42)).round().clamp(3, strong ? 15 : 8);
    for (var i = 0; i < mottles; i++) {
      final rx = size.width * (.09 + rnd.nextDouble() * (strong ? .26 : .17));
      final ry = size.height * (.08 + rnd.nextDouble() * (strong ? .23 : .15));
      canvas.drawOval(
        Rect.fromCenter(
          center: Offset(rnd.nextDouble() * size.width, rnd.nextDouble() * size.height),
          width: rx * 2,
          height: ry * 2,
        ),
        Paint()
          ..color = (i.isEven ? deepTint : paleTint).withOpacity(
            (strong ? .075 : .035) + rnd.nextDouble() * (strong ? .07 : .035),
          )
          ..maskFilter = MaskFilter.blur(BlurStyle.normal, math.max(8, rx * .48)),
      );
    }

    final crease = isDark ? WAB_TEXTURE_PAPER_CREASE_DARK : WAB_TEXTURE_PAPER_CREASE_LIGHT;
    final highlight = isDark ? WAB_TEXTURE_PAPER_HIGHLIGHT_DARK : WAB_TEXTURE_PAPER_HIGHLIGHT_LIGHT;
    final creaseCount = (area10k * (strong ? .55 : .28)).round().clamp(2, strong ? 12 : 7);
    for (var i = 0; i < creaseCount; i++) {
      final x0 = rnd.nextDouble() * size.width;
      final y0 = rnd.nextDouble() * size.height;
      final path = Path()..moveTo(x0, y0);
      var x = x0;
      var y = y0;
      for (var j = 0; j < 3; j++) {
        x = (x + (rnd.nextDouble() - .5) * size.width * .18).clamp(0, size.width);
        y = (y + (rnd.nextDouble() - .5) * size.height * .20).clamp(0, size.height);
        path.lineTo(x, y);
      }
      canvas.drawPath(
        path,
        Paint()
          ..color = crease.withOpacity(strong ? .09 : .045)
          ..style = PaintingStyle.stroke
          ..strokeWidth = .55,
      );
      canvas.save();
      canvas.translate(.8, -.7);
      canvas.drawPath(
        path,
        Paint()
          ..color = highlight.withOpacity(strong ? .15 : .075)
          ..style = PaintingStyle.stroke
          ..strokeWidth = .45,
      );
      canvas.restore();
    }

    final dots = (area10k * (isDark ? WAB_PAPER_DOT_DENSITY_DARK : WAB_PAPER_DOT_DENSITY_LIGHT))
        .round();
    final dotPaint = Paint()
      ..color = (isDark ? WAB_PAPER_TINT_DARK : WAB_PAPER_DOT_TINT_LIGHT)
          .withOpacity(isDark ? WAB_PAPER_DOT_OPACITY_DARK : WAB_PAPER_DOT_OPACITY_LIGHT);
    for (var i = 0; i < dots; i++) {
      canvas.drawCircle(
        Offset(rnd.nextDouble() * size.width, rnd.nextDouble() * size.height),
        .25 + rnd.nextDouble() * .7,
        dotPaint,
      );
    }
  }

  @override
  bool shouldRepaint(_PaperTexturePainter old) =>
      old.isDark != isDark || old.kind != kind;
}
