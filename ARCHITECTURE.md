# wabisabi — architecture

A Flutter widget kit with **no third-party dependencies**. `pubspec.yaml` declares
only the Flutter SDK; every one of the 49 `package:` imports in `lib/` is
`package:flutter/*`. Nothing here is a wrapper around someone else's design
system — the materials are painted from scratch, the fonts are bundled, and the
only thing that can break the layering is us.

This file is for judgement calls: what the layers mean, why the kit is shaped
this way, what is deliberately left undone. **Mechanical rules are not written
down here.** They live in `tool/check_layering.dart` and
`tool/check_public_api.dart` and run in CI, because a rule in prose drifts and a
rule in a CI job does not. If you want to know what is enforced, run them.

## Layers

```
tokens/*_raw.dart    pure Dart, no Flutter. The source tool/export_tokens.dart
                     reads to generate web/quarto/ SCSS. Sealed: nothing outside
                     tokens/ imports these.
tokens/*.dart        the same values wrapped in Flutter types (Color, EdgeInsets).
theme/               ThemeData / CupertinoThemeData, the font fallback chains,
                     and text primitives (WabTypographyScope, WabSealText).
materials/           procedural painters — 宣紙, 拓片, 木, 布, 玉, 硃砂, 毛邊,
                     欄界, 紙摺. No image assets anywhere; every surface is drawn.
components/          widgets. The top layer, not the bottom one.
wabisabi.dart        the barrel. The only thing consumers import.
```

Imports point **down or sideways, never up**. Sideways is normal and expected:
`materials/surface.dart` composes ten of its siblings, `components/card.dart`
uses `components/button.dart`, and both are correct — a card contains a button.
The invariants that matter are direction, acyclicity, and the sealed raw layer.
There is no rule against a file importing its neighbour.

### materials/ is the centre of gravity

The kit's identity is not its component list — every design system has buttons.
It is that a button is made of a *material*: paper that has a deckle edge and
pulp clouds, wood with a grain and a bevel, cinnabar that reads as a carved
seal. `WabMaterialKind` is part of a control's meaning, not its decoration, and
the hover/pressed/disabled states are physical (rises and catches light,
compresses into the sheet) rather than a colour ramp.

That is why `materials/` sits below `components/` and why the layer has the
strictest painters in the repo: const constructors, `math.Random(seed)` so an
irregular edge is stable across rebuilds, real `shouldRepaint`.

### Why the raw/wrapped token split

`tokens/*_raw.dart` are plain `int`/`double` constants with no Flutter import so
`tool/export_tokens.dart` can run under bare `dart` and generate the Quarto SCSS
that keeps the web side in visual sync. That is the entire reason the split
exists. It earns its keep for `palette_raw` and `spacing_raw`, which the exporter
actually reads; for `material_raw` and `texture_raw` it is currently pure
duplication (see debts below).

## Deliberate non-goals

- **No image assets.** Every texture is painted. It costs CPU on large surfaces
  and buys resolution independence and themeability.
- **No external packages.** A design system that pulls in dependencies exports
  them to every consuming app.
- **Fonts bundled at full charset.** `assets/fonts/WabKai-*.ttf` is LXGW WenKai
  TC uncut, ~15 MB each, so 繁/簡 coverage never falls back to a system face.
  `tool/build_fonts.sh` regenerates them. This is ~30 MB in git and in every app
  bundle — a real cost, accepted knowingly, worth revisiting for web targets.

## Release

Dev work on `dev`, merge to `main`, tag, consuming apps bump their `ref:` pin.
The tag is the contract with consumers: **an untagged `main` is invisible to
them.** Tags currently stop at `0.0.4`, which predates the entire golden1
material rebuild.

## Known debts

Recorded so they are not rediscovered as news. None are enforced against; the
CI checks cover import structure and public naming only.

- **`WabTheme`'s palette statics are a compatibility shim.** The palette lives
  on `ThemeData` as `WabColors` and is read with `WabTheme.of(context)`; the
  seventeen `static late Color`s are still assigned so consumers pinned to an
  older tag keep working. Nothing in `lib/` reads them any more except two
  places that have no context to read from and say so: `DeckleBorder`, a
  `ShapeBorder` built outside the tree, and `WabInkWash`, a `CustomPainter`
  whose caller now hands it the palette. Removing the statics is a breaking
  change waiting on a version bump.
- **Two generations of material tokens.** `tokens/material.dart` and
  `tokens/texture.dart` both define wood / cloth / jade / cinnabar / paper
  palettes; 65 constants in the older set are referenced by nothing. The
  golden1 rebuild moved to `texture_*` and left the corpse.
- **`WabWidget<C, M>` is a hollow abstraction.** Five classes in `button.dart`
  implement `createCupertinoWidget` and `createMaterialWidget` as the same
  `_build()`. The base has no const constructor, so none of its subclasses can
  be const and none accept a `key`.
- **Concrete widgets are still subclassed in places** — `WabImage` and
  `WabIcon` extend `ClipRRect`, `WabPaymentRow` extends `GestureDetector`,
  `WabWarningText` extends `Text`. Flutter's composite widgets are not designed
  for it: no const, no added fields, no `build` of your own, and the parent's
  whole API leaks to consumers. The three container types have been converted;
  these four have not.
- **No type scale.** `theme/typography.dart` owns font families only. Font sizes
  are hardcoded per component, down to 8 px, and nothing consults
  `MediaQuery.textScaler`.
- **Lints are effectively off.** `analysis_options.yaml` never includes
  `package:flutter_lints/flutter.yaml` despite the comment claiming it does, so
  `flutter analyze` passing means little. Turning it on needs
  `constant_identifier_names` explicitly disabled, since `WAB_*` is house style.
- **`tool/public_api_baseline.txt` has 6 entries**, all unprefixed exported
  names: `DeckleBorder`, `DotGrid`, `InkDot`, `InkDotStyle`, `TexturePainter`,
  `isIos`. Renaming them breaks consumers, so they wait for a version bump.
  Example coverage is clear, and CI keeps it that way — a new export with no
  specimen in `example/lib` fails the build.
