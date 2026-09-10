import 'package:flutter/material.dart';

import '../theme/wab_theme.dart';
import 'wood_grain.dart';

/// 木板 — a rigid wood material form built on top of [WabWoodGrain].
///
/// This is intentionally different from a plain wood-grain surface: a slab has
/// a restrained physical edge, directional bevel light and a right/down contact
/// shadow. Use the flat [WabWoodGrain] painter when only surface texture is
/// desired.
class WabWoodSlab extends StatelessWidget {
  const WabWoodSlab({
    super.key,
    required this.child,
    this.isDark,
    this.seed = 201,
    this.lifted = true,
    this.showKnot = true,
    this.radius = 3.0,
  });

  final Widget child;
  final bool? isDark;
  final int seed;
  final bool lifted;
  final bool showKnot;
  final double radius;

  @override
  Widget build(BuildContext context) {
    final dark = isDark ?? WabTheme.isDark;
    final shape = BorderRadius.circular(radius);

    return Container(
      decoration: BoxDecoration(
        borderRadius: shape,
        boxShadow: lifted
            ? [
                // Tight contact shadow: gives the slab a physical footprint,
                // similar in weight to jade without making wood look polished.
                BoxShadow(
                  color: Colors.black.withOpacity(dark ? .30 : .17),
                  blurRadius: 3.2,
                  spreadRadius: -.35,
                  offset: const Offset(1.8, 2.5),
                ),
                // Soft lift behind the contact edge.
                BoxShadow(
                  color: Colors.black.withOpacity(dark ? .16 : .085),
                  blurRadius: 7.0,
                  spreadRadius: -1.0,
                  offset: const Offset(2.8, 4.0),
                ),
              ]
            : const <BoxShadow>[],
      ),
      child: ClipRRect(
        borderRadius: shape,
        child: CustomPaint(
          painter: WabWoodGrain(
            isDark: dark,
            seed: seed,
            showKnot: showKnot,
          ),
          foregroundPainter: _WoodSlabEdgePainter(dark: dark),
          child: child,
        ),
      ),
    );
  }
}

class _WoodSlabEdgePainter extends CustomPainter {
  const _WoodSlabEdgePainter({required this.dark});

  final bool dark;

  @override
  void paint(Canvas canvas, Size size) {
    if (size.isEmpty) return;

    final highlight = Colors.white.withOpacity(dark ? .09 : .27);
    final side = Colors.black.withOpacity(dark ? .29 : .20);
    final sideSoft = Colors.black.withOpacity(dark ? .13 : .085);

    // Wood should read as a slab, but with a noticeably smaller bevel than jade.
    // The upper/left face catches light; lower/right expose a narrow thickness.
    final topPaint = Paint()
      ..color = highlight
      ..strokeWidth = 1.15
      ..style = PaintingStyle.stroke;

    canvas.drawLine(
      const Offset(.9, .9),
      Offset(size.width - 1.2, .9),
      topPaint,
    );
    canvas.drawLine(
      const Offset(.9, .9),
      Offset(.9, size.height - 1.2),
      topPaint,
    );

    // A narrow side face instead of a single hairline. This is intentionally
    // subtler than the jade edge, but thick enough to survive small specimens.
    final bottomFace = Rect.fromLTWH(
      1.0,
      size.height - 1.75,
      (size.width - 2.75).clamp(0.0, size.width).toDouble(),
      1.75,
    );
    final rightFace = Rect.fromLTWH(
      size.width - 1.65,
      1.0,
      1.65,
      (size.height - 2.65).clamp(0.0, size.height).toDouble(),
    );

    canvas.drawRect(bottomFace, Paint()..color = side);
    canvas.drawRect(rightFace, Paint()..color = side);

    // Feather the side face inward so the bevel feels cut from wood rather than
    // drawn as a hard UI border.
    canvas.drawLine(
      Offset(1.1, size.height - 2.1),
      Offset(size.width - 2.0, size.height - 2.1),
      Paint()
        ..color = sideSoft
        ..strokeWidth = .7,
    );
    canvas.drawLine(
      Offset(size.width - 2.0, 1.1),
      Offset(size.width - 2.0, size.height - 2.0),
      Paint()
        ..color = sideSoft
        ..strokeWidth = .7,
    );
  }

  @override
  bool shouldRepaint(_WoodSlabEdgePainter old) => old.dark != dark;
}
