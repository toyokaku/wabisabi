import 'package:flutter/material.dart';
import 'package:wabisabi/wabisabi.dart';

/// Composition only: all visible primitives are public wabisabi APIs.
Widget refinedRulesSection() {
  Widget specimen(WabRuleKind kind, String label) => Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 52,
              child: WabRuleFrame(
                kind: kind,
                fill: WabTheme.scratchColor,
                child: const SizedBox.expand(),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: WabTheme.mutedColor,
                fontFamily: kWabMonoFamily,
                fontSize: 5.7,
              ),
            ),
          ],
        ),
      );

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          specimen(WabRuleKind.thin, '細欄 · THIN'),
          const SizedBox(width: 9),
          specimen(WabRuleKind.single, '單欄 · SINGLE'),
          const SizedBox(width: 9),
          specimen(WabRuleKind.double, '雙欄 · DOUBLE'),
        ],
      ),
      const SizedBox(height: 10),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 7, child: WabPaperFold(height: 7)),
                const SizedBox(height: 4),
                Text(
                  '紙摺分隔 · PAPER FOLD',
                  style: TextStyle(
                    color: WabTheme.mutedColor,
                    fontFamily: kWabMonoFamily,
                    fontSize: 5.8,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 42,
                  child: WabFoldFrame(
                    fill: WabTheme.backgroundColor,
                    padding: const EdgeInsets.all(7),
                    child: Center(
                      child: Text(
                        '四 摺 紙 格',
                        style: TextStyle(
                          color: WabTheme.mutedColor,
                          fontSize: 7,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  '四摺紙格 · FOLD FRAME',
                  style: TextStyle(
                    color: WabTheme.mutedColor,
                    fontFamily: kWabMonoFamily,
                    fontSize: 5.8,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      const SizedBox(height: 8),
      WabBrushDivider(),
      const SizedBox(height: 3),
      Row(
        children: [
          Text(
            '筆觸分隔 · BRUSH',
            style: TextStyle(
              color: WabTheme.mutedColor,
              fontFamily: kWabMonoFamily,
              fontSize: 5.8,
            ),
          ),
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

Widget refinedButtonsSection() {
  final items = <(String, String, WabMaterialKind)>[
    ('次 之', '紙 · PAPER', WabMaterialKind.paper),
    ('木 牌', '木 · WOOD', WabMaterialKind.wood),
    ('布 札', '布 · CLOTH', WabMaterialKind.cloth),
    ('玉 扣', '玉 · JADE', WabMaterialKind.jade),
    ('白 文', '白文 · BAIWEN', WabMaterialKind.baiwen),
    ('朱 文', '朱文 · ZHUWEN', WabMaterialKind.zhuwen),
  ];

  return Wrap(
    spacing: 8,
    runSpacing: 8,
    children: [
      for (final item in items)
        SizedBox(
          width: 88,
          child: Column(
            children: [
              WabButton(
                kind: item.$3,
                onPressed: () {},
                expand: true,
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 6),
                child: item.$3 == WabMaterialKind.baiwen ||
                        item.$3 == WabMaterialKind.zhuwen
                    ? WabSealText(item.$1, fontSize: 20, strokeWidth: .7)
                    : Text(item.$1),
              ),
              const SizedBox(height: 3),
              Text(
                item.$2,
                style: TextStyle(
                  color: WabTheme.mutedColor,
                  fontFamily: kWabMonoFamily,
                  fontSize: 5.8,
                ),
              ),
            ],
          ),
        ),
      SizedBox(
        width: 88,
        child: Column(
          children: [
            WabSealButton(
              label: '落 印',
              onPressed: () {},
              expand: true,
              fontSize: 20,
            ),
            const SizedBox(height: 3),
            Text(
              '印章 · SEAL',
              style: TextStyle(
                color: WabTheme.mutedColor,
                fontFamily: kWabMonoFamily,
                fontSize: 5.8,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
