import 'package:flutter/material.dart';
import '../theme/wab_theme.dart';
import '../tokens/spacing.dart';

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
                  fontFamilyFallback: kWabFontFallback,
                ),
              ),
            ),
            if (trailing != null) trailing!,
          ],
        ),
        const SizedBox(height: 14),
        expand ? Expanded(child: child) : child,
      ],
    );

    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: WabTheme.surfaceColor,
        borderRadius: BorderRadius.circular(WAB_SECTION_BORDER_RADIUS),
        border: Border.all(
          color: WabTheme.isDark
              ? WabTheme.accentColor.withOpacity(0.20)
              : WabTheme.secondaryColor,
          width: 0.8,
        ),
        // Subtle raised top edge, like the mockup panels.
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            WabTheme.surfaceColor,
            WabTheme.isDark
                ? WabTheme.primaryColor
                : WabTheme.surfaceColor,
          ],
        ),
      ),
      child: body,
    );
  }
}
