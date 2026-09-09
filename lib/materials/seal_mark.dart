import 'package:flutter/material.dart';

import '../theme/wab_theme.dart';
import '../tokens/material.dart';
import 'cinnabar_texture.dart';
import 'deckle_border.dart';

/// Seal marks are cinnabar ink in both 白文 and 朱文 forms.
/// 白文 = cinnabar face with paper-coloured carved glyphs.
/// 朱文 = transparent paper face with cinnabar outline/glyphs.
class WabSealMark extends StatelessWidget {
  WabSealMark({
    super.key,
    required this.text,
    this.kind = WabSealMarkKind.baiwen,
    this.size = 48,
    this.seed = 5,
  });

  final String text;
  final WabSealMarkKind kind;
  final double size;
  final int seed;

  @override
  Widget build(BuildContext context) {
    final bai = kind == WabSealMarkKind.baiwen;
    final red = WabTheme.sealColor;
    final shape = DeckleBorder(
      roughness: .9,
      horizontalRoughness: .9,
      seed: seed,
      radius: 3,
      side: BorderSide(
        color: red,
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
                child: WabCinnabarTexture(
                  seed: seed * 17,
                  child: const SizedBox.expand(),
                ),
              ),
            ),
          Positioned.fill(
            child: CustomPaint(painter: _SealOutlinePainter(shape)),
          ),
          Padding(
            padding: EdgeInsets.all(size * .10),
            child: FittedBox(
              fit: BoxFit.contain,
              child: Transform.scale(
                scaleX: 1.12,
                child: Text(
                  text,
                  style: TextStyle(
                    color: bai ? WabTheme.paperWhite : red,
                    fontWeight: FontWeight.w700,
                    height: 1,
                    letterSpacing: 0,
                    fontFamilyFallback: kWabDisplayFallback,
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

enum WabSealMarkKind { baiwen, zhuwen }

class _SealOutlinePainter extends CustomPainter {
  const _SealOutlinePainter(this.shape);
  final OutlinedBorder shape;

  @override
  void paint(Canvas canvas, Size size) => shape.paint(canvas, Offset.zero & size);

  @override
  bool shouldRepaint(_SealOutlinePainter old) => old.shape != shape;
}
