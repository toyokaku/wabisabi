import 'package:flutter/material.dart';
import '../theme/wab_theme.dart';
import '../tokens/spacing.dart';

/// Left navigation rail container. Holds a profile header, nav items and
/// any extra panels (e.g. a feedback form). Width-constrained vertical stack.
class WabSidebar extends StatelessWidget {
  const WabSidebar({
    super.key,
    required this.children,
    this.width = 220,
    this.padding = const EdgeInsets.all(20),
  });

  final List<Widget> children;
  final double width;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: padding,
      color: WabTheme.backgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }
}

/// Profile block: framed avatar + name + subtitle.
class WabProfileHeader extends StatelessWidget {
  const WabProfileHeader({
    super.key,
    required this.name,
    this.subtitle,
    this.avatar,
  });

  final String name;
  final String? subtitle;

  /// Optional avatar image; falls back to a framed person glyph.
  final ImageProvider? avatar;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: WabTheme.primaryColor,
            borderRadius: BorderRadius.circular(WAB_CARD_BORDER_RADIUS),
            border: Border.all(color: WabTheme.accentColor.withOpacity(0.6)),
            image: avatar == null
                ? null
                : DecorationImage(image: avatar!, fit: BoxFit.cover),
          ),
          child: avatar == null
              ? Icon(Icons.person, color: WabTheme.accentColor, size: 26)
              : null,
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              name,
              style: TextStyle(
                color: WabTheme.accentColor,
                fontSize: 16,
                fontWeight: FontWeight.w600,
                fontFamilyFallback: kWabSerifFallback,
              ),
            ),
            if (subtitle != null)
              Text(
                subtitle!,
                style: TextStyle(
                  color: WabTheme.textColor.withOpacity(0.6),
                  fontSize: 12,
                  fontFamilyFallback: kWabSerifFallback,
                ),
              ),
          ],
        ),
      ],
    );
  }
}

/// A single navigation entry. Selected state shows a rounded outline pill
/// with accent text; unselected is plain text.
class WabNavItem extends StatelessWidget {
  const WabNavItem({
    super.key,
    required this.label,
    this.selected = false,
    this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(24),
          onTap: onTap,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: selected ? WabTheme.accentColor : Colors.transparent,
                width: 1,
              ),
            ),
            child: Text(
              label,
              style: TextStyle(
                color: selected ? WabTheme.accentColor : WabTheme.textColor,
                fontSize: 16,
                fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                fontFamilyFallback: kWabSerifFallback,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
