import 'package:flutter/material.dart';
import 'package:wabisabi/wabisabi.dart';

/// Live catalogue for the public Wabisabi kit.
///
/// Rule: this file may compose Flutter layout primitives, but all material,
/// surface, rule, seal and component visuals shown as specimens must come from
/// exported `package:wabisabi/wabisabi.dart` APIs. No example-only painters.
class Golden1Showcase extends StatefulWidget {
  const Golden1Showcase({
    super.key,
    required this.isDark,
    required this.onToggleTheme,
  });

  final bool isDark;
  final VoidCallback onToggleTheme;

  @override
  State<Golden1Showcase> createState() => _Golden1ShowcaseState();
}

class _Golden1ShowcaseState extends State<Golden1Showcase> {
  final _sectionKeys = List<GlobalKey>.generate(12, (_) => GlobalKey());
  int _selectedSection = 0;
  bool _check = true;
  int _radio = 0;
  bool _switch = true;
  double _slider = .42;
  String _dropdown = '春';
  bool _toggle = true;

  static const _nav = [
    '01 色 · PALETTE',
    '02 材 · MATERIALS',
    '03 書 · TYPOGRAPHY',
    '04 面 · SURFACES',
    '05 邊 · BORDERS & RULES',
    '06 器 · COMPONENTS',
    '07 狀態 · STATES',
    '08 表單 · INPUTS',
    '09 標記 · BADGES & SEALS',
    '10 卡片 · CARDS & PANELS',
    '11 陰影 · SHADOWS',
    '12 明暗 · LIGHT & DARK',
  ];

  static const _sectionTitle = [
    '01  色 | PALETTE',
    '02  材 | MATERIALS',
    '03  書 | TYPOGRAPHY',
    '04  面 | SURFACES',
    '05  邊 | BORDERS & RULES',
    '06  器 | COMPONENTS · BUTTONS',
    '07  狀態 | STATES',
    '08  表單 | INPUTS',
    '09  標記 | BADGES & SEALS',
    '10  卡片 | CARDS & PANELS',
    '11  陰影 | SHADOWS',
    '12  明暗 | LIGHT & DARK',
  ];

  static const _subtitles = [
    '調煉紙、墨、木、土、釉的克制色系',
    '數字化的東方材質語言',
    '標題、正文、數字：統一的文字體系',
    '生成式材質表面（無圖片資產）',
    '源自古籍的欄界語言',
    '多材質按鈕體系',
    '克制而自然的狀態變化',
    '通用於現代應用的克制表單元素',
    '源自印章與題簽的標記語言',
    '內容容器與信息組織',
    '源自實物的自然投影',
    '行墨與拓片的雙重世界',
  ];

  void _jumpTo(int index) {
    setState(() => _selectedSection = index);
    final context = _sectionKeys[index].currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 320),
        curve: Curves.easeOutCubic,
        alignment: .03,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WabTheme.backgroundColor,
      body: Stack(
        children: [
          Positioned.fill(
            child: WabSurface(
              kind: WabSurfaceKind.paper,
              clip: false,
              child: const SizedBox.expand(),
            ),
          ),
          Column(
            children: [
              _masthead(),
              Divider(
                height: 1,
                thickness: WAB_RULE_HAIRLINE,
                color: WabTheme.lineColor,
              ),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _sidebar(),
                    VerticalDivider(
                      width: 1,
                      thickness: WAB_RULE_HAIRLINE,
                      color: WabTheme.lineColor,
                    ),
                    Expanded(child: _body()),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _masthead() {
    return WabBanner(
      height: 96,
      title: '現代應用的東方美學界面系統',
      subtitle: 'A TIMELESS UI SYSTEM FOR MODERN APPS',
      leading: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '侘 寂',
            style: TextStyle(
              color: WabTheme.textColor,
              fontSize: 28,
              height: 1,
              letterSpacing: 7,
              fontFamilyFallback: kWabDisplayFallback,
            ),
          ),
          const SizedBox(width: 13),
          SizedBox(
            height: 48,
            child: VerticalDivider(
              color: WabTheme.lineColor,
              thickness: WAB_RULE_HAIRLINE,
            ),
          ),
          const SizedBox(width: 11),
          Text(
            'WABISABI\nUI KIT',
            style: TextStyle(
              color: WabTheme.mutedColor,
              fontSize: 9,
              letterSpacing: 2.7,
              height: 1.45,
              fontFamilyFallback: kWabMonoFallback,
            ),
          ),
        ],
      ),
      seal: WabSealMark(text: '侘寂', size: 28, seed: 17),
      trailing: [
        Text(
          '取法自然 · 材質為語 · 克制為美 · 留白生境',
          style: TextStyle(
            color: WabTheme.mutedColor,
            fontSize: 9,
            letterSpacing: 1.8,
            fontFamilyFallback: kWabKaiFallback,
          ),
        ),
        const SizedBox(width: 14),
        WabIconButton(
          icon: Icon(
            widget.isDark ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
            size: 16,
          ),
          kind: WabMaterialKind.zhuwen,
          callback: widget.onToggleTheme,
        ),
      ],
    );
  }

  Widget _sidebar() {
    return WabSidebar(
      width: 190,
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
      children: [
        Text(
          '素材庫',
          style: TextStyle(
            color: WabTheme.textColor,
            fontSize: 16,
            letterSpacing: 3,
            fontFamilyFallback: kWabDisplayFallback,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          'MATERIAL INDEX · v0.2',
          style: TextStyle(
            color: WabTheme.mutedColor,
            fontSize: 8,
            letterSpacing: 1.4,
            fontFamilyFallback: kWabMonoFallback,
          ),
        ),
        const SizedBox(height: 18),
        for (var i = 0; i < _nav.length; i++)
          Opacity(
            opacity: _selectedSection == i ? 1 : .67,
            child: WabTextButton(
              text: Text(
                _nav[i],
                style: TextStyle(
                  fontSize: 9,
                  fontWeight: _selectedSection == i
                      ? FontWeight.w700
                      : FontWeight.w400,
                ),
              ),
              callback: () => _jumpTo(i),
              mergeTop: i != 0,
              padding: 10,
            ),
          ),
        const Spacer(),
        Text(
          'LESS, BUT DEEPER.',
          style: TextStyle(
            color: WabTheme.mutedColor,
            fontSize: 8,
            letterSpacing: 2.6,
            fontFamilyFallback: kWabMonoFallback,
          ),
        ),
      ],
    );
  }

  Widget _body() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final columns = width >= 980 ? 3 : (width >= 650 ? 2 : 1);
        final cardWidth = (width - 44 - (columns - 1) * 12) / columns;
        return ListView(
          padding: const EdgeInsets.fromLTRB(22, 22, 22, 64),
          children: [
            Text(
              '取 法 自 然',
              style: TextStyle(
                color: WabTheme.textColor,
                fontSize: 30,
                letterSpacing: 11,
                fontFamilyFallback: kWabDisplayFallback,
              ),
            ),
            const SizedBox(height: 3),
            Text(
              'MATERIAL · TYPOGRAPHY · RHYTHM · COMPONENTS',
              style: TextStyle(
                color: WabTheme.mutedColor,
                fontSize: 8,
                letterSpacing: 2.8,
                fontFamilyFallback: kWabMonoFallback,
              ),
            ),
            const SizedBox(height: 15),
            WabBrushDivider(),
            const SizedBox(height: 18),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                SizedBox(width: cardWidth, child: _section(0, _palette())),
                SizedBox(width: cardWidth, child: _section(1, _materials())),
                SizedBox(width: cardWidth, child: _section(2, _typography())),
                SizedBox(width: cardWidth, child: _section(3, _surfaces())),
                SizedBox(width: cardWidth, child: _section(4, _rules())),
                SizedBox(width: cardWidth, child: _section(5, _buttons())),
                SizedBox(width: cardWidth, child: _section(6, _states())),
                SizedBox(width: cardWidth, child: _section(7, _inputs())),
                SizedBox(width: cardWidth, child: _section(8, _badges())),
                SizedBox(width: cardWidth, child: _section(9, _cards())),
                SizedBox(width: cardWidth, child: _section(10, _shadows())),
                SizedBox(width: cardWidth, child: _section(11, _lightDark())),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _section(int index, Widget child) {
    return KeyedSubtree(
      key: _sectionKeys[index],
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: WabTheme.lineColor.withOpacity(.42),
            width: .55,
          ),
        ),
        child: WabSurface(
          kind: WabSurfaceKind.paper,
          clip: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(13, 12, 13, 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _sectionTitle[index],
                  style: TextStyle(
                    color: WabTheme.textColor,
                    fontSize: 14,
                    letterSpacing: 1.1,
                    fontWeight: FontWeight.w600,
                    fontFamilyFallback: kWabDisplayFallback,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  _subtitles[index],
                  style: TextStyle(
                    color: WabTheme.mutedColor,
                    fontSize: 8,
                    letterSpacing: .7,
                    fontFamilyFallback: kWabKaiFallback,
                  ),
                ),
                const SizedBox(height: 8),
                Divider(
                  color: WabTheme.lineColor,
                  thickness: WAB_RULE_HAIRLINE,
                  height: WAB_RULE_HAIRLINE,
                ),
                const SizedBox(height: 11),
                child,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _palette() {
    final colors = <(String, Color)>[
      ('宣紙\nPAPER', WabiSabiColors.washi),
      ('霧灰\nMIST', WabiSabiColors.mist),
      ('枯木\nDEADWOOD', WabiSabiColors.deadwood),
      ('墨\nINK', WabiSabiColors.ink),
      ('青瓷\nJADE', WAB_TEXTURE_JADE_BASE_LIGHT),
      ('黏土\nCLAY', WabiSabiColors.clay),
      ('竹青\nBAMBOO', WabiSabiColors.moss),
      ('靛灰\nINDIGO', WAB_TEXTURE_CLOTH_BASE_LIGHT),
      ('秋褐\nRUST', WabiSabiColors.soil),
      ('朱砂\nSEAL', WAB_LIGHT_SEAL),
    ];
    return Column(
      children: [
        Wrap(
          spacing: 10,
          runSpacing: 11,
          children: [for (final c in colors) _colorChip(c.$1, c.$2)],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Text('墨階', style: TextStyle(color: WabTheme.mutedColor, fontSize: 8)),
            const SizedBox(width: 8),
            for (var i = 0; i < 7; i++) ...[
              Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.lerp(WabiSabiColors.washi, WabiSabiColors.ink, i / 6),
                  border: Border.all(color: WabTheme.lineColor),
                ),
              ),
              const SizedBox(width: 5),
            ],
          ],
        ),
      ],
    );
  }

  Widget _colorChip(String label, Color color) => SizedBox(
        width: 51,
        child: Column(
          children: [
            Container(
              width: 43,
              height: 43,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color,
                border: Border.all(color: WabTheme.lineColor),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: WabTheme.mutedColor,
                fontSize: 7,
                height: 1.3,
                fontFamilyFallback: kWabKaiFallback,
              ),
            ),
          ],
        ),
      );

  Widget _materials() {
    final items = <(String, WabSurfaceKind)>[
      ('紙 張 · PAPER', WabSurfaceKind.paper),
      ('木 板 · WOOD', WabSurfaceKind.woodGrain),
      ('布 料 · CLOTH', WabSurfaceKind.clothWeave),
      ('玉 石 · JADE', WabSurfaceKind.jadeSheen),
      ('白 文 · BAIWEN', WabSurfaceKind.rubbing),
      ('朱 文 · ZHUWEN', WabSurfaceKind.cinnabar),
    ];
    return Wrap(
      spacing: 9,
      runSpacing: 9,
      children: [
        for (final item in items)
          SizedBox(
            width: 105,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 60,
                  width: 105,
                  child: WabSurface(kind: item.$2, child: const SizedBox.expand()),
                ),
                const SizedBox(height: 4),
                Text(item.$1,
                    style: TextStyle(color: WabTheme.mutedColor, fontSize: 7)),
              ],
            ),
          ),
      ],
    );
  }

  Widget _typography() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: _typeSpec('文', '正文  SERIF', kWabKaiFallback, '天地有大美\n而不言')),
        const SizedBox(width: 10),
        Expanded(child: _typeSpec('筆', '展示  DISPLAY', kWabDisplayFallback, '天地有大美\n而不言')),
        const SizedBox(width: 10),
        Expanded(child: _typeSpec('器', '等寬  MONO', kWabMonoFallback, '0123456789\nWabisabi()')),
      ],
    );
  }

  Widget _typeSpec(String glyph, String label, List<String> family, String sample) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(glyph,
            style: TextStyle(
                color: WabTheme.textColor,
                fontSize: 38,
                height: 1,
                fontFamilyFallback: family)),
        const SizedBox(height: 6),
        Text(label,
            style: TextStyle(color: WabTheme.mutedColor, fontSize: 7, letterSpacing: .8)),
        const SizedBox(height: 6),
        Text(sample,
            style: TextStyle(
                color: WabTheme.textColor,
                fontSize: 12,
                height: 1.35,
                fontFamilyFallback: family)),
      ],
    );
  }

  Widget _surfaces() {
    final items = <(String, WabSurfaceKind)>[
      ('宣紙 PAPER', WabSurfaceKind.paper),
      ('纖維 FIBER', WabSurfaceKind.fiber),
      ('雲斑 MOTTLE', WabSurfaceKind.mottle),
      ('木紋 WOOD GRAIN', WabSurfaceKind.woodGrain),
      ('布紋 CLOTH WEAVE', WabSurfaceKind.clothWeave),
      ('玉面 JADE SHEEN', WabSurfaceKind.jadeSheen),
      ('拓片 RUBBING', WabSurfaceKind.rubbing),
      ('墨暈 INK WASH', WabSurfaceKind.inkWash),
      ('舊化 PATINA', WabSurfaceKind.patina),
      ('毛邊 DECKLE', WabSurfaceKind.deckle),
    ];
    return Wrap(
      spacing: 7,
      runSpacing: 9,
      children: [
        for (final item in items)
          SizedBox(
            width: 78,
            child: Column(
              children: [
                SizedBox(
                  height: 53,
                  width: 78,
                  child: WabSurface(kind: item.$2, child: const SizedBox.expand()),
                ),
                const SizedBox(height: 4),
                Text(item.$1,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: WabTheme.mutedColor, fontSize: 6.5)),
              ],
            ),
          ),
      ],
    );
  }

  Widget _rules() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: WabRuleFrame(
                kind: WabRuleKind.single,
                fill: WabTheme.paperWhite,
                child: const SizedBox(height: 37),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: WabRuleFrame(
                kind: WabRuleKind.double,
                fill: WabTheme.paperWhite,
                child: const SizedBox(height: 37),
              ),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Row(
          children: [
            Expanded(child: Text('單欄  SINGLE RULE', style: TextStyle(color: WabTheme.mutedColor, fontSize: 7))),
            const SizedBox(width: 12),
            Expanded(child: Text('雙欄  DOUBLE RULE', style: TextStyle(color: WabTheme.mutedColor, fontSize: 7))),
          ],
        ),
        const SizedBox(height: 11),
        WabPaperFold(height: 25),
        const SizedBox(height: 4),
        Text('紙摺  PAPER FOLD', style: TextStyle(color: WabTheme.mutedColor, fontSize: 7)),
        const SizedBox(height: 8),
        WabBrushDivider(),
        const SizedBox(height: 2),
        Row(
          children: [
            Text('筆觸分隔  BRUSH DIVIDER', style: TextStyle(color: WabTheme.mutedColor, fontSize: 7)),
            const Spacer(),
            DotGrid<int>(
              rows: 1,
              cols: 9,
              states: List.generate(9, (i) => i),
              styleOf: (s) => InkDotStyle(
                color: s == 4
                    ? WabTheme.textColor
                    : WabTheme.mutedColor.withOpacity(.5),
              ),
              dotSize: 5,
              gap: 7,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buttons() {
    final kinds = <(String, WabMaterialKind)>[
      ('紙  PAPER', WabMaterialKind.paper),
      ('木  WOOD', WabMaterialKind.wood),
      ('布  CLOTH', WabMaterialKind.cloth),
      ('玉  JADE', WabMaterialKind.jade),
      ('白文  BAIWEN', WabMaterialKind.baiwen),
      ('朱文  ZHUWEN', WabMaterialKind.zhuwen),
    ];
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: [
        for (final item in kinds)
          SizedBox(
            width: 112,
            child: Column(
              children: [
                WabButton(
                  kind: item.$2,
                  onPressed: () {},
                  expand: true,
                  child: const Text('Button'),
                ),
                const SizedBox(height: 4),
                Text(item.$1,
                    style: TextStyle(color: WabTheme.mutedColor, fontSize: 7)),
              ],
            ),
          ),
      ],
    );
  }

  Widget _states() {
    const states = [
      ('Default', WabButtonVisualState.normal),
      ('Hover', WabButtonVisualState.hover),
      ('Pressed', WabButtonVisualState.pressed),
      ('Disabled', WabButtonVisualState.disabled),
    ];
    const kinds = [
      WabMaterialKind.paper,
      WabMaterialKind.wood,
      WabMaterialKind.cloth,
    ];
    return Column(
      children: [
        for (final state in states)
          Padding(
            padding: const EdgeInsets.only(bottom: 7),
            child: Row(
              children: [
                SizedBox(
                  width: 52,
                  child: Text(state.$1,
                      style: TextStyle(color: WabTheme.mutedColor, fontSize: 7)),
                ),
                for (final kind in kinds) ...[
                  Expanded(
                    child: WabButton(
                      kind: kind,
                      state: state.$2,
                      onPressed: state.$2 == WabButtonVisualState.disabled ? null : () {},
                      expand: true,
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 7),
                      child: const Text('Button'),
                    ),
                  ),
                  const SizedBox(width: 7),
                ],
              ],
            ),
          ),
        const SizedBox(height: 4),
        WabToggleButton(
          text: Text(_toggle ? 'ON · 玉印' : 'OFF · 玉印'),
          isOn: _toggle,
          pair: WabTogglePair.jadeBaiwen,
          callback: () => setState(() => _toggle = !_toggle),
        ),
      ],
    );
  }

  Widget _inputs() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: WabTextFormField(hintText: '輸入文字…')),
            const SizedBox(width: 9),
            Expanded(child: WabSearchField(hintText: '搜尋…')),
          ],
        ),
        const SizedBox(height: 8),
        WabMultilineField(hintText: '多行輸入…', minLines: 2, maxLines: 3),
        const SizedBox(height: 7),
        Wrap(
          spacing: 8,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            WabCheckbox(
              value: _check,
              label: '複選框',
              onChanged: (v) => setState(() => _check = v ?? false),
            ),
            WabRadio<int>(
              value: 1,
              groupValue: _radio,
              label: '單選框',
              onChanged: (v) => setState(() => _radio = v ?? 0),
            ),
            WabSwitch(
              value: _switch,
              label: '開關',
              onChanged: (v) => setState(() => _switch = v),
            ),
          ],
        ),
        WabSlider(
          value: _slider,
          onChanged: (v) => setState(() => _slider = v),
        ),
        Row(
          children: [
            Expanded(
              child: WabDropdown<String>(
                value: _dropdown,
                items: const {'春': '春 · SPRING', '秋': '秋 · AUTUMN'},
                onChanged: (v) => setState(() => _dropdown = v ?? '春'),
              ),
            ),
            const SizedBox(width: 9),
            Expanded(child: WabNumberFormField(value: 12, labelText: '數字')),
          ],
        ),
      ],
    );
  }

  Widget _badges() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Wrap(
          spacing: 7,
          runSpacing: 7,
          children: [
            WabStatusBadge('Default'),
            WabStatusBadge('Primary', kind: WabBadgeKind.primary),
            WabStatusBadge('Success', kind: WabBadgeKind.success),
            WabStatusBadge('Warning', kind: WabBadgeKind.warning),
            WabStatusBadge('Error', kind: WabBadgeKind.error),
          ],
        ),
        const SizedBox(height: 13),
        Row(
          children: [
            WabSealMark(text: '侘寂', size: 50, seed: 3),
            const SizedBox(width: 10),
            WabSealMark(text: '留白', kind: WabSealMarkKind.zhuwen, size: 50, seed: 9),
            const Spacer(),
            const WabStarRating(rating: 4),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            for (final color in [
              WabTheme.sealColor,
              WabTheme.accentColor,
              WabTheme.mutedColor,
              WabTheme.offColor,
            ]) ...[
              InkDot(style: InkDotStyle(color: color), size: 8),
              const SizedBox(width: 6),
            ],
          ],
        ),
      ],
    );
  }

  Widget _cards() {
    return Column(
      children: [
        WabPanel(
          title: '面板標題',
          trailing: const WabStatusBadge('PANEL'),
          child: Text(
            'WabPanel · 單欄紙面，內部只使用淡墨細線。',
            style: TextStyle(color: WabTheme.mutedColor, fontSize: 9),
          ),
        ),
        const SizedBox(height: 9),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: WabCollectionCard(
                icon: Icon(Icons.auto_awesome_outlined,
                    color: WabTheme.textColor, size: 26),
                title: '基礎卡片',
                description: '內容、題名與動作依古籍版心次序組織。',
                buttonLabel: 'ACTION',
                onPressed: () {},
              ),
            ),
            const SizedBox(width: 9),
            Expanded(
              child: WabSurface(
                kind: WabSurfaceKind.paper,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    '內容區塊\n\n用於放置具體內容，保持平面，不用不必要的 elevation。',
                    style: TextStyle(
                      color: WabTheme.textColor,
                      fontSize: 9,
                      height: 1.45,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _shadows() {
    Widget sample(String label, WabSurfaceKind kind, List<BoxShadow> shadow) => Expanded(
          child: Column(
            children: [
              Container(
                height: 55,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(WAB_CARD_BORDER_RADIUS),
                  boxShadow: shadow,
                ),
                child: WabSurface(kind: kind, child: const SizedBox.expand()),
              ),
              const SizedBox(height: 5),
              Text(label,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: WabTheme.mutedColor, fontSize: 7)),
            ],
          ),
        );
    return Row(
      children: [
        sample('紙 · 懸浮\nFLOATING', WabSurfaceKind.paper, WabTheme.elevationShadow),
        const SizedBox(width: 10),
        sample('木 · 自然投影\nWOOD', WabSurfaceKind.woodGrain, WabTheme.elevationShadow),
        const SizedBox(width: 10),
        sample('玉 · 右下投影\nJADE', WabSurfaceKind.jadeSheen, WabTheme.elevationShadow),
      ],
    );
  }

  Widget _lightDark() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 86,
                child: WabSurface(
                  kind: WabSurfaceKind.paper,
                  isDark: false,
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(9),
                      child: Text('日：宣紙\nLIGHT THEME',
                          style: TextStyle(color: WAB_LIGHT_TEXT, fontSize: 8)),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: SizedBox(
                height: 86,
                child: WabSurface(
                  kind: WabSurfaceKind.rubbing,
                  isDark: true,
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(9),
                      child: Text('夜：拓片\nDARK THEME',
                          style: TextStyle(color: WAB_DARK_TEXT, fontSize: 8)),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        WabTextButton(
          text: Text(widget.isDark ? '切換至宣紙 · LIGHT' : '切換至拓片 · DARK'),
          callback: widget.onToggleTheme,
          padding: 10,
        ),
      ],
    );
  }
}
