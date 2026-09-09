import 'package:flutter/material.dart';

import '../theme/wab_theme.dart';
import '../tokens/material.dart';
import '../tokens/spacing.dart';
import 'cloth_weave.dart';
import 'deckle_surface.dart';
import 'ink_wash.dart';
import 'paper_texture.dart';
import 'wood_grain.dart';

/// Surface vocabulary used by the golden design board.
///
/// These are material semantics rather than decorative presets: consumers ask
/// for paper, fiber, rubbing, patina, etc. and do not need to know which painter
/// or theme token creates the effect.
enum WabSurfaceKind {
  paper,
  fiber,
  mottle,
  woodGrain,
  clothWeave,
  jadeSheen,
  rubbing,
  inkWash,
  patina,
  deckle,
}

/// A reusable material surface. It sizes itself to [child].
class WabSurface extends StatelessWidget {
  WabSurface({
    super.key,
    required this.kind,
    required this.child,
    this.padding = EdgeInsets.zero,
    this.isDark,
    this.clip = true,
  });

  final WabSurfaceKind kind;
  final Widget child;
  final EdgeInsets padding;
  final bool? isDark;
  final bool clip;

  @override
  Widget build(BuildContext context) {
    final dark = isDark ?? WabTheme.isDark;
    final content = Padding(padding: padding, child: child);

    Widget surface = switch (kind) {
      WabSurfaceKind.paper => ColoredBox(
          color: WabTheme.paperWhite,
          child: content,
        ),
      WabSurfaceKind.fiber => ColoredBox(
          color: WabTheme.paperWhite,
          child: CustomPaint(
            painter: _FiberPainter(dark: dark),
            child: content,
          ),
        ),
      WabSurfaceKind.mottle => ColoredBox(
          color: WabTheme.paperWhite,
          child: WabPaperTexture(isDark: dark, child: content),
        ),
      WabSurfaceKind.woodGrain => CustomPaint(
          painter: WabWoodGrain(isDark: dark),
          child: content,
        ),
      WabSurfaceKind.clothWeave =>
        WabClothTexture(isDark: dark, child: content),
      WabSurfaceKind.jadeSheen => DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.alphaBlend(
                  Colors.white.withOpacity(dark
                      ? WAB_JADE_SHEEN_OPACITY_DARK
                      : WAB_JADE_SHEEN_OPACITY_LIGHT),
                  dark ? WAB_JADE_BASE_DARK : WAB_JADE_BASE_LIGHT,
                ),
                dark ? WAB_JADE_BASE_DARK : WAB_JADE_BASE_LIGHT,
                dark ? WAB_JADE_DEEP_DARK : WAB_JADE_DEEP_LIGHT,
              ],
            ),
          ),
          child: content,
        ),
      WabSurfaceKind.rubbing => ColoredBox(
          color: WAB_BAIWEN_FACE_LIGHT,
          child: WabPaperTexture(isDark: true, child: content),
        ),
      WabSurfaceKind.inkWash => ColoredBox(
          color: WabTheme.paperWhite,
          child: CustomPaint(
            painter: WabInkWash(isDark: dark),
            child: content,
          ),
        ),
      WabSurfaceKind.patina => CustomPaint(
          painter: _PatinaPainter(dark: dark),
          child: WabPaperTexture(isDark: dark, child: content),
        ),
      WabSurfaceKind.deckle => WabDeckleSurface(
          fill: WabTheme.paperWhite,
          texture: WabPaperTexture(isDark: dark),
          roughness: WAB_DECKLE_ROUGHNESS_PAPER,
          seed: WAB_DECKLE_SEED_PAPER,
          child: content,
        ),
    };

    if (!clip || kind == WabSurfaceKind.deckle) return surface;
    return ClipRRect(
      borderRadius: BorderRadius.circular(WAB_CARD_BORDER_RADIUS),
      child: surface,
    );
  }
}

/// A folded strip of paper. The central crease is drawn as two uneven ink-light
/// rules, not a drop shadow; it is useful as a separator or annotation strip.
class WabPaperFold extends StatelessWidget {
  WabPaperFold({
    super.key,
    required this.child,
    this.padding = WAB_PADDING_ALL,
  });

  final Widget child;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: WabTheme.paperWhite,
      child: WabPaperTexture(
        child: CustomPaint(
          foregroundPainter: _FoldPainter(
            line: WabTheme.lineColor,
            light: WabTheme.primaryColor,
          ),
          child: Padding(padding: padding, child: child),
        ),
      ),
    );
  }
}

class _FiberPainter extends CustomPainter {
  const _FiberPainter({required this.dark});

  final bool dark;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = WAB_WASHI_FIBER.withOpacity(
        dark ? WAB_PAPER_DOT_OPACITY_DARK : WAB_PAPER_DOT_OPACITY_LIGHT,
      )
      ..style = PaintingStyle.stroke
      ..strokeWidth = WAB_RULE_HAIRLINE;

    final pitch = WAB_CLOTH_WEAVE_SPACING * 2;
    for (var y = pitch; y < size.height; y += pitch) {
      final path = Path()..moveTo(0, y);
      path.quadraticBezierTo(
        size.width * .35,
        y - WAB_RULE_HAIRLINE,
        size.width * .65,
        y + WAB_RULE_HAIRLINE,
      );
      path.quadraticBezierTo(size.width * .82, y, size.width, y);
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(_FiberPainter old) => old.dark != dark;
}

class _PatinaPainter extends CustomPainter {
  const _PatinaPainter({required this.dark});

  final bool dark;

  @override
  void paint(Canvas canvas, Size size) {
    final base = dark ? WAB_WOOD_BASE_DARK : WAB_WOOD_BASE_LIGHT;
    canvas.drawRect(Offset.zero & size, Paint()..color = base);

    final deep = dark ? WAB_WOOD_DEEP_DARK : WAB_WOOD_DEEP_LIGHT;
    final deepPaint = Paint()
      ..color = deep.withOpacity(dark
          ? WAB_PAPER_MOTTLE_OPACITY_DEEP_DARK
          : WAB_PAPER_MOTTLE_OPACITY_DEEP_LIGHT)
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, size.shortestSide * .12);
    final rustPaint = Paint()
      ..color = WabTheme.sealColor.withOpacity(dark
          ? WAB_PAPER_MOTTLE_OPACITY_SHEEN_DARK
          : WAB_PAPER_MOTTLE_OPACITY_PALE_LIGHT)
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, size.shortestSide * .09);

    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(size.width * .24, size.height * .38),
        width: size.width * .55,
        height: size.height * .72,
      ),
      deepPaint,
    );
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(size.width * .72, size.height * .62),
        width: size.width * .48,
        height: size.height * .55,
      ),
      rustPaint,
    );
  }

  @override
  bool shouldRepaint(_PatinaPainter old) => old.dark != dark;
}

class _FoldPainter extends CustomPainter {
  const _FoldPainter({required this.line, required this.light});

  final Color line;
  final Color light;

  @override
  void paint(Canvas canvas, Size size) {
    final y = size.height / 2;
    canvas.drawLine(
      Offset(0, y - WAB_RULE_HAIRLINE),
      Offset(size.width, y),
      Paint()
        ..color = line
        ..strokeWidth = WAB_RULE_HAIRLINE,
    );
    canvas.drawLine(
      Offset(0, y + WAB_RULE_HAIRLINE),
      Offset(size.width, y + WAB_RULE_HAIRLINE * 2),
      Paint()
        ..color = light
        ..strokeWidth = WAB_RULE_HAIRLINE,
    );
  }

  @override
  bool shouldRepaint(_FoldPainter old) => old.line != line || old.light != light;
}
