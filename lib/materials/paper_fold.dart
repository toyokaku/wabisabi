import 'dart:math' as math;
import 'package:flutter/material.dart';

import '../theme/wab_theme.dart';
import '../tokens/texture.dart';
import 'fiber_texture.dart';
import 'paper_texture.dart';

/// 紙摺 — a full-width folded strip with ridge, highlight and contact shadow.
class WabPaperFold extends StatelessWidget {
  WabPaperFold({
    super.key,
    this.child,
    this.width = double.infinity,
    this.height = 28,
    this.padding = EdgeInsets.zero,
    this.isDark,
    this.seed = 197,
  });

  final Widget? child;
  final double width;
  final double height;
  final EdgeInsets padding;
  final bool? isDark;
  final int seed;

  @override
  Widget build(BuildContext context) {
    final dark = isDark ?? WabTheme.isDark;
    return SizedBox(
      width: width,
      height: height,
      child: CustomPaint(
        painter: _PaperFoldPainter(isDark: dark, seed: seed),
        child: WabPaperTexture(
          isDark: dark,
          strength: .9,
          child: WabFiberTexture(
            isDark: dark,
            seed: seed + 1,
            strength: .7,
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
    if (size.isEmpty) return;
    final top = isDark ? const Color(0xFF343029) : const Color(0xFFF1ECE1);
    final center = isDark ? WAB_TEXTURE_PAPER_BASE_DARK : WAB_TEXTURE_PAPER_BASE_LIGHT;
    final bottom = isDark ? const Color(0xFF201D19) : const Color(0xFFD8D0C2);
    final crease = isDark ? WAB_TEXTURE_PAPER_CREASE_DARK : WAB_TEXTURE_PAPER_CREASE_LIGHT;
    final highlight = isDark ? WAB_TEXTURE_PAPER_HIGHLIGHT_DARK : WAB_TEXTURE_PAPER_HIGHLIGHT_LIGHT;

    canvas.drawRect(
      Offset.zero & size,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [top, center, center, bottom],
          stops: const [0, .34, .58, 1],
        ).createShader(Offset.zero & size),
    );

    final rnd = math.Random(seed);
    final ridgeY = size.height * .56;
    final ridge = Path()..moveTo(0, ridgeY);
    final shine = Path()..moveTo(0, ridgeY - 1.8);
    for (var x = 0.0; x <= size.width + 16; x += 14) {
      final wobble = (rnd.nextDouble() - .5) * 2.1;
      ridge.lineTo(x, ridgeY + wobble);
      shine.lineTo(x, ridgeY - 1.55 + wobble * .45);
    }
    canvas.drawPath(
      ridge,
      Paint()
        ..color = (isDark ? WAB_TEXTURE_FOLD_SHADOW_DARK : WAB_TEXTURE_FOLD_SHADOW_LIGHT)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.55
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 1.6),
    );
    canvas.drawPath(
      shine,
      Paint()
        ..color = highlight.withOpacity(isDark ? .20 : .82)
        ..style = PaintingStyle.stroke
        ..strokeWidth = .9,
    );
    canvas.drawLine(
      Offset(0, size.height - 1.0),
      Offset(size.width, size.height - 1.0),
      Paint()
        ..color = crease.withOpacity(isDark ? .38 : .42)
        ..strokeWidth = 1.1
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 1.0),
    );
  }

  @override
  bool shouldRepaint(_PaperFoldPainter old) => old.isDark != isDark || old.seed != seed;
}
