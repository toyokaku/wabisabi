import 'package:flutter/material.dart';

import '../theme/wab_theme.dart';
import '../materials/surface.dart';
import '../tokens/material.dart';

/// Flat titled content surface. Panels intentionally use a hairline boundary;
/// the heavier single/double book rules remain separate material primitives.
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
  final Widget? trailing;
  final EdgeInsets padding;
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
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  letterSpacing: .5,
                  fontFamilyFallback: kWabKaiFallback,
                ),
              ),
            ),
            if (trailing != null) trailing!,
          ],
        ),
        const SizedBox(height: 7),
        Divider(
          color: WabTheme.lineColor,
          thickness: WAB_RULE_HAIRLINE,
          height: WAB_RULE_HAIRLINE,
        ),
        const SizedBox(height: 10),
        expand ? Expanded(child: child) : child,
      ],
    );

    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: WabTheme.lineColor,
          width: WAB_RULE_HAIRLINE,
        ),
      ),
      child: WabSurface(
        kind: WabSurfaceKind.paper,
        clip: false,
        child: Padding(padding: padding, child: body),
      ),
    );
  }
}
