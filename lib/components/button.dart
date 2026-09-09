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
import '../materials/wood_slab.dart';

/// Physical action surfaces. Material is part of state/meaning, not decoration.
enum WabMaterialKind { paper, wood, cloth, seal, jade, baiwen, zhuwen }

enum WabButtonVisualState { normal, hover, pressed, disabled }

/// Canonical material button.
///
/// Interaction follows physical material semantics:
/// - normal: rests on the sheet
/// - hover: rises slightly, catches more light and casts a wider contact shadow
/// - pressed: compresses into the sheet, darkens and loses lift
/// - disabled: remains materially recognisable but recedes strongly
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
  /// pointer/touch interaction drives the state normally.
  final WabButtonVisualState? state;

  @override
  State<WabButton> createState() => _WabButtonState();
}

class _WabButtonState extends State<WabButton> {
  WabButtonVisualState _state = WabButtonVisualState.normal;
  bool _hovering = false;

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
    final state = _effectiveState;
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
      WabMaterialKind.cloth => const TextStyle(
          color: WAB_SEAL_TEXT,
          fontWeight: FontWeight.w600,
          letterSpacing: 3,
          fontFamilyFallback: kWabKaiFallback,
        ),
      WabMaterialKind.seal => const TextStyle(
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
      WabMaterialKind.baiwen => const TextStyle(
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
    if (widget.expand) {
      content = SizedBox(width: double.infinity, child: content);
    }

    final material = _materialSurface(content, dark, state);

    final opacity = switch (state) {
      WabButtonVisualState.disabled => .36,
      _ => 1.0,
    };
    final dy = switch (state) {
      WabButtonVisualState.hover => -1.3,
      WabButtonVisualState.pressed => 1.35,
      _ => 0.0,
    };
    final scale = switch (state) {
      WabButtonVisualState.hover => 1.012,
      WabButtonVisualState.pressed => .985,
      _ => 1.0,
    };
    final tone = switch (state) {
      WabButtonVisualState.hover => 1.055,
      WabButtonVisualState.pressed => .84,
      WabButtonVisualState.disabled => .88,
      _ => 1.0,
    };
    final interactionShadow = switch (state) {
      WabButtonVisualState.hover => [
          BoxShadow(
            color: Colors.black.withOpacity(dark ? .32 : .16),
            blurRadius: 8,
            spreadRadius: -.5,
            offset: const Offset(0, 4),
          ),
        ],
      WabButtonVisualState.pressed => [
          BoxShadow(
            color: Colors.black.withOpacity(dark ? .18 : .07),
            blurRadius: 1.5,
            offset: const Offset(0, .8),
          ),
        ],
      _ => const <BoxShadow>[],
    };

    final toneFilter = ColorFilter.matrix([
      tone, 0, 0, 0, 0,
      0, tone, 0, 0, 0,
      0, 0, tone, 0, 0,
      0, 0, 0, 1, 0,
    ]);

    return MouseRegion(
      cursor: widget.onPressed == null
          ? SystemMouseCursors.basic
          : SystemMouseCursors.click,
      onEnter: (_) {
        _hovering = true;
        _set(WabButtonVisualState.hover);
      },
      onExit: (_) {
        _hovering = false;
        _set(WabButtonVisualState.normal);
      },
      child: GestureDetector(
        onTapDown: (_) => _set(WabButtonVisualState.pressed),
        onTapUp: (_) => _set(
          _hovering
              ? WabButtonVisualState.hover
              : WabButtonVisualState.normal,
        ),
        onTapCancel: () => _set(
          _hovering
              ? WabButtonVisualState.hover
              : WabButtonVisualState.normal,
        ),
        onTap: widget.onPressed,
        child: AnimatedOpacity(
          opacity: opacity,
          duration: const Duration(milliseconds: 95),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 95),
            curve: Curves.easeOutCubic,
            transformAlignment: Alignment.center,
            transform: Matrix4.translationValues(0, dy, 0)
              ..scale(scale, scale),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(WAB_CARD_BORDER_RADIUS),
              boxShadow: interactionShadow,
            ),
            child: ColorFiltered(
              colorFilter: toneFilter,
              child: material,
            ),
          ),
        ),
      ),
    );
  }

  Widget _materialSurface(
    Widget content,
    bool dark,
    WabButtonVisualState state,
  ) {
    return switch (widget.kind) {
      WabMaterialKind.paper => WabDeckleSurface(
          fill: WabTheme.paperWhite,
          texture: WabPaperTexture(isDark: dark),
          seed: widget.seed ?? WAB_DECKLE_SEED,
          sideColor: widget.sideColor,
          roughness: WAB_DECKLE_ROUGHNESS_PAPER,
          child: content,
        ),
      WabMaterialKind.wood => _restingShadow(
          WabWoodSlab(
            isDark: dark,
            seed: widget.seed ?? 201,
            lifted: false,
            showKnot: false,
            radius: 3.0,
            child: content,
          ),
          dark,
          state,
        ),
      WabMaterialKind.cloth => WabDeckleSurface(
          seed: widget.seed ?? WAB_DECKLE_SEED,
          roughness: WAB_DECKLE_ROUGHNESS_PAPER,
          texture: WabClothTexture(isDark: dark),
          sideColor: Colors.transparent,
          child: content,
        ),
      WabMaterialKind.seal => _restingShadow(
          ClipRRect(
            borderRadius: BorderRadius.circular(3),
            child: WabCinnabarTexture(isDark: dark, child: content),
          ),
          dark,
          state,
        ),
      WabMaterialKind.jade => _restingShadow(
          ClipRRect(
            borderRadius: BorderRadius.circular(WAB_SECTION_BORDER_RADIUS),
            child: WabJadeTexture(isDark: dark, child: content),
          ),
          dark,
          state,
        ),
      WabMaterialKind.baiwen => _restingShadow(
          ClipRRect(
            borderRadius: BorderRadius.circular(2),
            child: WabRubbingTexture(child: content),
          ),
          dark,
          state,
        ),
      WabMaterialKind.zhuwen => _ZhuwenSurface(child: content),
    };
  }

  Widget _restingShadow(
    Widget child,
    bool dark,
    WabButtonVisualState state,
  ) {
    final shadows = state == WabButtonVisualState.normal
        ? [
            BoxShadow(
              color: Colors.black.withOpacity(dark ? .30 : .14),
              blurRadius: 5,
              offset: const Offset(1.5, 2.5),
            ),
          ]
        : const <BoxShadow>[];
    return Container(
      decoration: BoxDecoration(boxShadow: shadows),
      child: child,
    );
  }
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

  Widget _build() {
    final extra = padding ?? 0;
    return WabButton(
      kind: kind,
      onPressed: callback,
      padding: EdgeInsets.symmetric(
        horizontal: 16 + extra,
        vertical: 10 + extra / 2,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon,
          if (label != null) const SizedBox(width: 6),
          if (label != null) label!,
        ],
      ),
    );
  }

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
      cursor: callback != null
          ? SystemMouseCursors.click
          : SystemMouseCursors.basic,
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
