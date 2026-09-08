import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../theme/wab_theme.dart';
import '../tokens/material.dart';

/// 紙紋 paper texture — a pure-painter overlay, fixed seed so it never
/// flickers across rebuilds. The texture is pure tonal 明暗, no lines:
///
/// 1. 雲斑 mottle — large soft blurred blotches in two tones. 晝: 茶經暗斑
///    + 淡黃亮斑 over the warm sheet; 夜: 拓片石光 + 陷影 over the ink ground.
/// 2. dots — sparse specks (紙筋 by day, 石花 by night).
///
/// 晝色實采茶經封面與 ab1189 淡黃漸變；夜色實采碑拓（224050）。
///
/// [isDark] defaults to `WabTheme.isDark`. Wrap a surface with it (typically
/// as a background layer in a `Stack`, or via `CustomPaint`).
class WabPaperTexture extends StatelessWidget {
  // Non-const by design: reads WabTheme.isDark at build — a const instance
  // would freeze the theme it was first built with.
  WabPaperTexture({super.key, this.isDark, this.child});

  /// Theme override; defaults to the current `WabTheme.isDark`.
  final bool? isDark;

  /// Optional child painted on top of the texture.
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _PaperTexturePainter(isDark: isDark ?? WabTheme.isDark),
      child: child,
    );
  }
}

class _PaperTexturePainter extends CustomPainter {
  const _PaperTexturePainter({this.isDark = false});

  final bool isDark;

  @override
  void paint(Canvas canvas, Size size) {
    final rnd = math.Random(WAB_PAPER_TEXTURE_SEED); // fixed seed, no flicker
    final area10k = size.width * size.height / 10000;

    // Layer 1 — 雲斑 mottle: big soft blotches, two tones alternating.
    final mottles =
        (area10k * WAB_PAPER_MOTTLE_DENSITY).round().clamp(4, 12);
    final deepTint =
        isDark ? WAB_PAPER_MOTTLE_DEEP_DARK : WAB_PAPER_MOTTLE_DEEP_LIGHT;
    final paleTint =
        isDark ? WAB_PAPER_MOTTLE_SHEEN_DARK : WAB_PAPER_MOTTLE_PALE_LIGHT;
    final deepOpacity = isDark
        ? WAB_PAPER_MOTTLE_OPACITY_DEEP_DARK
        : WAB_PAPER_MOTTLE_OPACITY_DEEP_LIGHT;
    final paleOpacity = isDark
        ? WAB_PAPER_MOTTLE_OPACITY_SHEEN_DARK
        : WAB_PAPER_MOTTLE_OPACITY_PALE_LIGHT;
    for (var i = 0; i < mottles; i++) {
      final cx = rnd.nextDouble() * size.width;
      final cy = rnd.nextDouble() * size.height;
      final rx = size.width * (0.18 + rnd.nextDouble() * 0.30);
      final ry = size.height * (0.15 + rnd.nextDouble() * 0.28);
      final deep = i.isEven;
      final paint = Paint()
        ..color = (deep ? deepTint : paleTint).withOpacity(
            (deep ? deepOpacity : paleOpacity) *
                (0.6 + rnd.nextDouble() * 0.6))
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, rx * 0.45);
      canvas.drawOval(
          Rect.fromCenter(center: Offset(cx, cy), width: rx * 2, height: ry * 2),
          paint);
    }

    // Layer 2 — dots: sparse specks, area-proportional so buttons stay as
    // calm as panels.
    final dots = (area10k *
            (isDark
                ? WAB_PAPER_DOT_DENSITY_DARK
                : WAB_PAPER_DOT_DENSITY_LIGHT))
        .round();
    final dotPaint = Paint()
      ..color = (isDark ? WAB_PAPER_TINT_DARK : WAB_PAPER_DOT_TINT_LIGHT)
          .withOpacity(isDark
              ? WAB_PAPER_DOT_OPACITY_DARK
              : WAB_PAPER_DOT_OPACITY_LIGHT);
    for (var i = 0; i < dots; i++) {
      final x = rnd.nextDouble() * size.width;
      final y = rnd.nextDouble() * size.height;
      canvas.drawCircle(Offset(x, y), rnd.nextDouble() * 0.9 + 0.3, dotPaint);
    }
  }

  @override
  bool shouldRepaint(_PaperTexturePainter old) => old.isDark != isDark;
}
