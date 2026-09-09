import 'package:flutter/material.dart';
import 'package:wabisabi/wabisabi.dart';

import 'golden1_sections.dart';

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
  int _selected = 0;
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

  static const _titles = [
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
    setState(() => _selected = index);
    final context = _sectionKeys[index].currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 280),
        curve: Curves.easeOutCubic,
        alignment: .02,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return WabTypographyScope(
      child: Scaffold(
        backgroundColor: WabTheme.backgroundColor,
        body: Column(
          children: [
            WabPaperSheet(
              isDark: widget.isDark,
              horizontalFolds: const [],
              verticalFolds: const [],
              child: WabEditorialBanner(
                brand: '侘 寂',
                kitLabel: 'WABISABI\nUI KIT',
                title: '現代應用的東方美學界面系統',
                subtitle: 'A TIMELESS UI SYSTEM FOR MODERN APPS',
                motto: '取法自然 · 材質為語 · 克制為美 · 留白生境',
                seal: WabSealMark(text: '侘寂', size: 25, seed: 17),
                trailing: [
                  Text(
                    'v0.2\nLESS, BUT DEEPER.',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: WabTheme.mutedColor,
                      fontFamily: kWabMonoFamily,
                      fontSize: 7,
                      letterSpacing: 1.7,
                      height: 1.35,
                    ),
                  ),
                  const SizedBox(width: 12),
                  WabIconButton(
                    icon: Icon(
                      widget.isDark
                          ? Icons.light_mode_outlined
                          : Icons.dark_mode_outlined,
                      size: 15,
                    ),
                    kind: WabMaterialKind.zhuwen,
                    callback: widget.onToggleTheme,
                  ),
                ],
              ),
            ),
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
                  Expanded(child: _board()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sidebar() {
    return WabPaperSheet(
      isDark: widget.isDark,
      horizontalFolds: const [],
      verticalFolds: const [],
      child: WabSidebar(
        width: 184,
        padding: const EdgeInsets.fromLTRB(15, 18, 15, 18),
        children: [
          Text(
            '素 材 庫',
            style: TextStyle(
              color: WabTheme.textColor,
              fontFamily: kWabDisplayFamily,
              fontSize: 15,
              fontWeight: FontWeight.w500,
              letterSpacing: 3,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            'MATERIAL INDEX · v0.2',
            style: TextStyle(
              color: WabTheme.mutedColor,
              fontFamily: kWabMonoFamily,
              fontSize: 7,
              letterSpacing: 1.4,
            ),
          ),
          const SizedBox(height: 16),
          for (var i = 0; i < _nav.length; i++)
            Opacity(
              opacity: _selected == i ? 1 : .63,
              child: WabTextButton(
                text: Text(
                  _nav[i],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: kWabMonoFamily,
                    fontSize: 8,
                    fontWeight:
                        _selected == i ? FontWeight.w500 : FontWeight.w400,
                    letterSpacing: .8,
                  ),
                ),
                callback: () => _jumpTo(i),
                mergeTop: i != 0,
                padding: 9,
              ),
            ),
          const Spacer(),
          Text(
            'LESS, BUT DEEPER.',
            style: TextStyle(
              color: WabTheme.mutedColor,
              fontFamily: kWabMonoFamily,
              fontSize: 7,
              letterSpacing: 2.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _board() {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 900) return _mobileBoard();

        const totalHeight = 1100.0;
        return SingleChildScrollView(
          child: WabPaperSheet(
            isDark: widget.isDark,
            horizontalFolds: const [
              0.2227272727,
              0.5,
              0.7727272727,
            ],
            verticalFolds: const [0.3333333333, 0.6666666667],
            child: SizedBox(
              height: totalHeight,
              child: Column(
                children: [
                  _row(245, [0, 1, 2]),
                  _row(305, [3, 4, 5]),
                  _row(300, [6, 7, 8]),
                  _row(250, [9, 10, 11]),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _mobileBoard() {
    return SingleChildScrollView(
      child: WabPaperSheet(
        isDark: widget.isDark,
        horizontalFolds: const [],
        verticalFolds: const [],
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            children: [
              for (var i = 0; i < 12; i++) ...[
                SizedBox(height: 310, child: _section(i)),
                const SizedBox(height: 18),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _row(double height, List<int> indices) {
    return SizedBox(
      height: height,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (final index in indices)
            Expanded(
              child: ClipRect(child: _section(index)),
            ),
        ],
      ),
    );
  }

  Widget _section(int index) {
    final content = switch (index) {
      0 => goldenPaletteSection(),
      1 => goldenMaterialsSection(),
      2 => goldenTypographySection(),
      3 => goldenSurfacesSection(),
      4 => goldenRulesSection(),
      5 => goldenButtonsSection(),
      6 => goldenStatesSection(
          toggle: _toggle,
          onToggle: () => setState(() => _toggle = !_toggle),
        ),
      7 => goldenInputsSection(
          check: _check,
          radio: _radio,
          switchValue: _switch,
          slider: _slider,
          dropdown: _dropdown,
          onCheck: (v) => setState(() => _check = v ?? false),
          onRadio: (v) => setState(() => _radio = v ?? 0),
          onSwitch: (v) => setState(() => _switch = v),
          onSlider: (v) => setState(() => _slider = v),
          onDropdown: (v) => setState(() => _dropdown = v ?? '春'),
        ),
      8 => goldenMarksSection(),
      9 => goldenCardsSection(),
      10 => goldenShadowsSection(),
      _ => goldenLightDarkSection(
          isDark: widget.isDark,
          onToggle: widget.onToggleTheme,
        ),
    };

    return KeyedSubtree(
      key: _sectionKeys[index],
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 11, 12, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _titles[index],
              style: TextStyle(
                color: WabTheme.textColor,
                fontFamily: kWabKaiFamily,
                fontSize: 13,
                fontWeight: FontWeight.w500,
                letterSpacing: .7,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              _subtitles[index],
              style: TextStyle(
                color: WabTheme.mutedColor,
                fontFamily: kWabKaiFamily,
                fontSize: 7.5,
                letterSpacing: .4,
              ),
            ),
            const SizedBox(height: 7),
            Divider(
              height: 1,
              thickness: WAB_RULE_HAIRLINE,
              color: WabTheme.lineColor.withOpacity(.55),
            ),
            const SizedBox(height: 10),
            Expanded(child: content),
          ],
        ),
      ),
    );
  }
}
