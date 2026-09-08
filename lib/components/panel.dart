import 'package:flutter/material.dart';
import '../theme/wab_theme.dart';
import '../materials/paper_texture.dart';
import '../materials/rule_frame.dart';
import '../tokens/material.dart';

/// A titled section panel — the primary content surface of a dashboard.
/// Header row (serif title + optional trailing actions) over a body.
class WabPanel extends StatelessWidget {
  const WabPanel({
    super.key,
    required this.title,
    required this.child,
    this.trailing,
    this.padding = const EdgeInsets.all(16),
    this.expand = false,
  });

  final String title;
  final Widget child;

  /// Optional widgets rendered at the trailing edge of the header (e.g. filter chips).
  final Widget? trailing;
  final EdgeInsets padding;

  /// When true the body expands to fill available vertical space (grid use).
  final bool expand;

  @override
  Widget build(BuildContext context) {
    final body = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: expand ? MainAxisSize.max : MainAxisSize.min,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: WabTheme.textColor,
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                  fontFamilyFallback: kWabKaiFallback,
                ),
              ),
            ),
            if (trailing != null) trailing!,
          ],
        ),
        const SizedBox(height: 8),
        // 框內文字分隔線要細 — 淡墨 hairline under the header.
        Divider(
          color: WabTheme.lineColor,
          thickness: WAB_RULE_HAIRLINE,
          height: WAB_RULE_HAIRLINE,
        ),
        const SizedBox(height: 12),
        expand ? Expanded(child: child) : child,
      ],
    );

    // Wash state (no elevation): 茶經封面式單粗墨線框, 直邊方角,
    // paper texture inside, no shadow.
    return WabRuleFrame(
      kind: WabRuleKind.single,
      fill: WabTheme.surfaceColor,
      texture: WabPaperTexture(),
      child: Padding(padding: padding, child: body),
    );
  }
}
