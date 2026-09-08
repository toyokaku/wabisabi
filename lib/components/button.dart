import 'package:flutter/material.dart';
import 'wab_widget.dart';
import '../theme/wab_theme.dart';
import '../tokens/material.dart';
import '../tokens/spacing.dart';
import '../materials/deckle_surface.dart';
import '../materials/paper_texture.dart';
import '../materials/wood_grain.dart';
import '../materials/cloth_weave.dart';

/// The material of a surface — 薄如紙，厚如木，布衣、朱砂、玉石並列.
/// Shape and texture follow the material, never the reverse:
///
/// - [paper] 紙 — wavy deckle edges, square corners, no shadow. 曲邊直角.
/// - [wood] 木 — straight edges, rounded corners, fine grain, soft shadow.
/// - [cloth] 布 — wavy deckle edges, square corners, indigo weave. 曲邊直角.
/// - [seal] 朱砂 — straight edges, small radius, seal red, calligraphy face.
/// - [jade] 玉石 — straight edges, rounded corners, green with a top sheen.
/// - [baiwen] 白文 — 碑拓式白文印: solid block, carved inverse text.
///   晝=墨塊紙字, 夜=紙塊墨字. Square corners.
/// - [zhuwen] 朱文 — 碑拓式朱文印: transparent, thin ink rule + ink text.
enum WabMaterialKind { paper, wood, cloth, seal, jade, baiwen, zhuwen }

/// One button, five materials. The single entry point for actions; the
/// legacy classes below are thin aliases over it.
class WabButton extends StatelessWidget {
  const WabButton({
    super.key,
    required this.child,
    this.kind = WabMaterialKind.paper,
    this.onPressed,
    this.sideColor,
    this.padding,
    this.seed,
    this.expand = false,
  });

  final Widget child;
  final WabMaterialKind kind;
  final VoidCallback? onPressed;

  /// Paper-face outline override (e.g. toggle-on 強墨邊); defaults to the
  /// theme 淡墨 hairline.
  final Color? sideColor;

  /// Defaults to `EdgeInsets.symmetric(horizontal: 22, vertical: 9)`.
  final EdgeInsets? padding;

  /// Deckle/grain seed override — different seeds, different stable edges.
  final int? seed;

  /// Stretch to full width (the old WabElevatedButton behaviour).
  final bool expand;

  @override
  Widget build(BuildContext context) {
    final dark = WabTheme.isDark;
    final pad =
        padding ?? const EdgeInsets.symmetric(horizontal: 22, vertical: 9);

    final TextStyle labelStyle = switch (kind) {
      WabMaterialKind.paper => TextStyle(
          color: WabTheme.textColor,
          fontWeight: FontWeight.w600,
          letterSpacing: 2,
          fontFamilyFallback: kWabKaiFallback,
        ),
      WabMaterialKind.wood => TextStyle(
          color: dark ? WabTheme.textColor : WAB_WOOD_TEXT_LIGHT,
          fontWeight: FontWeight.w600,
          letterSpacing: 2,
          fontFamilyFallback: kWabKaiFallback,
        ),
      WabMaterialKind.cloth => TextStyle(
          color: WAB_SEAL_TEXT, // 布面深，字用恆亮印泥白（晝夜同）
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
          color: dark ? WabTheme.textColor : WAB_JADE_DEEP_DARK,
          fontWeight: FontWeight.w600,
          letterSpacing: 2,
          fontFamilyFallback: kWabKaiFallback,
        ),
      WabMaterialKind.baiwen => TextStyle(
          color: dark ? WAB_BAIWEN_TEXT_DARK : WAB_BAIWEN_TEXT_LIGHT,
          fontWeight: FontWeight.w600,
          letterSpacing: 3,
          fontFamilyFallback: kWabDisplayFallback,
        ),
      WabMaterialKind.zhuwen => TextStyle(
          color: WabTheme.textColor.withOpacity(dark
              ? WAB_ZHUWEN_OPACITY_DARK
              : WAB_ZHUWEN_OPACITY_LIGHT),
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
          child: child,
        ),
      ),
    );
    if (expand) content = SizedBox(width: double.infinity, child: content);

    final decorated = switch (kind) {
      WabMaterialKind.paper => WabDeckleSurface(
          // 晝為宣紙、夜為拓片：fill 隨主題（夜紙 kDarkPaper），
          // 紙紋暗態即石碑 noise，字色由 labelStyle 給白。
          fill: WabTheme.paperWhite,
          texture: WabPaperTexture(), // 不可 const——會凍結主題態
          seed: seed ?? WAB_DECKLE_SEED,
          sideColor: sideColor,
          child: content,
        ),
      WabMaterialKind.wood => Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(WAB_SECTION_BORDER_RADIUS),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(dark
                    ? WAB_WOOD_SHADOW_OPACITY_DARK1
                    : WAB_WOOD_SHADOW_OPACITY_LIGHT1),
                blurRadius: 14,
                offset: const Offset(2, 5),
              ),
              BoxShadow(
                color: Colors.black.withOpacity(dark
                    ? WAB_WOOD_SHADOW_OPACITY_DARK2
                    : WAB_WOOD_SHADOW_OPACITY_LIGHT2),
                blurRadius: 4,
                offset: const Offset(1, 2),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(WAB_SECTION_BORDER_RADIUS),
            child: CustomPaint(
              painter: WabWoodGrain(isDark: dark, showKnot: false),
              child: content,
            ),
          ),
        ),
      WabMaterialKind.cloth => WabDeckleSurface(
          seed: seed ?? WAB_DECKLE_SEED,
          texture: WabClothTexture(), // 自帶蓼藍底 + 經緯織紋；不可 const
          sideColor: dark ? WAB_CLOTH_DEEP_DARK : WAB_CLOTH_DEEP_LIGHT,
          child: content,
        ),
      WabMaterialKind.seal => Container(
          decoration: BoxDecoration(
            color: WabTheme.sealColor,
            borderRadius: BorderRadius.circular(WAB_BADGE_RADIUS),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(WAB_SEAL_SHADOW_OPACITY),
                blurRadius: 4,
                offset: const Offset(1, 2),
              ),
            ],
          ),
          child: content,
        ),
      WabMaterialKind.jade => Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(WAB_SECTION_BORDER_RADIUS),
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
              stops: const [0.0, 0.35, 1.0],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(dark
                    ? WAB_WOOD_SHADOW_OPACITY_DARK2
                    : WAB_WOOD_SHADOW_OPACITY_LIGHT2),
                blurRadius: 6,
                offset: const Offset(1, 3),
              ),
            ],
          ),
          child: content,
        ),
      WabMaterialKind.baiwen => Container(
          // 白文：實塊反字，方角，小小的壓印陰影。
          decoration: BoxDecoration(
            color: dark ? WAB_BAIWEN_FACE_DARK : WAB_BAIWEN_FACE_LIGHT,
            borderRadius: BorderRadius.circular(2),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(WAB_SEAL_SHADOW_OPACITY),
                blurRadius: 4,
                offset: const Offset(1, 2),
              ),
            ],
          ),
          child: content,
        ),
      WabMaterialKind.zhuwen => Container(
          // 朱文：透明底，細墨框陽文，方角。
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            border: Border.all(
              color: WabTheme.textColor.withOpacity(dark
                  ? WAB_ZHUWEN_OPACITY_DARK
                  : WAB_ZHUWEN_OPACITY_LIGHT),
              width: WAB_ZHUWEN_RULE_WIDTH,
            ),
          ),
          child: content,
        ),
    };

    return MouseRegion(
      cursor: onPressed != null
          ? SystemMouseCursors.click
          : SystemMouseCursors.basic,
      child: GestureDetector(
        onTap: onPressed,
        child: decorated,
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Legacy aliases — same constructors as before, now built on WabButton.
// ---------------------------------------------------------------------------

class WabIconButton extends WabWidget<Widget, Widget> {
  WabIconButton(
      {required this.icon,
      this.label,
      this.callback,
      this.padding = 0.0,
      this.kind = WabMaterialKind.baiwen});

  final Widget icon;
  final Widget? label;
  final VoidCallback? callback;
  final double? padding;

  /// 默認印章（白文實塊）；可換 zhuwen 或其它材質。
  final WabMaterialKind kind;

  Widget _build() => WabButton(
        kind: kind,
        onPressed: callback,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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

/// 界行式文字鈕 — default face: 上下兩條細線（無左右線），書頁界行感。
/// 堆疊成列時把第 2 項起的 [mergeTop] 設 true——上枚的下線與本枚的上線
/// 併為一條，不出現雙線。
class WabTextButton extends WabWidget<Widget, Widget> {
  WabTextButton(
      {required this.text,
      this.padding = 20.0,
      this.callback,
      this.mergeTop = false});

  final Text text;
  final double? padding;
  final VoidCallback? callback;

  /// Stacked list use: omit the top rule so it merges with the previous
  /// button's bottom rule.
  final bool mergeTop;

  Widget _build() {
    // Non-const by design: reads WabTheme at build.
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

/// The primary action — wood. 厚如木.
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
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (icon != null)
          Padding(padding: const EdgeInsets.only(right: 8), child: icon!),
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

/// Toggle: jade when on, paper when off.
/// Toggle pairs — on/off 各配一種材質：
/// - [paper] 紙紙：on=紙面強墨邊, off=紙面淡墨邊.
/// - [woodCloth] 木布：on=木, off=布.
/// - [jadeBaiwen] 玉印：on=玉石, off=白文黑拓印.
/// - [sealZhuwen] 硃砂朱文：on=硃砂, off=朱文.
enum WabTogglePair { paper, woodCloth, jadeBaiwen, sealZhuwen }

/// Toggle: one [WabTogglePair] — material carries the state.
class WabToggleButton extends WabWidget<Widget, Widget> {
  WabToggleButton(
      {required this.text,
      required this.isOn,
      this.callback,
      this.pair = WabTogglePair.paper});

  final Text text;
  final bool isOn;
  final VoidCallback? callback;

  /// Which material pair carries the on/off state. 默認紙紙.
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
      // 紙紙對：on 態用強墨邊與 off 態的淡墨邊區分。
      sideColor: pair == WabTogglePair.paper && isOn
          ? WabTheme.textColor.withOpacity(WabTheme.isDark
              ? WAB_RULE_OPACITY_DARK
              : WAB_RULE_OPACITY_LIGHT)
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

/// Round seal-red FAB. 朱砂一點.
class WabFloatingActionButton extends WabWidget<Widget, Widget> {
  WabFloatingActionButton(this.button);

  final FloatingActionButton button;

  Widget _build() => GestureDetector(
        onTap: button.onPressed,
        child: Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: WabTheme.sealColor,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(WAB_SEAL_SHADOW_OPACITY),
                blurRadius: 6,
                offset: const Offset(1, 3),
              ),
            ],
          ),
          child: IconTheme.merge(
            data: IconThemeData(color: WAB_SEAL_TEXT),
            child: Center(child: button.child),
          ),
        ),
      );

  @override
  Widget createCupertinoWidget(BuildContext context) => _build();

  @override
  Widget createMaterialWidget(BuildContext context) => _build();
}
