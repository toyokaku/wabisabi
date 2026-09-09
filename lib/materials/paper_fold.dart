import 'dart:math' as math;
import 'package:flutter/material.dart';

import '../theme/wab_theme.dart';
import '../tokens/texture.dart';
import 'fiber_texture.dart';

/// 紙摺 — a narrow folded-paper specimen with a real crease ridge and underside
/// shadow. It has no outline or white frame; the material itself defines its edge.
class WabPaperFold extends StatelessWidget {
  WabPaperFold({
    super.key,
    this.child,
    this.height = 26,
    this.padding = EdgeInsets.zero,
    this.isDark,
    this.seed = 197,
  });

  final Widget? child;
  final double height;
  final EdgeInsets padding;
  final bool? isDark;
  final int seed;

  @override
  Widget build(BuildContext context) {
    final dark = isDark ?? WabTheme.isDark;
    return SizedBox(
      height: height,
      child: ClipRect(
        child: CustomPaint(
          painter: _PaperFoldPainter(isDark: dark, seed: seed),
          child: WabFiberTexture(
            isDark: dark,
            seed: seed + 1,
            child: Padding(padding: padding, child: child),
          ),
        ),
      ),
    );
  }
}

class _PaperFoldPainter extends CustomPainter {
  const _PaperFoldPainter({required this.isDark, required this.seed});
  final bool isDark;
  final int seed;

  @override
  void paint(Canvas canvas, Size size) {
    final base = isDark ? const Color(0xFF2B2822) : const Color(0xFFF3EFE5);
    final upper = isDark ? const Color(0xFF35312A) : const Color(0xFFFBF8F0);
    final lower = isDark ? const Color(0xFF211F1A) : const Color(0xFFE7E1D5);
    final crease = isDark ? WAB_TEXTURE_PAPER_CREASE_DARK : WAB_TEXTURE_PAPER_CREASE_LIGHT;
    final highlight = isDark ? WAB_TEXTURE_PAPER_HIGHLIGHT_DARK : WAB_TEXTURE_PAPER_HIGHLIGHT_LIGHT;

    canvas.drawRect(
      Offset.zero & size,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [upper, base, lower],
          stops: const [0, .48, 1],
        ).createShader(Offset.zero & size),
    );

    final rnd = math.Random(seed);
    final y = size.height * .58;
    final creasePath = Path()..moveTo(0, y);
    final highlightPath = Path()..moveTo(0, y - 1.2);
    for (var x = 0.0; x <= size.width + 8; x += 18) {
      final wobble = (rnd.nextDouble() - .5) * 1.5;
      creasePath.lineTo(x, y + wobble);
      highlightPath.lineTo(x, y - 1.1 + wobble * .45);
    }

    canvas.drawPath(
      creasePath,
      Paint()
        ..color = (isDark ? WAB_TEXTURE_FOLD_SHADOW_DARK : WAB_TEXTURE_FOLD_SHADOW_LIGHT)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.1
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 1.4),
    );
    canvas.drawPath(
      highlightPath,
      Paint()
        ..color = highlight.withOpacity(isDark ? .18 : .75)
        ..style = PaintingStyle.stroke
        ..strokeWidth = .8,
    );

    // thin underside contact shadow gives the fold physical thickness
    canvas.drawLine(
      Offset(0, size.height - .8),
      Offset(size.width, size.height - .8),
      Paint()
        ..color = crease.withOpacity(isDark ? .35 : .28)
        ..strokeWidth = .8
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, .7),
    );
  }

  @override
  bool shouldRepaint(_PaperFoldPainter old) =>
      old.isDark != isDark || old.seed != seed;
}
