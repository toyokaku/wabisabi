import 'package:flutter/material.dart';
import '../theme/wab_theme.dart';
import '../tokens/spacing.dart';

/// Left navigation rail container. The rail is transparent by default so a
/// WabPaperSheet / other material ground remains visible through it.
class WabSidebar extends StatelessWidget {
  const WabSidebar({
    super.key,
    required this.children,
    this.width,
    this.padding = const EdgeInsets.all(20),
    this.backgroundColor,
  });

  final List<Widget> children;
  final double? width;
  final EdgeInsets padding;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    Widget rail = Container(
      width: width,
      padding: padding,
      color: backgroundColor ?? Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: children,
      ),
    );
    return width == null ? IntrinsicWidth(child: rail) : rail;
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
  final ImageProvider? avatar;

  @override
  Widget build(BuildContext context) {
    final wab = WabTheme.of(context);
    return Row(
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: wab.primaryColor,
            borderRadius: BorderRadius.circular(WAB_CARD_BORDER_RADIUS),
            border: Border.all(color: wab.accentColor.withOpacity(0.6)),
            image: avatar == null
                ? null
                : DecorationImage(image: avatar!, fit: BoxFit.cover),
          ),
          child: avatar == null
              ? Icon(Icons.person, color: wab.accentColor, size: 26)
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
                color: wab.textColor,
                fontSize: 16,
                fontWeight: FontWeight.w700,
                fontFamilyFallback: kWabKaiFallback,
              ),
            ),
            if (subtitle != null)
              Text(
                subtitle!,
                style: TextStyle(
                  color: wab.textColor.withOpacity(0.6),
                  fontSize: 12,
                  fontFamilyFallback: kWabKaiFallback,
                ),
              ),
          ],
        ),
      ],
    );
  }
}

/// Legacy outlined nav item. The catalogue itself uses WabTextButton for the
/// ruled-text navigation language.
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
    final wab = WabTheme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(WAB_CARD_BORDER_RADIUS),
              border: Border.all(
                color: selected ? wab.accentColor : Colors.transparent,
                width: 1,
              ),
            ),
            child: Text(
              label,
              style: TextStyle(
                color: wab.textColor,
                fontSize: 16,
                fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                fontFamilyFallback: kWabKaiFallback,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
