import 'package:flutter/material.dart';
import '../theme/wab_theme.dart';

/// Top banner / masthead: a centered serif title with optional subtitle and
/// seal, plus leading and trailing slots (e.g. search field, settings icon).
///
/// Layout is fully relative (no fixed widths) so it adapts across platforms.
/// The trailing region is bounded, so a trailing `Expanded`/`Flexible` (e.g. a
/// search field) fills the available space on the trailing side.
class WabBanner extends StatelessWidget {
  const WabBanner({
    super.key,
    required this.title,
    this.subtitle,
    this.seal,
    this.leading,
    this.trailing = const [],
    this.height = 88,
  });

  final String title;
  final String? subtitle;

  /// Optional emblem rendered just after the title (e.g. a seal stamp).
  final Widget? seal;
  final Widget? leading;
  final List<Widget> trailing;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      color: WabTheme.backgroundColor,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          // Leading region
          Expanded(
            flex: 3,
            child: Align(
              alignment: Alignment.centerLeft,
              child: leading ?? const SizedBox.shrink(),
            ),
          ),
          // Centered title + subtitle
          Expanded(
            flex: 4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Text(
                        title,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: WabTheme.textColor,
                          fontSize: 28,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 2,
                          fontFamilyFallback: kWabSerifFallback,
                        ),
                      ),
                    ),
                    if (seal != null) ...[const SizedBox(width: 10), seal!],
                  ],
                ),
                if (subtitle != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: Text(
                      subtitle!,
                      style: TextStyle(
                        color: WabTheme.accentColor,
                        fontSize: 13,
                        letterSpacing: 4,
                        fontFamilyFallback: kWabSerifFallback,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          // Trailing region (bounded → trailing Expanded/Flexible works)
          Expanded(
            flex: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: trailing,
            ),
          ),
        ],
      ),
    );
  }
}
