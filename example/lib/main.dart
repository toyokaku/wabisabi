import 'package:flutter/material.dart';
import 'package:wabisabi/wabisabi.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDark = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: WabTheme.materialTheme(lightTheme: !isDark),
      home: Showcase(
        isDark: isDark,
        onToggleTheme: () => setState(() => isDark = !isDark),
      ),
    );
  }
}

/// A catalogue of every wabisabi widget. Top banner and left rail are kept
/// separate from the body; the body is a vertical scrolling list of widgets,
/// each labelled with its class name.
class Showcase extends StatefulWidget {
  const Showcase({super.key, required this.isDark, required this.onToggleTheme});
  final bool isDark;
  final VoidCallback onToggleTheme;

  @override
  State<Showcase> createState() => _ShowcaseState();
}

class _ShowcaseState extends State<Showcase> {
  String _nav = 'WabNavItem (selected)';
  bool _toggle = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WabTheme.backgroundColor,
      body: Stack(
        children: [
          // 紙紋 overlay across the whole scaffold background.
          Positioned.fill(child: WabPaperTexture()), // 非 const：讀主題態
          Column(
            children: [
              _banner(),
              WabDivider(),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _sidebar(),
                    VerticalDivider(width: 1, color: WabTheme.secondaryColor),
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

  // ---- Top panel ----------------------------------------------------------

  Widget _banner() => WabBanner(
        title: 'WabBanner',
        subtitle: 'top banner',
        seal: _seal(),
        leading: Icon(Icons.menu, color: WabTheme.textColor),
        trailing: [
          const Spacer(flex: 3),
          Flexible(flex: 2, child: WabSearchField(hintText: 'WabSearchField')),
          const SizedBox(width: 8),
          IconButton(
            tooltip: 'toggle theme',
            icon: Icon(
              widget.isDark ? Icons.light_mode : Icons.dark_mode,
              color: WabTheme.textColor,
            ),
            onPressed: widget.onToggleTheme,
          ),
        ],
      );

  Widget _seal() => Transform.rotate(
        angle: -0.035, // 侘寂 seal chip, rotated -2°
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: WabTheme.sealColor,
            borderRadius: BorderRadius.circular(WAB_BADGE_RADIUS),
          ),
          alignment: Alignment.center,
          child: Text(
            '侘\n寂',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: WabTheme.paperWhite,
              fontSize: 13,
              height: 1.05,
              fontFamilyFallback: kWabDisplayFallback,
            ),
          ),
        ),
      );

  // ---- Left panel ---------------------------------------------------------

  Widget _sidebar() => WabSidebar(
        children: [
          // 非 const：讀全局主題態，const 會把晝夜凍結在首幀
          WabProfileHeader(name: 'WabProfileHeader', subtitle: 'profile'),
          const SizedBox(height: 24),
          for (final label in const ['WabNavItem', 'WabNavItem (selected)'])
            WabNavItem(
              label: label,
              selected: _nav == label,
              onTap: () => setState(() => _nav = label),
            ),
        ],
      );

  // ---- Body: scrolling widget list ---------------------------------------

  Widget _body() => ListView(
        padding: const EdgeInsets.all(24),
        children: [
          _demo('WabPanel', WabPanel(
            title: 'WabPanel',
            trailing: WabStatusBadge('trailing', kind: WabBadgeKind.neutral),
            child: const Text('A titled section surface — deckle-edge paper face.'),
          )),
          _demo('DeckleBorder', Container(
            decoration: ShapeDecoration(
              color: WabTheme.surfaceColor,
              shape: DeckleBorder(
                roughness: WAB_DECKLE_ROUGHNESS_METRIC,
                seed: WAB_DECKLE_SEED_METRIC,
              ),
            ),
            padding: const EdgeInsets.all(16),
            child: Text(
              'Metric deckle edge — roughness 1.5, seed 21. Rebuild-stable.',
              style: TextStyle(color: WabTheme.mutedColor),
            ),
          )),
          _demo('WabWoodGrain', _woodPanel()),
          _demo('WabBrushDivider', WabBrushDivider()),
          _demo('WabPaperTexture', Container(
            height: 90,
            color: WabTheme.surfaceColor,
            child: WabPaperTexture(
              child: Center(
                child: Text('dots + fibers, fixed seed',
                    style: TextStyle(color: WabTheme.mutedColor, fontSize: 12)),
              ),
            ),
          )),
          _demo('WabInkWash', Container(
            height: 120,
            decoration: BoxDecoration(
              color: WabTheme.backgroundColor,
              border: Border.all(color: WabTheme.lineColor),
            ),
            child: CustomPaint( // 非 const：WabInkWash 讀主題態
              painter: WabInkWash(),
              child: const SizedBox.expand(),
            ),
          )),
          _demo('WabRuleFrame — 單欄', WabRuleFrame(
            kind: WabRuleKind.single,
            fill: WabTheme.surfaceColor,
            texture: WabPaperTexture(), // 非 const：讀主題態
            child: const Padding(
              padding: EdgeInsets.all(14),
              child: Text('茶經封面式 — 一條單粗墨線，直邊方角，無 elevation。'),
            ),
          )),
          _demo('WabRuleFrame — 雙欄', WabRuleFrame(
            kind: WabRuleKind.double,
            fill: WabTheme.surfaceColor,
            texture: WabPaperTexture(), // 非 const：讀主題態
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('外粗內細', style: TextStyle(color: WabTheme.textColor)),
                  const SizedBox(height: 6),
                  Divider(
                    color: WabTheme.lineColor,
                    thickness: WAB_RULE_HAIRLINE,
                    height: WAB_RULE_HAIRLINE,
                  ),
                  const SizedBox(height: 6),
                  Text('框內文字分隔線要細',
                      style:
                          TextStyle(color: WabTheme.mutedColor, fontSize: 12)),
                ],
              ),
            ),
          )),
          WabBrushDivider(),
          const SizedBox(height: 28),
          _demo('WabContainer', WabContainer(child: const Text('WabContainer'))),
          _demo('WabLiteContainer',
              WabLiteContainer(child: const Text('WabLiteContainer'))),
          _demo('WabDivider', WabDivider()),
          _demo('WabElevatedButton', Column(children: [
            WabElevatedButton(
                text: const Text('WabElevatedButton'), callback: () {}),
            const SizedBox(height: 12),
            WabElevatedButton(
              text: const Text('with icon + chevron'),
              icon: const Icon(Icons.settings, size: 18),
              showChevron: true,
              callback: () {},
            ),
          ])),
          _demo('WabTextButton — 界行式·堆疊併線', Column(children: [
            WabTextButton(text: const Text('第一行 · 上下細線'), callback: () {}),
            WabTextButton(
                text: const Text('第二行 · mergeTop 併線'),
                callback: () {},
                mergeTop: true),
            WabTextButton(
                text: const Text('第三行 · mergeTop 併線'),
                callback: () {},
                mergeTop: true),
          ])),
          _demo('WabIconButton — 默認白文印章', Row(children: [
            WabIconButton(
                icon: const Icon(Icons.favorite),
                label: const Text('WabIconButton'),
                callback: () {}),
            const SizedBox(width: 16),
            WabIconButton(icon: const Icon(Icons.search), callback: () {}),
            const SizedBox(width: 16),
            WabIconButton(
                icon: const Icon(Icons.brush),
                kind: WabMaterialKind.zhuwen,
                callback: () {}),
          ])),
          _demo('WabToggleButton — 材質對', Column(children: [
            for (final (label, pair) in [
              ('紙紙', WabTogglePair.paper),
              ('木布', WabTogglePair.woodCloth),
              ('玉印', WabTogglePair.jadeBaiwen),
              ('硃砂朱文', WabTogglePair.sealZhuwen),
            ]) ...[
              Row(children: [
                SizedBox(
                    width: 72,
                    child: Text(label,
                        style: TextStyle(
                            color: WabTheme.mutedColor, fontSize: 12))),
                Expanded(
                  child: WabToggleButton(
                    text: const Text('ON'),
                    isOn: _toggle,
                    callback: () => setState(() => _toggle = true),
                    pair: pair,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: WabToggleButton(
                    text: const Text('OFF'),
                    isOn: !_toggle,
                    callback: () => setState(() => _toggle = false),
                    pair: pair,
                  ),
                ),
              ]),
              const SizedBox(height: 10),
            ],
          ])),
          _demo('WabSealMark — 印章', Row(children: [
            WabSealMark(text: 'FEY', size: 56), // 非 const：讀主題態
            const SizedBox(width: 16),
            WabSealMark(
                text: '印', kind: WabSealMarkKind.zhuwen, size: 56, seed: 9),
            const SizedBox(width: 16),
            WabSealMark(text: '茶經', size: 56, seed: 13),
          ])),
          _demo('WabButton — 五材質', Wrap(
            spacing: 14,
            runSpacing: 14,
            children: [
              WabButton(
                  kind: WabMaterialKind.paper,
                  onPressed: () {},
                  child: const Text('紙 · 曲邊')),
              WabButton(
                  kind: WabMaterialKind.wood,
                  onPressed: () {},
                  child: const Text('木 · 圓角紋理')),
              WabButton(
                  kind: WabMaterialKind.cloth,
                  onPressed: () {},
                  child: const Text('布 · 蓼藍織紋')),
              WabButton(
                  kind: WabMaterialKind.seal,
                  onPressed: () {},
                  child: const Text('朱砂 · 印')),
              WabButton(
                  kind: WabMaterialKind.jade,
                  onPressed: () {},
                  child: const Text('玉石 · 圓角')),
              WabButton(
                  kind: WabMaterialKind.baiwen,
                  onPressed: () {},
                  child: const Text('白文 · 拓印')),
              WabButton(
                  kind: WabMaterialKind.zhuwen,
                  onPressed: () {},
                  child: const Text('朱文 · 拓印')),
            ],
          )),
          _demo('WabStatusBadge', Wrap(spacing: 12, children: const [
            WabStatusBadge('progress', kind: WabBadgeKind.progress),
            WabStatusBadge('done', kind: WabBadgeKind.done),
            WabStatusBadge('neutral', kind: WabBadgeKind.neutral),
          ])),
          _demo('WabStarRating', Row(children: const [
            WabStarRating(rating: 3),
            SizedBox(width: 24),
            WabStarRating(rating: 5),
          ])),
          _demo('WabCollectionCard', Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: WabCollectionCard(
                  icon: Icon(Icons.emoji_food_beverage,
                      size: 40, color: WabTheme.textColor),
                  title: 'WabCollectionCard',
                  description: 'A collection card with an action.',
                  buttonLabel: 'action',
                  onPressed: () {},
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: WabCollectionCard(
                  icon: Icon(Icons.local_cafe,
                      size: 40, color: WabTheme.textColor),
                  title: 'highlighted',
                  description: 'Same card, filled action button.',
                  buttonLabel: 'action',
                  highlighted: true,
                  onPressed: () {},
                ),
              ),
            ],
          )),
          _demo('WabTextFormField',
              WabTextFormField(hintText: 'WabTextFormField')),
          _demo('WabNumberFormField',
              WabNumberFormField(value: 0, labelText: 'WabNumberFormField')),
          _demo('InkDot', Row(children: [
            for (final (label, style) in [
              ('flat', InkDotStyle(color: WabTheme.secondaryColor)),
              (
                'ringed',
                InkDotStyle(
                  color: WabTheme.textColor,
                  borderColor: WabTheme.accentColor,
                  borderWidth: 2,
                )
              ),
              ('accent', InkDotStyle(color: WabTheme.progressColor)),
            ]) ...[
              InkDot(style: style, size: 14),
              const SizedBox(width: 6),
              Text(label, style: TextStyle(color: WabTheme.mutedColor, fontSize: 12)),
              const SizedBox(width: 20),
            ],
          ])),
          _demo(
            'DotGrid',
            DotGrid<int>(
              rows: 5,
              cols: 26,
              states: List.generate(
                  130, (i) => i < 58 ? 0 : (i == 58 ? 1 : (i % 19 == 0 ? 2 : 3))),
              styleOf: (s) => switch (s) {
                0 => InkDotStyle(color: WabTheme.secondaryColor),
                1 => InkDotStyle(
                    color: WabTheme.textColor,
                    borderColor: WabTheme.accentColor,
                    borderWidth: 2,
                  ),
                2 => InkDotStyle(color: WabTheme.progressColor),
                _ => InkDotStyle(color: WabTheme.offColor.withOpacity(0.45)),
              },
              dotSize: 11,
              gap: 4,
            ),
          ),
        ],
      );

  /// 厚 · 木作圓角 — wood-grain panel (soft two-layer shadow) with two buttons.
  Widget _woodPanel() {
    final fg = WabTheme.isDark ? WabTheme.textColor : WAB_WOOD_DEEP_DARK;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(WAB_SECTION_BORDER_RADIUS),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(WabTheme.isDark
                ? WAB_WOOD_SHADOW_OPACITY_DARK1
                : WAB_WOOD_SHADOW_OPACITY_LIGHT1),
            blurRadius: 14,
            offset: const Offset(2, 5),
          ),
          BoxShadow(
            color: Colors.black.withOpacity(WabTheme.isDark
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
          painter: WabWoodGrain(isDark: WabTheme.isDark),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '厚 · 木作圓角',
                  style: TextStyle(
                    color: fg,
                    fontSize: 18,
                    letterSpacing: 4,
                    fontWeight: FontWeight.w600,
                    fontFamilyFallback: kWabDisplayFallback,
                  ),
                ),
                const SizedBox(height: 12),
                Row(children: [
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: WabTheme.sealColor,
                      foregroundColor: WabTheme.paperWhite,
                    ),
                    child: const Text('木 牌'),
                  ),
                  const SizedBox(width: 12),
                  TextButton(
                    onPressed: () {},
                    child: Text('素 面', style: TextStyle(color: fg)),
                  ),
                ]),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _demo(String name, Widget child) => Padding(
        padding: const EdgeInsets.only(bottom: 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: TextStyle(
                color: WabTheme.mutedColor,
                fontSize: 13,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 8),
            child,
          ],
        ),
      );
}
