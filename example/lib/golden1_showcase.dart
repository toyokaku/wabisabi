import 'package:flutter/material.dart';
import 'package:wabisabi/wabisabi.dart';

import 'golden1_refinements.dart';
import 'golden1_sections.dart';
import 'kit_coverage_sections.dart';

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
  final _sectionKeys = List<GlobalKey>.generate(15, (_) => GlobalKey());
  int _selected = 0;
  bool _check = true;
  int _radio = 0;
  bool _switch = true;
  double _slider = .42;
  bool _toggle = true;

  // CI/local builds can override with --dart-define=WAB_BUILD_HASH=<sha>.
  static const _buildHash = String.fromEnvironment(
    'WAB_BUILD_HASH',
    defaultValue: 'e248347',
  );

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
    '13 骨架 · SCAFFOLD & CHROME',
    '14 紋理 · TEXTURE PRIMITIVES',
    '15 零件 · ODDS & ENDS',
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
    '13  骨架 | SCAFFOLD & CHROME',
    '14  紋理 | TEXTURE PRIMITIVES',
    '15  零件 | ODDS & ENDS',
  ];

  static const _subtitles = [
    '調煉紙、墨、木、土、釉的克制色系',
    '數字化的東方材質語言',
    '標題、正文、數字：統一的文字體系',
    '生成式材質表面（無圖片資產）',
    '源自古籍的欄界與紙摺語言',
    '多材質按鈕體系',
    '克制而自然的狀態變化',
    '欄界語言延伸至現代輸入控件',
    '源自印章與題簽的標記語言',
    '內容容器與信息組織',
    '源自實物紙邊的接觸投影',
    '行墨與拓片的雙重世界',
    '頁面骨架、題頭與導覽家具',
    'WabSurface 底下的單支畫筆',
    '其餘導出組件，含自持狀態者',
  ];

  static const _desktopRows = <double>[245, 305, 300, 250, 300];

  /// The width one board cell gets on a full-size desktop board. Every section
  /// is composed against it, so the narrow layout renders at the same geometry
  /// and scales the whole cell down rather than re-flowing each specimen.
  static const _cellDesignWidth = 460.0;

  /// Below this the sidebar and the three-column board are dropped for a
  /// single scrolling column of cells.
  static const _compactWidth = 900.0;
  static const _boardTop = 10.0;
  static const _boardBottom = 30.0;

  List<double> get _desktopFolds {
    final total = _boardTop +
        _boardBottom +
        _desktopRows.fold<double>(0, (sum, value) => sum + value);
    var cursor = _boardTop;
    final result = <double>[];
    for (var i = 0; i < _desktopRows.length - 1; i++) {
      cursor += _desktopRows[i];
      result.add(cursor / total);
    }
    return result;
  }

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
            LayoutBuilder(
              builder: (context, constraints) {
                // The build stamp is the widest thing in the masthead; on a
                // narrow sheet the theme toggle is the only action worth the
                // room it costs.
                final compact = constraints.maxWidth < _compactWidth;
                return WabPaperSheet(
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
                  if (!compact) ...[
                    Text(
                      'v0.2 · BUILD $_buildHash\nLESS, BUT DEEPER.',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: WabTheme.mutedColor,
                        fontFamily: kWabMonoFamily,
                        fontSize: 7,
                        letterSpacing: 1.45,
                        height: 1.35,
                      ),
                    ),
                    const SizedBox(width: 12),
                  ],
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
                );
              },
            ),
            Divider(
              height: 1,
              thickness: WAB_RULE_HAIRLINE,
              color: WabTheme.lineColor,
            ),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  if (constraints.maxWidth < _compactWidth) return _mobileBoard();
                  return Row(
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
                  );
                },
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
    return SingleChildScrollView(
          child: WabPaperSheet(
            isDark: widget.isDark,
            horizontalFolds: _desktopFolds,
            verticalFolds: const [.333333, .666667],
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, _boardTop, 16, _boardBottom),
              child: Column(
                children: [
                  _row(_desktopRows[0], [0, 1, 2]),
                  _row(_desktopRows[1], [3, 4, 5]),
                  _row(_desktopRows[2], [6, 7, 8]),
                  _row(_desktopRows[3], [9, 10, 11]),
                  _row(_desktopRows[4], [12, 13, 14]),
                ],
              ),
            ),
          ),
        );
  }

  /// Narrow layout: one column of cells, each drawn at [_cellDesignWidth] and
  /// scaled to the sheet. The sections were composed for a fixed cell — they
  /// use Expanded and Spacer against a known box — so scaling the finished cell
  /// keeps the composition intact where re-flowing it would not. Never scales
  /// up, so a wide-but-not-wide-enough window gets a centred column at native
  /// size rather than a blurry blow-up.
  Widget _mobileBoard() {
    return LayoutBuilder(
      builder: (context, constraints) {
        const sheetPadding = 14.0;
        final available = constraints.maxWidth - sheetPadding * 2;
        final scale = (available / _cellDesignWidth).clamp(.4, 1.0).toDouble();

        return SingleChildScrollView(
          child: WabPaperSheet(
            isDark: widget.isDark,
            horizontalFolds: const [],
            verticalFolds: const [],
            child: Padding(
              padding: const EdgeInsets.all(sheetPadding),
              child: Column(
                children: [
                  for (var i = 0; i < _nav.length; i++) ...[
                    _scaledCell(i, scale),
                    const SizedBox(height: 18),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _scaledCell(int index, double scale) {
    final height = _desktopRows[index ~/ 3];
    return SizedBox(
      width: _cellDesignWidth * scale,
      height: height * scale,
      child: FittedBox(
        fit: BoxFit.contain,
        alignment: Alignment.topCenter,
        child: SizedBox(
          width: _cellDesignWidth,
          height: height,
          child: _section(index),
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
              child: ClipRect(
                child: Transform.scale(
                  scaleX: 1.002,
                  scaleY: 1.002,
                  alignment: Alignment.topLeft,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.topCenter,
                    child: SizedBox(
                      width: _cellDesignWidth,
                      height: height,
                      child: _section(index),
                    ),
                  ),
                ),
              ),
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
      4 => refinedRulesSection(),
      5 => refinedButtonsSection(),
      6 => goldenStatesSection(
          toggle: _toggle,
          onToggle: () => setState(() => _toggle = !_toggle),
        ),
      7 => goldenInputsSection(
          check: _check,
          radio: _radio,
          switchValue: _switch,
          slider: _slider,
          onCheck: (v) => setState(() => _check = v ?? false),
          onRadio: (v) => setState(() => _radio = v ?? 0),
          onSwitch: (v) => setState(() => _switch = v),
          onSlider: (v) => setState(() => _slider = v),
        ),
      8 => goldenMarksSection(),
      9 => goldenCardsSection(),
      10 => goldenShadowsSection(),
      11 => goldenLightDarkSection(
          isDark: widget.isDark,
          onToggle: widget.onToggleTheme,
        ),
      12 => kitChromeSection(),
      13 => kitTexturePrimitivesSection(),
      _ => const KitOddsAndEndsSection(),
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
