import 'package:flutter/material.dart';

import '../theme/wab_theme.dart';
import '../tokens/palette.dart';
import '../tokens/spacing.dart';
import 'cinnabar_texture.dart';
import 'cloth_weave.dart';
import 'deckle_surface.dart';
import 'fiber_texture.dart';
import 'ink_wash.dart';
import 'jade_texture.dart';
import 'paper_texture.dart';
import 'patina_texture.dart';
import 'rubbing_texture.dart';
import 'wood_grain.dart';

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
  cinnabar,
  deckle,
}

/// Public material façade. Catalogue code should use this instead of local
/// painters so every visible material remains part of the theme kit.
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
    final paper = dark ? WAB_DARK_PAPER : WabiSabiColors.paperWhite;
    final content = Padding(padding: padding, child: child);

    Widget surface = switch (kind) {
      WabSurfaceKind.paper => ColoredBox(
          color: paper,
          child: WabPaperTexture(isDark: dark, child: content),
        ),
      WabSurfaceKind.fiber => ColoredBox(
          color: paper,
          child: WabFiberTexture(isDark: dark, child: content),
        ),
      WabSurfaceKind.mottle => ColoredBox(
          color: paper,
          child: WabPaperTexture(
            isDark: dark,
            kind: WabPaperTextureKind.mottle,
            child: content,
          ),
        ),
      WabSurfaceKind.woodGrain => CustomPaint(
          painter: WabWoodGrain(isDark: dark),
          child: content,
        ),
      WabSurfaceKind.clothWeave => WabClothTexture(isDark: dark, child: content),
      WabSurfaceKind.jadeSheen => WabJadeTexture(isDark: dark, child: content),
      WabSurfaceKind.rubbing => WabRubbingTexture(child: content),
      WabSurfaceKind.inkWash => ColoredBox(
          color: paper,
          child: CustomPaint(
            painter: WabInkWash(isDark: dark),
            child: content,
          ),
        ),
      WabSurfaceKind.patina => WabPatinaTexture(isDark: dark, child: content),
      WabSurfaceKind.cinnabar => WabCinnabarTexture(isDark: dark, child: content),
      WabSurfaceKind.deckle => WabDeckleSurface(
          fill: paper,
          texture: WabPaperTexture(isDark: dark),
          roughness: 3.1,
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
