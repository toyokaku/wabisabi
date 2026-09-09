import 'package:flutter/material.dart';

import 'wab_widget.dart';
import '../theme/wab_theme.dart';
import '../tokens/material.dart';
import '../tokens/spacing.dart';
import '../materials/cinnabar_texture.dart';
import '../materials/cloth_weave.dart';
import '../materials/deckle_surface.dart';
import '../materials/jade_texture.dart';
import '../materials/paper_texture.dart';
import '../materials/rubbing_texture.dart';
import '../materials/wood_grain.dart';

/// Physical action surfaces. Material is part of state/meaning, not decoration.
enum WabMaterialKind { paper, wood, cloth, seal, jade, baiwen, zhuwen }

enum WabButtonVisualState { normal, hover, pressed, disabled }

/// Canonical material button. Hover/press/disabled are implemented here so
/// catalogue examples do not fake component states with ad-hoc wrappers.
class WabButton extends StatefulWidget {
  const WabButton({
    super.key,
    required this.child,
    this.kind = WabMaterialKind.paper,
    this.onPressed,
    this.sideColor,
    this.padding,
    this.seed,
    this.expand = false,
    this.state,
  });

  final Widget child;
  final WabMaterialKind kind;
  final VoidCallback? onPressed;
  final Color? sideColor;
  final EdgeInsets? padding;
  final int? seed;
  final bool expand;

  /// Optional controlled visual state for catalogues/golden tests. When null,
  /// mouse/touch interaction drives the state normally.
  final WabButtonVisualState? state;

  @override
  State<WabButton> createState() => _WabButtonState();
}

class _WabButtonState extends State<WabButton> {
  WabButtonVisualState _state = WabButtonVisualState.normal;

  WabButtonVisualState get _effectiveState {
    if (widget.onPressed == null) return WabButtonVisualState.disabled;
    return widget.state ?? _state;
  }

  void _set(WabButtonVisualState value) {
    if (widget.state != null || widget.onPressed == null) return;
    if (_state != value) setState(() => _state = value);
  }

  @override
  Widget build(BuildContext context) {
    final dark = WabTheme.isDark;
    final pad = widget.padding ??
        const EdgeInsets.symmetric(horizontal: 22, vertical: 9);

    final labelStyle = switch (widget.kind) {
      WabMaterialKind.paper => TextStyle(
          color: WabTheme.textColor,
          fontWeight: FontWeight.w600,
          letterSpacing: 2,
          fontFamilyFallback: kWabKaiFallback,
        ),
      WabMaterialKind.wood => TextStyle(
          color: dark ? WabTheme.textColor : const Color(0xFF30271F),
          fontWeight: FontWeight.w600,
          letterSpacing: 2,
          fontFamilyFallback: kWabKaiFallback,
        ),
      WabMaterialKind.cloth => TextStyle(
          color: WAB_SEAL_TEXT,
          fontWeight: FontWeight.w600,
          letterSpacing: 3,
          fontFamilyFallback: kWabKaiFallback,
        ),
      WabMaterialKind.seal => TextStyle(
          color: WAB_SEAL_TEXT,
          fontWeight: FontWeight.w600,
          letterSpacing: 3,
          fontFamilyFallback: kWabDisplayFallback,
        ),
      WabMaterialKind.jade => TextStyle(
          color: dark ? WabTheme.textColor : const Color(0xFF294438),
          fontWeight: FontWeight.w600,
          letterSpacing: 2,
          fontFamilyFallback: kWabKaiFallback,
        ),
      WabMaterialKind.baiwen => TextStyle(
          color: WAB_SEAL_TEXT,
          fontWeight: FontWeight.w600,
          letterSpacing: 3,
          fontFamilyFallback: kWabDisplayFallback,
        ),
      WabMaterialKind.zhuwen => TextStyle(
          color: WabTheme.sealColor,
          fontWeight: FontWeight.w600,
          letterSpacing: 3,
          fontFamilyFallback: kWabDisplayFallback,
        ),
    };

    Widget content = Padding(
      padding: pad,
      child: DefaultTextStyle.merge(
        style: labelStyle,
        textAlign: TextAlign.center,
        child: IconTheme.merge(
          data: IconThemeData(color: labelStyle.color),
          child: widget.child,
        ),
      ),
    );
    if (widget.expand) content = SizedBox(width: double.infinity, child: content);

    final decorated = _materialSurface(content, dark);
    final state = _effectiveState;
    final opacity = switch (state) {
      WabButtonVisualState.normal => 1.0,
      WabButtonVisualState.hover => .94,
      WabButtonVisualState.pressed => .88,
      WabButtonVisualState.disabled => .42,
    };
    final dy = state == WabButtonVisualState.pressed ? 1.2 : 0.0;

    return MouseRegion(
      cursor: widget.onPressed == null
          ? SystemMouseCursors.basic
          : SystemMouseCursors.click,
      onEnter: (_) => _set(WabButtonVisualState.hover),
      onExit: (_) => _set(WabButtonVisualState.normal),
      child: GestureDetector(
        onTapDown: (_) => _set(WabButtonVisualState.pressed),
        onTapUp: (_) => _set(WabButtonVisualState.hover),
        onTapCancel: () => _set(WabButtonVisualState.normal),
        onTap: widget.onPressed,
        child: AnimatedOpacity(
          opacity: opacity,
          duration: const Duration(milliseconds: 90),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 90),
            transform: Matrix4.translationValues(0, dy, 0),
            child: decorated,
          ),
        ),
      ),
    );
  }

  Widget _materialSurface(Widget content, bool dark) {
    return switch (widget.kind) {
      WabMaterialKind.paper => WabDeckleSurface(
          fill: WabTheme.paperWhite,
          texture: WabPaperTexture(isDark: dark),
          seed: widget.seed ?? WAB_DECKLE_SEED,
          sideColor: widget.sideColor,
          roughness: WAB_DECKLE_ROUGHNESS_PAPER,
          child: content,
        ),
      WabMaterialKind.wood => _shadowed(
          ClipRRect(
            borderRadius: BorderRadius.circular(WAB_SECTION_BORDER_RADIUS),
            child: CustomPaint(
              painter: WabWoodGrain(isDark: dark, showKnot: false),
              child: content,
            ),
          ),
          dark,
        ),
      WabMaterialKind.cloth => WabDeckleSurface(
          seed: widget.seed ?? WAB_DECKLE_SEED,
          roughness: WAB_DECKLE_ROUGHNESS_PAPER,
          texture: WabClothTexture(isDark: dark),
          sideColor: Colors.transparent,
          child: content,
        ),
      WabMaterialKind.seal => _shadowed(
          ClipRRect(
            borderRadius: BorderRadius.circular(3),
            child: WabCinnabarTexture(isDark: dark, child: content),
          ),
          dark,
        ),
      WabMaterialKind.jade => _shadowed(
          ClipRRect(
            borderRadius: BorderRadius.circular(WAB_SECTION_BORDER_RADIUS),
            child: WabJadeTexture(isDark: dark, child: content),
          ),
          dark,
        ),
      WabMaterialKind.baiwen => _shadowed(
          ClipRRect(
            borderRadius: BorderRadius.circular(2),
            child: WabRubbingTexture(child: content),
          ),
          dark,
        ),
      WabMaterialKind.zhuwen => _ZhuwenSurface(child: content),
    };
  }

  Widget _shadowed(Widget child, bool dark) => Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(dark ? .30 : .14),
              blurRadius: 5,
              offset: const Offset(1.5, 2.5),
            ),
          ],
        ),
        child: child,
      );
}

class _ZhuwenSurface extends StatelessWidget {
  const _ZhuwenSurface({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final red = WabTheme.sealColor;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: WabTheme.paperWhite,
        borderRadius: BorderRadius.circular(3),
        border: Border.all(color: red, width: 1.25),
      ),
      child: Padding(
        padding: const EdgeInsets.all(3),
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(1.5),
            border: Border.all(color: red.withOpacity(.88), width: .72),
          ),
          child: WabPaperTexture(child: child),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Legacy/public convenience wrappers — all render through the canonical button.
// ---------------------------------------------------------------------------

class WabIconButton extends WabWidget<Widget, Widget> {
  WabIconButton({
    required this.icon,
    this.label,
    this.callback,
    this.padding = 0.0,
    this.kind = WabMaterialKind.baiwen,
  });

  final Widget icon;
  final Widget? label;
  final VoidCallback? callback;
  final double? padding;
  final WabMaterialKind kind;

  Widget _build() => WabButton(
        kind: kind,
        onPressed: callback,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            icon,
            if (label != null) const SizedBox(width: 6),
            if (label != null) label!,
          ],
        ),
      );

  @override
  Widget createCupertinoWidget(BuildContext context) => _build();
  @override
  Widget createMaterialWidget(BuildContext context) => _build();
}

/// 界行式文字鈕 — text only, separated by fine book-page rules.
class WabTextButton extends WabWidget<Widget, Widget> {
  WabTextButton({
    required this.text,
    this.padding = 20.0,
    this.callback,
    this.mergeTop = false,
  });

  final Text text;
  final double? padding;
  final VoidCallback? callback;
  final bool mergeTop;

  Widget _build() {
    final side = BorderSide(
      color: WabTheme.lineColor,
      width: WAB_RULE_HAIRLINE,
    );
    final p = padding ?? 20;
    return MouseRegion(
      cursor: callback != null ? SystemMouseCursors.click : SystemMouseCursors.basic,
      child: GestureDetector(
        onTap: callback,
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: p, vertical: p / 2),
          decoration: BoxDecoration(
            border: Border(
              top: mergeTop ? BorderSide.none : side,
              bottom: side,
            ),
          ),
          child: DefaultTextStyle.merge(
            style: TextStyle(
              color: WabTheme.textColor,
              letterSpacing: 2,
              fontFamilyFallback: kWabKaiFallback,
            ),
            textAlign: TextAlign.center,
            child: text,
          ),
        ),
      ),
    );
  }

  @override
  Widget createCupertinoWidget(BuildContext context) => _build();
  @override
  Widget createMaterialWidget(BuildContext context) => _build();
}

class WabElevatedButton extends WabWidget<Widget, Widget> {
  WabElevatedButton({
    required this.text,
    this.padding = 20.0,
    this.callback,
    this.icon,
    this.showChevron = false,
  });

  final Text text;
  final double? padding;
  final VoidCallback? callback;
  final Icon? icon;
  final bool showChevron;

  Widget _build() {
    final p = padding ?? 18;
    return WabButton(
      kind: WabMaterialKind.wood,
      onPressed: callback,
      expand: true,
      padding: EdgeInsets.symmetric(horizontal: p, vertical: p / 2),
      child: _buildContent(),
    );
  }

  Widget _buildContent() {
    if (icon == null && !showChevron) return text;
    return Row(
      children: [
        if (icon != null) ...[
          icon!,
          const SizedBox(width: 8),
        ],
        Expanded(child: text),
        if (showChevron) const Icon(Icons.chevron_right, size: 18),
      ],
    );
  }

  @override
  Widget createCupertinoWidget(BuildContext context) => _build();
  @override
  Widget createMaterialWidget(BuildContext context) => _build();
}

enum WabTogglePair { paper, woodCloth, jadeBaiwen, sealZhuwen }

class WabToggleButton extends WabWidget<Widget, Widget> {
  WabToggleButton({
    required this.text,
    required this.isOn,
    this.callback,
    this.pair = WabTogglePair.paper,
  });

  final Text text;
  final bool isOn;
  final VoidCallback? callback;
  final WabTogglePair pair;

  Widget _build() {
    final kind = switch (pair) {
      WabTogglePair.paper => WabMaterialKind.paper,
      WabTogglePair.woodCloth =>
        isOn ? WabMaterialKind.wood : WabMaterialKind.cloth,
      WabTogglePair.jadeBaiwen =>
        isOn ? WabMaterialKind.jade : WabMaterialKind.baiwen,
      WabTogglePair.sealZhuwen =>
        isOn ? WabMaterialKind.seal : WabMaterialKind.zhuwen,
    };
    return WabButton(
      kind: kind,
      sideColor: pair == WabTogglePair.paper && isOn
          ? WabTheme.textColor.withOpacity(.65)
          : null,
      onPressed: callback,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: text,
    );
  }

  @override
  Widget createCupertinoWidget(BuildContext context) => _build();
  @override
  Widget createMaterialWidget(BuildContext context) => _build();
}

class WabFloatingActionButton extends WabWidget<Widget, Widget> {
  WabFloatingActionButton(this.button);
  final FloatingActionButton button;

  Widget _build() => GestureDetector(
        onTap: button.onPressed,
        child: Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(WAB_SEAL_SHADOW_OPACITY),
                blurRadius: 6,
                offset: const Offset(1, 3),
              ),
            ],
          ),
          child: ClipOval(
            child: WabCinnabarTexture(
              child: IconTheme.merge(
                data: const IconThemeData(color: WAB_SEAL_TEXT),
                child: Center(child: button.child),
              ),
            ),
          ),
        ),
      );

  @override
  Widget createCupertinoWidget(BuildContext context) => _build();
  @override
  Widget createMaterialWidget(BuildContext context) => _build();
}
