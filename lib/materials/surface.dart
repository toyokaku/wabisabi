import 'package:flutter/material.dart';

import '../theme/wab_theme.dart';
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

/// Canonical physical surfaces exposed by the kit.
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

/// Public material façade. Example/catalogue code should use this instead of
/// inventing local painters.
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
          child: WabPaperTexture(isDark: dark, child: content),
        ),
      WabSurfaceKind.fiber => ColoredBox(
          color: WabTheme.paperWhite,
          child: WabFiberTexture(isDark: dark, child: content),
        ),
      WabSurfaceKind.mottle => ColoredBox(
          color: WabTheme.paperWhite,
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
          color: WabTheme.paperWhite,
          child: CustomPaint(
            painter: WabInkWash(isDark: dark),
            child: content,
          ),
        ),
      WabSurfaceKind.patina => WabPatinaTexture(isDark: dark, child: content),
      WabSurfaceKind.cinnabar => WabCinnabarTexture(isDark: dark, child: content),
      WabSurfaceKind.deckle => WabDeckleSurface(
          fill: WabTheme.paperWhite,
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
