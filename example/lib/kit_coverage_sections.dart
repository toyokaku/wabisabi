import 'package:flutter/material.dart';
import 'package:wabisabi/wabisabi.dart';

// Specimens for the parts of the kit the golden1 board never drew.
// Composition only: every visible primitive comes from package:wabisabi.
//
// tool/check_public_api.dart fails when a type is exported from the barrel and
// never appears here, so this file is where a new export earns its place.

TextStyle _caption(WabColors wab) => TextStyle(
      color: wab.mutedColor,
      fontFamily: kWabMonoFamily,
      fontSize: 6.2,
      height: 1.2,
    );

Widget _specimen(
  WabColors wab,
  String label,
  double width,
  double height,
  Widget child,
) =>
    SizedBox(
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(width: width, height: height, child: child),
          const SizedBox(height: 3),
          Text(label, style: _caption(wab)),
        ],
      ),
    );

/// 骨架 — page chrome: scaffolds, bars, legacy containers, nav furniture.
Widget kitChromeSection(BuildContext context) {
  final wab = WabTheme.of(context);
  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 9,
          runSpacing: 8,
          children: [
            _specimen(
              wab,
              'WabScaffold',
              150,
              76,
              WabScaffold(
                title: const Text('卷 一', style: TextStyle(fontSize: 11)),
                body: Center(
                  child: Text('body', style: _caption(wab)),
                ),
              ),
            ),
            _specimen(
              wab,
              'WabTexturedScaffold',
              150,
              76,
              WabTexturedScaffold(
                title: const Text('卷 二', style: TextStyle(fontSize: 11)),
                body: Center(
                  child: Text('ambient ground', style: _caption(wab)),
                ),
              ),
            ),
            _specimen(
              wab,
              'WabAppBar',
              150,
              52,
              WabAppBar(
                title: const Text('題 名', style: TextStyle(fontSize: 11)),
                action: const Icon(Icons.more_horiz, size: 15),
              ),
            ),
            _specimen(
              wab,
              'TexturePainter\n(scaffold ground)',
              100,
              52,
              CustomPaint(
                painter: TexturePainter(isDark: wab.isDark),
                child: const SizedBox.expand(),
              ),
            ),
            _specimen(
              wab,
              'WabContainer',
              128,
              46,
              WabContainer(child: Text('框 · framed', style: _caption(wab))),
            ),
            _specimen(
              wab,
              'WabLiteContainer',
              128,
              46,
              WabLiteContainer(child: Text('輕框 · lite', style: _caption(wab))),
            ),
            _specimen(
              wab,
              'WabProfileHeader',
              168,
              50,
              WabProfileHeader(
                name: '陸 羽',
                subtitle: '茶經 · 卷上',
                avatar: const AssetImage('images/avatar.jpg'),
              ),
            ),
            _specimen(
              wab,
              'WabNavItem (legacy)',
              128,
              106,
              Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  WabNavItem(label: '選 中', selected: true),
                  WabNavItem(label: '未 選'),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 9),
        Text('WabColors · WabTheme.of(context)', style: _caption(wab)),
        const SizedBox(height: 4),
        Wrap(
          spacing: 6,
          runSpacing: 4,
          children: [
            for (final swatch in <(String, Color)>[
              ('background', wab.backgroundColor),
              ('surface', wab.surfaceColor),
              ('primary', wab.primaryColor),
              ('accent', wab.accentColor),
              ('text', wab.textColor),
              ('muted', wab.mutedColor),
              ('line', wab.lineColor),
              ('seal', wab.sealColor),
              ('scratch', wab.scratchColor),
              ('woody', wab.woodyColor),
              ('progress', wab.progressColor),
              ('on', wab.onColor),
            ])
              SizedBox(
                width: 52,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 14,
                      decoration: BoxDecoration(
                        color: swatch.$2,
                        border: Border.all(color: wab.lineColor),
                      ),
                    ),
                    Text(swatch.$1, style: _caption(wab)),
                  ],
                ),
              ),
          ],
        ),
        const SizedBox(height: 9),
        SizedBox(
          height: 66,
          child: WabBanner(
            title: '侘 寂',
            subtitle: 'WABBANNER · MASTHEAD',
            height: 66,
            leading: WabSealMark(text: '侘', size: 22, seed: 31),
            trailing: [
              WabStatusBadge('WabBanner', kind: WabBadgeKind.neutral),
            ],
          ),
        ),
      ],
    ),
  );
}

/// 紋理 — the painters underneath WabSurface, shown on their own.
Widget kitTexturePrimitivesSection(BuildContext context) {
  const w = 78.0;
  const h = 42.0;
  final wab = WabTheme.of(context);
  final dark = wab.isDark;

  return SingleChildScrollView(
    child: Wrap(
      spacing: 8,
      runSpacing: 7,
      children: [
        _specimen(wab, 'WabPaperTexture', w, h,
            ColoredBox(
              color: dark
                  ? WAB_TEXTURE_PAPER_BASE_DARK
                  : WAB_TEXTURE_PAPER_BASE_LIGHT,
              child: WabPaperTexture(child: const SizedBox.expand()),
            )),
        _specimen(wab, '…Kind.mottle', w, h,
            ColoredBox(
              color: dark
                  ? WAB_TEXTURE_PAPER_BASE_DARK
                  : WAB_TEXTURE_PAPER_BASE_LIGHT,
              child: WabPaperTexture(
                kind: WabPaperTextureKind.mottle,
                child: const SizedBox.expand(),
              ),
            )),
        _specimen(wab, 'WabFiberTexture', w, h,
            ColoredBox(
              color: dark
                  ? WAB_TEXTURE_PAPER_BASE_DARK
                  : WAB_TEXTURE_PAPER_BASE_LIGHT,
              child: WabFiberTexture(strength: 1, child: const SizedBox.expand()),
            )),
        _specimen(wab, 'WabWoodGrain', w, h,
            CustomPaint(
              painter: WabWoodGrain(isDark: dark),
              child: const SizedBox.expand(),
            )),
        _specimen(wab, 'WabClothTexture', w, h,
            WabClothTexture(child: const SizedBox.expand())),
        _specimen(wab, 'WabClothWeave', w, h,
            CustomPaint(
              painter: WabClothWeave(isDark: dark),
              child: const SizedBox.expand(),
            )),
        _specimen(wab, 'WabJadeTexture', w, h,
            WabJadeTexture(child: const SizedBox.expand())),
        _specimen(wab, 'WabCinnabarTexture', w, h,
            WabCinnabarTexture(child: const SizedBox.expand())),
        _specimen(wab, 'WabPatinaTexture', w, h,
            WabPatinaTexture(child: const SizedBox.expand())),
        _specimen(wab, 'WabRubbingTexture', w, h,
            const WabRubbingTexture(child: SizedBox.expand())),
        _specimen(wab, 'WabInkWash', w, h,
            ColoredBox(
              color: dark
                  ? WAB_TEXTURE_PAPER_BASE_DARK
                  : WAB_TEXTURE_PAPER_BASE_LIGHT,
              child: CustomPaint(
                painter: WabInkWash(),
                child: const SizedBox.expand(),
              ),
            )),
        _specimen(wab, 'WabDeckleSurface', w, h,
            WabDeckleSurface(
              fill: dark
                  ? WAB_TEXTURE_PAPER_BASE_DARK
                  : WAB_TEXTURE_PAPER_BASE_LIGHT,
              texture: WabPaperTexture(),
              child: const SizedBox.expand(),
            )),
        _specimen(wab, 'DeckleBorder', w, h,
            DecoratedBox(
              decoration: ShapeDecoration(
                color: dark
                    ? WAB_TEXTURE_PAPER_BASE_DARK
                    : WAB_TEXTURE_PAPER_BASE_LIGHT,
                shape: DeckleBorder(seed: 61, radius: 2),
              ),
              child: const SizedBox.expand(),
            )),
      ],
    ),
  );
}

/// 零件 — the remaining exported odds and ends, including the two that carry
/// their own state.
class KitOddsAndEndsSection extends StatefulWidget {
  const KitOddsAndEndsSection({super.key});

  @override
  State<KitOddsAndEndsSection> createState() => _KitOddsAndEndsSectionState();
}

class _KitOddsAndEndsSectionState extends State<KitOddsAndEndsSection> {
  String _tea = 'sencha';
  int _count = 3;

  @override
  Widget build(BuildContext context) {
    final wab = WabTheme.of(context);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 10,
            runSpacing: 8,
            crossAxisAlignment: WrapCrossAlignment.start,
            children: [
              _specimen(
                wab,
                'WabElevatedButton',
                132,
                34,
                WabElevatedButton(
                  text: const Text('取 茶'),
                  icon: const Icon(Icons.local_cafe_outlined, size: 14),
                  showChevron: true,
                  callback: () {},
                ),
              ),
              _specimen(
                wab,
                'WabFloatingActionButton',
                60,
                60,
                WabFloatingActionButton(
                  FloatingActionButton(
                    onPressed: () {},
                    child: const Icon(Icons.add, size: 20),
                  ),
                ),
              ),
              _specimen(
                wab,
                'WabDropdown',
                132,
                46,
                WabDropdown<String>(
                  value: _tea,
                  items: const {
                    'sencha': '煎 茶',
                    'matcha': '抹 茶',
                    'houjicha': '焙 茶',
                  },
                  onChanged: (v) => setState(() => _tea = v ?? _tea),
                ),
              ),
              _specimen(
                wab,
                'WabNumberFormField',
                110,
                46,
                WabNumberFormField(
                  value: _count,
                  labelText: '盞',
                  callback: (v) =>
                      setState(() => _count = int.tryParse(v) ?? _count),
                ),
              ),
              _specimen(
                wab,
                'WabImage',
                58,
                46,
                WabImage(path: 'images/avatar.jpg', width: 58, height: 46),
              ),
              _specimen(
                wab,
                'WabIcon',
                58,
                46,
                FittedBox(
                  fit: BoxFit.contain,
                  child: WabIcon(path: 'images/googlepay.png'),
                ),
              ),
              _specimen(
                wab,
                'WabWarningText',
                110,
                24,
                Align(
                  alignment: Alignment.centerLeft,
                  child: WabWarningText(text: '水 未 沸'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text('WabPaymentRow', style: _caption(wab)),
          const SizedBox(height: 3),
          WabPaymentRow(
            image: WabImage(path: 'images/googlepay.png', width: 34, height: 18),
            text: Text('結 帳 · CHECKOUT', style: _caption(wab)),
            callback: () {},
          ),
          const SizedBox(height: 6),
          Text('WabDivider', style: _caption(wab)),
          WabDivider(),
        ],
      ),
    );
  }
}
