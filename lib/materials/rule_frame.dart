import 'package:flutter/material.dart';

import '../theme/wab_theme.dart';
import '../tokens/material.dart';

/// 邊欄 level — 單欄 single（茶經封面式：一條單粗墨線）or
/// 雙欄 double（古籍版式：外粗內細，兩線之間留隙）.
enum WabRuleKind { single, double }

/// 邊欄 rule frame — the flat, no-elevation frame of the kit, modelled on
/// 古籍版式邊欄. Straight edges, square corners, ink rules stroked over an
/// optional fill + texture (e.g. `WabPaperTexture`). No shadow — the wash
/// state of a surface.
///
/// [WabRuleKind.single] is one thick ink rule (茶經封面式單粗);
/// [WabRuleKind.double] is 外粗內細 — a thick outer rule with a thin inner
/// rule inside it. Thin lines live only inside the frame, as text
/// separators ([WAB_RULE_HAIRLINE]) — never as the outer frame itself.
class WabRuleFrame extends StatelessWidget {
  // Non-const by design: reads WabTheme (textColor / isDark) at build.
  WabRuleFrame({
    super.key,
    required this.child,
    this.kind = WabRuleKind.single,
    this.fill,
    this.texture,
    this.ruleColor,
    this.isDark,
  });

  /// Content; determines the frame size. Inset past the rules automatically.
  final Widget child;

  /// 單欄 or 雙欄.
  final WabRuleKind kind;

  /// Flat fill under the texture; null for transparent.
  final Color? fill;

  /// Texture layer painted over [fill] and under [child].
  final Widget? texture;

  /// Rule ink color; defaults to `WabTheme.textColor` at the token opacity.
  final Color? ruleColor;

  /// Theme override; defaults to the current `WabTheme.isDark`.
  final bool? isDark;

  /// Total rule inset on one side — how far content must clear the rules.
  static double ruleInset(WabRuleKind kind) => kind == WabRuleKind.double
      ? WAB_RULE_OUTER_WIDTH + WAB_RULE_GAP + WAB_RULE_INNER_WIDTH + 2
      : WAB_RULE_SINGLE_WIDTH + 2;

  @override
  Widget build(BuildContext context) {
    final dark = isDark ?? WabTheme.isDark;
    final ink = (ruleColor ?? WabTheme.textColor).withOpacity(
        dark ? WAB_RULE_OPACITY_DARK : WAB_RULE_OPACITY_LIGHT);
    return Stack(
      children: [
        if (fill != null) Positioned.fill(child: ColoredBox(color: fill!)),
        if (texture != null)
          Positioned.fill(child: IgnorePointer(child: texture!)),
        Positioned.fill(
          child: IgnorePointer(
            child: CustomPaint(painter: _RuleFramePainter(kind, ink)),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(ruleInset(kind)),
          child: child,
        ),
      ],
    );
  }
}

class _RuleFramePainter extends CustomPainter {
  const _RuleFramePainter(this.kind, this.ink);

  final WabRuleKind kind;
  final Color ink;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    if (kind == WabRuleKind.single) {
      canvas.drawRect(
        rect.deflate(WAB_RULE_SINGLE_WIDTH / 2),
        Paint()
          ..color = ink
          ..style = PaintingStyle.stroke
          ..strokeWidth = WAB_RULE_SINGLE_WIDTH,
      );
      return;
    }
    // 雙欄 — 外粗內細.
    canvas.drawRect(
      rect.deflate(WAB_RULE_OUTER_WIDTH / 2),
      Paint()
        ..color = ink
        ..style = PaintingStyle.stroke
        ..strokeWidth = WAB_RULE_OUTER_WIDTH,
    );
    canvas.drawRect(
      rect.deflate(WAB_RULE_OUTER_WIDTH + WAB_RULE_GAP + WAB_RULE_INNER_WIDTH / 2),
      Paint()
        ..color = ink
        ..style = PaintingStyle.stroke
        ..strokeWidth = WAB_RULE_INNER_WIDTH,
    );
  }

  @override
  bool shouldRepaint(_RuleFramePainter old) =>
      old.kind != kind || old.ink != ink;
}
