# Changelog

## Unreleased

Breaking. Consumers pinning a tag are unaffected until they move the pin.

### Breaking

- `wabInputDecoration` takes a `BuildContext` as its first argument.
- `WabContainer`, `WabLiteContainer` and `WabContentContainer` no longer extend
  `Container`; `WabImage` and `WabIcon` no longer extend `ClipRRect`;
  `WabPaymentRow` no longer extends `GestureDetector`; `WabWarningText` no
  longer extends `Text`. All of them compose instead, and all take a `key`.
- `WabPaymentRow.image` widens from `ClipRRect` to `Widget`.
- `WabIconButton`, `WabTextButton`, `WabElevatedButton`, `WabToggleButton` and
  `WabFloatingActionButton` are plain `StatelessWidget`s; their
  `createMaterialWidget` / `createCupertinoWidget` methods are gone. Both
  branches always returned the same thing.
- `WabWidget` loses its two type parameters and gains a const constructor and a
  key. Subclasses may still narrow their return type.
- 57 constants from the pre-golden1 material palette are deleted from
  `tokens/material.dart`. `WAB_WOOD_TEXT_LIGHT` survives as a deprecated alias
  for `WAB_TEXTURE_WOOD_TEXT_LIGHT`.
- `WAB_SEAL_SHADOW_OPACITY` is gone with the shadow it described.
- `WabSealText` moves from `components/` to `theme/`. The barrel is unchanged.

### Added

- `WabColors`, a `ThemeExtension` carrying the palette, read via
  `WabTheme.of(context)`. An app can now hold a light and a dark theme at once
  and use `themeMode: system`; widgets rebuild when the theme changes.
- `WabType`, the type ladder — every font size the kit draws, in one file.
- `tool/check_layering.dart` and `tool/check_public_api.dart`, run in CI.
- `ARCHITECTURE.md`.
- A BSD 3-Clause licence, which the package did not have.

### Fixed

- `WabNumberFormField` built a `TextEditingController` in `build`: a new one
  every rebuild, never disposed, resetting text and caret. A null `value` also
  rendered the string "null".
- `WabScaffold` silently dropped `floatingActionButton` on iOS and macOS.
- `TexturePainter.shouldRepaint` returned a flat `false`, so the scaffold
  ground kept the old palette across a theme change. `WabInkWash` and the
  fish-tail track painter read the theme where `shouldRepaint` could not see it.
- `WabSlider` mapped taps through a 10 px inset while painting a 9 px one.
- `WabEditorialBanner` overflowed below ~800 px wide, the subtitle wrapping into
  a column of single characters. It now sheds motto, kit label and subtitle as
  it narrows.
- `WabCollectionCard` and `WabPaymentRow` overflowed in tight cells.
- Hardcoded colours in `WabButton` and `WabWarningText` come from tokens and
  the theme.
- 87 `withOpacity` calls become `withValues`, `dialogBackgroundColor` becomes
  `DialogThemeData`, `WabRadio` moves onto `RadioGroup`.
- `web/quarto/*.scss` regenerated; `--wab-rust` had been stale since the golden1
  rebuild.

### Changed

- `WabFloatingActionButton` is a pressed seal: a deckle-edged cinnabar face with
  no drop shadow and a larger mark.

## 0.0.4

Dashboard widget set, xuan paper v2, two-tier rule frames, seal buttons.
