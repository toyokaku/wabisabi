import 'package:flutter/material.dart';

import '../theme/wab_theme.dart';
import '../tokens/material.dart';
import 'deckle_border.dart';

/// 印章 seal mark — a logo-grade seal: 白文 solid block with inverse text,
/// or 朱文 thin-rule outline. The frame is deliberately not a perfect
/// rectangle: small corner radius plus a low-amplitude deckle wobble (stone
/// carving), fixed seed so it never flickers.
///
/// The glyph is 篆隸化文楷 — LXGW WenKai Medium flattened (scaleX ≈ 1.15,
/// 八分扁平) — and fills ~80% of the seal face.
class WabSealMark extends StatelessWidget {
  // Non-const by design: reads WabTheme at build.
  WabSealMark({
    super.key,
    required this.text,
    this.kind = WabSealMarkKind.baiwen,
    this.size = 48,
    this.seed = 5,
  });

  /// Glyph(s) carved into the seal — one or a few characters, or a short
  /// latin mark (e.g. 'FEY').
  final String text;

  /// 白文 solid (inverse text) or 朱文 outline.
  final WabSealMarkKind kind;

  /// Side length in px; seals are square-ish.
  final double size;

  /// Deckle seed — different seeds, different stable edges.
  final int seed;

  @override
  Widget build(BuildContext context) {
    final dark = WabTheme.isDark;
    final bai = kind == WabSealMarkKind.baiwen;
    final ink = WabTheme.textColor.withOpacity(
        dark ? WAB_ZHUWEN_OPACITY_DARK : WAB_ZHUWEN_OPACITY_LIGHT);
    final face = dark ? WAB_BAIWEN_FACE_DARK : WAB_BAIWEN_FACE_LIGHT;
    final glyphColor =
        bai ? (dark ? WAB_BAIWEN_TEXT_DARK : WAB_BAIWEN_TEXT_LIGHT) : ink;

    final shape = DeckleBorder(
      roughness: 0.8, // 石花崩邊——不規則但不破
      horizontalRoughness: 0.8,
      seed: seed,
      radius: 3, // 印章小圓角
      side: BorderSide(
        color: bai ? face : ink,
        width: bai ? 1.0 : WAB_ZHUWEN_RULE_WIDTH,
      ),
    );

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        children: [
          if (bai)
            Positioned.fill(
              child: ClipPath.shape(
                shape: shape,
                child: ColoredBox(color: face),
              ),
            ),
          Positioned.fill(
            child: CustomPaint(painter: _SealOutlinePainter(shape)),
          ),
          Padding(
            padding: EdgeInsets.all(size * 0.10), // 字佔印面 ~80%
            child: FittedBox(
              fit: BoxFit.contain,
              child: Transform.scale(
                scaleX: 1.15, // 八分扁平——篆隸之間
                child: Text(
                  text,
                  style: TextStyle(
                    color: glyphColor,
                    fontWeight: FontWeight.w700,
                    height: 1.0,
                    letterSpacing: 0,
                    fontFamilyFallback: kWabKaiFallback,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// 白文 solid block with inverse text; 朱文 thin-rule outline.
enum WabSealMarkKind { baiwen, zhuwen }

class _SealOutlinePainter extends CustomPainter {
  const _SealOutlinePainter(this.shape);

  final OutlinedBorder shape;

  @override
  void paint(Canvas canvas, Size size) {
    shape.paint(canvas, Offset.zero & size);
  }

  @override
  bool shouldRepaint(_SealOutlinePainter old) => old.shape != shape;
}
