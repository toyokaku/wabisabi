import 'package:flutter/material.dart';
import '../theme/wab_theme.dart';

/// Top banner / masthead. The title+subtitle are anchored to the bottom-right
/// (small, weighted) so they don't dominate the centre; [leading] sits top-left
/// and [trailing] (e.g. a search field, actions) fills the top-right.
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
    this.height = 96,
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
    final wab = WabTheme.of(context);
    return Container(
      height: height,
      color: wab.backgroundColor,
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: Column(
        children: [
          // Top row: leading (left) + trailing region (right, bounded)
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                leading ?? const SizedBox.shrink(),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: trailing,
                  ),
                ),
              ],
            ),
          ),
          // Bottom-right title + subtitle
          Align(
            alignment: Alignment.bottomRight,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: wab.textColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.5,
                        fontFamilyFallback: kWabKaiFallback,
                      ),
                    ),
                    if (seal != null) ...[const SizedBox(width: 8), seal!],
                  ],
                ),
                if (subtitle != null)
                  Text(
                    subtitle!,
                    style: TextStyle(
                      color: wab.mutedColor,
                      fontSize: 11,
                      letterSpacing: 2,
                      fontFamilyFallback: kWabKaiFallback,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
