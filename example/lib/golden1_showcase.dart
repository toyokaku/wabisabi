import 'package:flutter/material.dart';
import 'package:wabisabi/wabisabi.dart';

/// Golden-board catalogue: the existing banner + left rail layout is retained,
/// while the body is reorganised around the 01–12 material language in
/// golden1.png. Every section is still a live widget demo, not a static poster.
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

  static const _subtitles = [
    '調煉紙、墨、木、土、釉的克制色系',
    '數字化的東方材質語言',
    '傳統、正文、數字：統一的文字體系',
    '生成式材質表面，不依賴圖片資產',
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
          Positioned.fill(child: WabPaperTexture(isDark: widget.isDark)),
          Column(
            children: [
              _masthead(),
              WabDivider(),
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
      height: 104,
      title: '現代應用的東方美學界面系統',
      subtitle: 'A TIMELESS UI SYSTEM FOR MODERN APPS',
      leading: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '侘 寂',
            style: TextStyle(
              color: WabTheme.textColor,
              fontSize: 30,
              height: 1,
              letterSpacing: 8,
              fontFamilyFallback: kWabDisplayFallback,
            ),
          ),
          const SizedBox(width: 16),
          SizedBox(
            height: 54,
            child: VerticalDivider(
              color: WabTheme.lineColor,
              thickness: WAB_RULE_HAIRLINE,
            ),
          ),
          const SizedBox(width: 12),
          Text(
            'WABISABI\nUI KIT',
            style: TextStyle(
              color: WabTheme.mutedColor,
              fontSize: 10,
              letterSpacing: 3,
              height: 1.5,
              fontFamilyFallback: kWabMonoFallback,
            ),
          ),
        ],
      ),
      seal: WabSealMark(text: '侘寂', size: 30, seed: 17),
      trailing: [
        Text(
          '取法自然 · 材質為語 · 克制為美 · 留白生境',
          style: TextStyle(
            color: WabTheme.mutedColor,
            fontSize: 11,
            letterSpacing: 2,
            fontFamilyFallback: kWabKaiFallback,
          ),
        ),
        const SizedBox(width: 18),
        WabIconButton(
          icon: Icon(
            widget.isDark ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
            size: 17,
          ),
          kind: WabMaterialKind.zhuwen,
          callback: widget.onToggleTheme,
        ),
      ],
    );
  }

  Widget _sidebar() {
    return WabSidebar(
      width: 222,
      padding: const EdgeInsets.fromLTRB(18, 22, 18, 22),
      children: [
        WabProfileHeader(
          name: '素材庫',
          subtitle: 'MATERIAL INDEX · v0.2',
          avatar: const AssetImage('images/avatar.jpg'),
        ),
        const SizedBox(height: 22),
        for (var i = 0; i < _nav.length; i++)
          Opacity(
            opacity: _selectedSection == i ? 1 : .68,
            child: WabTextButton(
              text: Text(
                _nav[i],
                style: TextStyle(
                  fontWeight: _selectedSection == i
                      ? FontWeight.w700
                      : FontWeight.w400,
                ),
              ),
              callback: () => _jumpTo(i),
              mergeTop: i != 0,
              padding: 12,
            ),
          ),
        const Spacer(),
        Text(
          'LESS, BUT DEEPER.',
          style: TextStyle(
            color: WabTheme.mutedColor,
            fontSize: 9,
            letterSpacing: 3,
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
        final columns = width >= 1080 ? 3 : (width >= 720 ? 2 : 1);
        final cardWidth = (width - 48 - (columns - 1) * 16) / columns;
        return ListView(
          padding: const EdgeInsets.fromLTRB(24, 26, 24, 72),
          children: [
            Text(
              '取 法 自 然',
              style: TextStyle(
                color: WabTheme.textColor,
                fontSize: 34,
                letterSpacing: 12,
                fontFamilyFallback: kWabDisplayFallback,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'MATERIAL · TYPOGRAPHY · RHYTHM · COMPONENTS',
              style: TextStyle(
                color: WabTheme.mutedColor,
                fontSize: 10,
                letterSpacing: 3,
                fontFamilyFallback: kWabMonoFallback,
              ),
            ),
            const SizedBox(height: 18),
            WabBrushDivider(),
            const SizedBox(height: 24),
            Wrap(
              spacing: 16,
              runSpacing: 16,
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
      child: WabRuleFrame(
        kind: WabRuleKind.single,
        fill: WabTheme.surfaceColor,
        texture: WabPaperTexture(isDark: widget.isDark),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    _nav[index].substring(0, 2),
                    style: TextStyle(
                      color: WabTheme.textColor,
                      fontSize: 18,
                      fontFamilyFallback: kWabMonoFallback,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      _nav[index].substring(3),
                      style: TextStyle(
                        color: WabTheme.textColor,
                        fontSize: 18,
                        letterSpacing: 1.5,
                        fontFamilyFallback: kWabDisplayFallback,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 2),
              Text(
                _subtitles[index],
                style: TextStyle(
                  color: WabTheme.mutedColor,
                  fontSize: 10,
                  letterSpacing: 1,
                  fontFamilyFallback: kWabKaiFallback,
                ),
              ),
              const SizedBox(height: 10),
              Divider(
                color: WabTheme.lineColor,
                thickness: WAB_RULE_HAIRLINE,
                height: WAB_RULE_HAIRLINE,
              ),
              const SizedBox(height: 14),
              child,
            ],
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
      ('青瓷\nJADE', WAB_JADE_BASE_LIGHT),
      ('黏土\nCLAY', WabiSabiColors.clay),
      ('竹青\nBAMBOO', WabiSabiColors.moss),
      ('靛灰\nINDIGO', WabiSabiColors.indigoDye),
      ('秋褐\nRUST', WabiSabiColors.soil),
      ('朱砂\nSEAL', WabiSabiColors.rust),
    ];
    return Column(
      children: [
        Wrap(
          spacing: 12,
          runSpacing: 14,
          children: [for (final c in colors) _colorChip(c.$1, c.$2)],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Text('墨階', style: TextStyle(color: WabTheme.mutedColor, fontSize: 10)),
            const SizedBox(width: 10),
            for (var i = 0; i < 7; i++) ...[
              Container(
                width: 19,
                height: 19,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.lerp(WabiSabiColors.washi, WabiSabiColors.ink, i / 6),
                  border: Border.all(color: WabTheme.lineColor),
                ),
              ),
              const SizedBox(width: 7),
            ],
          ],
        ),
      ],
    );
  }

  Widget _colorChip(String label, Color color) => SizedBox(
        width: 58,
        child: Column(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color,
                border: Border.all(color: WabTheme.lineColor),
              ),
            ),
            const SizedBox(height: 5),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: WabTheme.mutedColor,
                fontSize: 8,
                height: 1.35,
                fontFamilyFallback: kWabKaiFallback,
              ),
            ),
          ],
        ),
      );

  Widget _materials() {
    final items = <(String, WabSurfaceKind)>[
      ('紙 張 · PAPER', WabSurfaceKind.mottle),
      ('木 板 · WOOD', WabSurfaceKind.woodGrain),
      ('布 料 · CLOTH', WabSurfaceKind.clothWeave),
      ('玉 石 · JADE', WabSurfaceKind.jadeSheen),
      ('白 文 · BAIWEN', WabSurfaceKind.rubbing),
      ('朱 文 · ZHUWEN', WabSurfaceKind.patina),
    ];
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: [
        for (final item in items)
          SizedBox(
            width: 112,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 62,
                  width: 112,
                  child: WabSurface(
                    kind: item.$2,
                    child: const SizedBox.expand(),
                  ),
                ),
                const SizedBox(height: 5),
                Text(item.$1,
                    style: TextStyle(color: WabTheme.mutedColor, fontSize: 8)),
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
        Expanded(child: _typeSpec('文', '正 文  SERIF', kWabKaiFallback, '天地有大美\n而不言')),
        const SizedBox(width: 12),
        Expanded(child: _typeSpec('筆', '展示  DISPLAY', kWabDisplayFallback, '天地有大美\n而不言')),
        const SizedBox(width: 12),
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
                fontSize: 42,
                height: 1,
                fontFamilyFallback: family)),
        const SizedBox(height: 8),
        Text(label,
            style: TextStyle(color: WabTheme.mutedColor, fontSize: 8, letterSpacing: 1)),
        const SizedBox(height: 8),
        Text(sample,
            style: TextStyle(
                color: WabTheme.textColor,
                fontSize: 14,
                height: 1.4,
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
      spacing: 8,
      runSpacing: 10,
      children: [
        for (final item in items)
          SizedBox(
            width: 83,
            child: Column(
              children: [
                SizedBox(
                  height: 48,
                  width: 83,
                  child: WabSurface(kind: item.$2, child: const SizedBox.expand()),
                ),
                const SizedBox(height: 4),
                Text(item.$1,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: WabTheme.mutedColor, fontSize: 7.5)),
              ],
            ),
          ),
      ],
    );
  }

  Widget _rules() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: WabRuleFrame(
                kind: WabRuleKind.single,
                fill: WabTheme.paperWhite,
                child: const SizedBox(height: 42),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: WabRuleFrame(
                kind: WabRuleKind.double,
                fill: WabTheme.paperWhite,
                child: const SizedBox(height: 42),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            Expanded(child: Text('單欄  SINGLE RULE', style: TextStyle(color: WabTheme.mutedColor, fontSize: 8))),
            const SizedBox(width: 12),
            Expanded(child: Text('雙欄  DOUBLE RULE', style: TextStyle(color: WabTheme.mutedColor, fontSize: 8))),
          ],
        ),
        const SizedBox(height: 14),
        WabPaperFold(
          child: SizedBox(
            height: 26,
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text('紙摺  PAPER FOLD', style: TextStyle(color: WabTheme.mutedColor, fontSize: 8)),
            ),
          ),
        ),
        const SizedBox(height: 10),
        WabBrushDivider(),
        const SizedBox(height: 10),
        DotGrid<int>(
          rows: 1,
          cols: 10,
          states: List.generate(10, (i) => i),
          styleOf: (s) => InkDotStyle(
            color: s == 5 ? WabTheme.textColor : WabTheme.mutedColor.withOpacity(.48),
          ),
          dotSize: 7,
          gap: 8,
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            for (final item in kinds)
              SizedBox(
                width: 118,
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
                        style: TextStyle(color: WabTheme.mutedColor, fontSize: 8)),
                  ],
                ),
              ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: WabElevatedButton(
                text: const Text('WabElevatedButton'),
                showChevron: true,
                callback: () {},
              ),
            ),
            const SizedBox(width: 10),
            WabIconButton(
              icon: const Icon(Icons.brush, size: 17),
              label: const Text('WabIconButton'),
              callback: () {},
            ),
          ],
        ),
      ],
    );
  }

  Widget _states() {
    final kinds = [WabMaterialKind.paper, WabMaterialKind.wood, WabMaterialKind.cloth];
    Widget row(String label, {double opacity = 1, double dy = 0}) => Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            children: [
              SizedBox(width: 58, child: Text(label, style: TextStyle(color: WabTheme.mutedColor, fontSize: 9))),
              for (final kind in kinds) ...[
                Expanded(
                  child: Transform.translate(
                    offset: Offset(0, dy),
                    child: Opacity(
                      opacity: opacity,
                      child: WabButton(
                        kind: kind,
                        onPressed: label == 'Disabled' ? null : () {},
                        expand: true,
                        child: const Text('Button'),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
              ],
            ],
          ),
        );
    return Column(
      children: [
        row('Default'),
        row('Hover', opacity: .9),
        row('Pressed', dy: 1),
        row('Disabled', opacity: .42),
        const SizedBox(height: 8),
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
            const SizedBox(width: 10),
            Expanded(child: WabSearchField(hintText: '搜尋…')),
          ],
        ),
        const SizedBox(height: 10),
        WabMultilineField(hintText: '多行輸入…', minLines: 2, maxLines: 3),
        const SizedBox(height: 8),
        Wrap(
          spacing: 10,
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
            const SizedBox(width: 10),
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
          spacing: 8,
          runSpacing: 8,
          children: [
            WabStatusBadge('Default'),
            WabStatusBadge('Primary', kind: WabBadgeKind.primary),
            WabStatusBadge('Success', kind: WabBadgeKind.success),
            WabStatusBadge('Warning', kind: WabBadgeKind.warning),
            WabStatusBadge('Error', kind: WabBadgeKind.error),
          ],
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            WabSealMark(text: '侘寂', size: 54, seed: 3),
            const SizedBox(width: 12),
            WabSealMark(text: '留白', kind: WabSealMarkKind.zhuwen, size: 54, seed: 9),
            const SizedBox(width: 12),
            WabSurface(
              kind: WabSurfaceKind.paper,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
                child: Text('題\n簽', textAlign: TextAlign.center, style: TextStyle(color: WabTheme.textColor)),
              ),
            ),
            const Spacer(),
            const WabStarRating(rating: 4),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            for (final color in [
              WabTheme.sealColor,
              WabTheme.accentColor,
              WabTheme.mutedColor,
              WabTheme.offColor,
            ]) ...[
              InkDot(style: InkDotStyle(color: color), size: 9),
              const SizedBox(width: 7),
            ],
          ],
        ),
      ],
    );
  }

  Widget _cards() {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: WabCollectionCard(
                icon: Icon(Icons.auto_awesome_outlined, color: WabTheme.textColor, size: 32),
                title: '基礎卡片',
                description: '內容、題名與動作依古籍版心次序組織。',
                buttonLabel: 'ACTION',
                onPressed: () {},
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: WabPanel(
                title: '面板標題',
                trailing: const WabStatusBadge('PANEL'),
                child: Text(
                  'WabPanel 使用單粗欄，內部分隔仍保持淡墨細線。',
                  style: TextStyle(color: WabTheme.mutedColor, fontSize: 11),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        WabContentContainer(
          child: Row(
            children: [
              WabImage(path: 'images/avatar.jpg', width: 54, height: 54, borderRadius: WAB_CARD_BORDER_RADIUS),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'WabContentContainer · WabImage\n內容區塊保持平面，讓材質承擔層級。',
                  style: TextStyle(color: WabTheme.textColor, fontSize: 10),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _shadows() {
    Widget sample(String label, WabSurfaceKind kind, List<BoxShadow> shadow) => Expanded(
          child: Column(
            children: [
              Container(
                height: 58,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(WAB_CARD_BORDER_RADIUS),
                  boxShadow: shadow,
                ),
                child: WabSurface(kind: kind, child: const SizedBox.expand()),
              ),
              const SizedBox(height: 6),
              Text(label,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: WabTheme.mutedColor, fontSize: 8)),
            ],
          ),
        );
    return Row(
      children: [
        sample('懸浮\nFLOATING', WabSurfaceKind.paper, WabTheme.elevationShadow),
        const SizedBox(width: 12),
        sample('木 · 自然投影\nWOOD', WabSurfaceKind.woodGrain, WabTheme.elevationShadow),
        const SizedBox(width: 12),
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
                height: 92,
                child: WabSurface(
                  kind: WabSurfaceKind.mottle,
                  isDark: false,
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text('日：宣紙\nLIGHT THEME',
                          style: TextStyle(color: WAB_LIGHT_TEXT, fontSize: 9)),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: SizedBox(
                height: 92,
                child: WabSurface(
                  kind: WabSurfaceKind.rubbing,
                  isDark: true,
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text('夜：拓片\nDARK THEME',
                          style: TextStyle(color: WAB_DARK_TEXT, fontSize: 9)),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        WabTextButton(
          text: Text(widget.isDark ? '切換至宣紙 · LIGHT' : '切換至拓片 · DARK'),
          callback: widget.onToggleTheme,
          padding: 12,
        ),
      ],
    );
  }
}
