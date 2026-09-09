import 'package:flutter/material.dart';

import '../theme/wab_theme.dart';
import '../tokens/texture.dart';
import 'fiber_texture.dart';
import 'paper_texture.dart';

/// A large aged xuan sheet used as an application ground.
///
/// It combines one physical paper base, pulp/mottle, sparse fibres, edge aging
/// and optional broad fold lines. The ground stays quieter than material
/// specimens: it should support content rather than compete with it.
class WabPaperSheet extends StatelessWidget {
  WabPaperSheet({
    super.key,
    required this.child,
    this.isDark,
    this.horizontalFolds = const [.19, .47, .73],
    this.verticalFolds = const [.34, .67],
  });

  final Widget child;
  final bool? isDark;
  final List<double> horizontalFolds;
  final List<double> verticalFolds;

  @override
  Widget build(BuildContext context) {
    final dark = isDark ?? WabTheme.isDark;
    final base = dark ? WAB_TEXTURE_PAPER_BASE_DARK : WAB_TEXTURE_PAPER_BASE_LIGHT;
    return ColoredBox(
      color: base,
      child: Stack(
        children: [
          Positioned.fill(
            child: WabPaperTexture(
              isDark: dark,
              kind: WabPaperTextureKind.mottle,
              strength: dark ? .58 : .72,
            ),
          ),
          Positioned.fill(
            child: WabFiberTexture(
              isDark: dark,
              seed: 991,
              strength: dark ? .12 : .16,
            ),
          ),
          Positioned.fill(
            child: CustomPaint(
              painter: _SheetAgePainter(
                isDark: dark,
                horizontalFolds: horizontalFolds,
                verticalFolds: verticalFolds,
              ),
            ),
          ),
          child,
        ],
      ),
    );
  }
}

class _SheetAgePainter extends CustomPainter {
  const _SheetAgePainter({
    required this.isDark,
    required this.horizontalFolds,
    required this.verticalFolds,
  });

  final bool isDark;
  final List<double> horizontalFolds;
  final List<double> verticalFolds;

  @override
  void paint(Canvas canvas, Size size) {
    if (size.isEmpty) return;
    final shadow = isDark ? WAB_TEXTURE_PAPER_CREASE_DARK : WAB_TEXTURE_PAPER_CREASE_LIGHT;
    final light = isDark ? WAB_TEXTURE_PAPER_HIGHLIGHT_DARK : WAB_TEXTURE_PAPER_HIGHLIGHT_LIGHT;
    final age = isDark ? WAB_TEXTURE_PAPER_AGE_DARK : WAB_TEXTURE_PAPER_AGE_LIGHT;

    void hFold(double t) {
      final y = size.height * t.clamp(0.0, 1.0);
      final band = Rect.fromLTWH(0, y - 4, size.width, 9);
      canvas.drawRect(
        band,
        Paint()
          ..shader = LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.transparent,
              shadow.withOpacity(.07),
              shadow.withOpacity(.15),
              light.withOpacity(.22),
              Colors.transparent,
            ],
          ).createShader(band),
      );
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y + .35),
        Paint()
          ..color = shadow.withOpacity(.25)
          ..strokeWidth = .65,
      );
    }

    void vFold(double t) {
      final x = size.width * t.clamp(0.0, 1.0);
      final band = Rect.fromLTWH(x - 4, 0, 9, size.height);
      canvas.drawRect(
        band,
        Paint()
          ..shader = LinearGradient(
            colors: [
              Colors.transparent,
              shadow.withOpacity(.055),
              light.withOpacity(.18),
              Colors.transparent,
            ],
          ).createShader(band),
      );
      canvas.drawLine(
        Offset(x, 0),
        Offset(x + .3, size.height),
        Paint()
          ..color = shadow.withOpacity(.18)
          ..strokeWidth = .55,
      );
    }

    for (final y in horizontalFolds) hFold(y);
    for (final x in verticalFolds) vFold(x);

    final edge = Paint()..color = age.withOpacity(isDark ? .05 : .055);
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, 2.2), edge);
    canvas.drawRect(Rect.fromLTWH(0, size.height - 3.2, size.width, 3.2), edge);
    canvas.drawRect(Rect.fromLTWH(0, 0, 2.0, size.height), edge);
    canvas.drawRect(Rect.fromLTWH(size.width - 2.0, 0, 2.0, size.height), edge);
  }

  @override
  bool shouldRepaint(_SheetAgePainter old) =>
      old.isDark != isDark ||
      old.horizontalFolds != horizontalFolds ||
      old.verticalFolds != verticalFolds;
}
