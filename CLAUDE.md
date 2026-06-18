# wabisabi — design system rules

Flutter widget kit for the Songkoro org. Every app consumes this via a pinned git tag.
Public mirror: `github.com/bayanasar/wabisabi`. Canonical source: GitLab `songkoro/front-end/song`.

## Three-layer architecture — enforce at all times

```
tokens/ → theme/ → components/
```

**Tokens** (`lib/tokens/`) — raw values only, no widget logic.
- `palette.dart`: named colors (`WabiSabiColors`) + operational `WAB_LIGHT_*` / `WAB_DARK_*` consts.
- `spacing.dart`: sizing, padding, radius, layout consts.
- No imports from `theme/` or `components/`. Ever.

**Theme** (`lib/theme/`) — maps tokens into Flutter `ThemeData` / `CupertinoThemeData`.
- `wab_theme.dart`: `WabTheme` class with `materialTheme()` and `cupertinoTheme()` builders.
- May import from `tokens/` only.

**Components** (`lib/components/`) — widgets that read from the theme, never from tokens directly.
- `wab_widget.dart`: `WabWidget<C, M>` abstract base (platform switch).
- `wab_utils.dart`: `isIos()` helper.
- `button|text|image|scaffold|divider.dart`: one file per widget family.
- May import from `theme/` and `tokens/`. Must NOT import from other component files (use the barrel).

**Barrel** (`lib/wabisabi.dart`) — the only public surface. Apps import `package:wabisabi/wabisabi.dart`.
Do not add `flutter.dart` or any other entry point. One barrel, always.

## Import discipline

```
# correct
import '../theme/wab_theme.dart';
import '../tokens/spacing.dart';

# wrong — hardcoded value in a component
color: Color(0xFF8B5E3C)  // use WabTheme.* instead

# wrong — component importing component
import 'button.dart';     // use the barrel or restructure
```

Components must never contain literal color, spacing, or radius values.
All visual values come from `WabTheme.*` or token consts.

## Naming

- Classes: `Wab` prefix (`WabButton`, `WabScaffold`).
- Constants: `WAB_` prefix, SCREAMING_SNAKE_CASE (`WAB_PADDING_ALL`).
- Named palette colors: lowercase, semantic (`WabiSabiColors.clay`, `.bamboo`).
- Files: `snake_case.dart`.

## Growing the kit organically

When promoting a widget from an app into the kit:
1. Add it to the correct `components/` file (or create a new file for a new family).
2. Export it from `lib/wabisabi.dart`.
3. No hardcoded values — wire to `WabTheme.*` or add a token if one is missing.
4. Run `flutter analyze lib` and `flutter test` before committing.
5. Bump the version in `pubspec.yaml` and tag (`git tag vX.Y.Z`).

## Release flow

- Dev work → `dev` branch.
- Merge to `main` → tag → consuming apps bump their `ref:` pin.
- Never commit directly to `main`.
- CI (GitHub Actions) runs analyze + unit_test + build_apk/web/linux on every push to `dev`/`main`.

## Flutter SDK

Pinned to `3.29.2` in CI (`flutter-version` in `.github/workflows/ci.yml`).
Update the pin deliberately — test locally first, then update CI.
