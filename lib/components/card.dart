import 'package:flutter/material.dart';
import '../theme/wab_theme.dart';
import '../tokens/spacing.dart';

/// A vertical collection card: centered emblem, title, description and a
/// trailing action button. Used for grids like a tea-ware collection.
class WabCollectionCard extends StatelessWidget {
  const WabCollectionCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    this.buttonLabel,
    this.onPressed,
    this.highlighted = false,
  });

  /// The emblem widget (icon or image) shown at the top of the card.
  final Widget icon;
  final String title;
  final String description;
  final String? buttonLabel;
  final VoidCallback? onPressed;

  /// When true the action button is filled (accent), else outlined.
  final bool highlighted;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: WabTheme.primaryColor,
        borderRadius: BorderRadius.circular(WAB_CARD_BORDER_RADIUS),
        boxShadow: WabTheme.elevationShadow,
        border: Border.all(color: WabTheme.secondaryColor, width: 0.8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 56,
            child: Center(child: icon),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: WabTheme.textColor,
              fontSize: 15,
              fontWeight: FontWeight.w600,
              fontFamilyFallback: kWabFontFallback,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            description,
            textAlign: TextAlign.center,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: WabTheme.textColor.withOpacity(0.7),
              fontSize: 12,
              height: 1.4,
              fontFamilyFallback: kWabFontFallback,
            ),
          ),
          if (buttonLabel != null) ...[
            const SizedBox(height: 12),
            _CardButton(
              label: buttonLabel!,
              onPressed: onPressed,
              highlighted: highlighted,
            ),
          ],
        ],
      ),
    );
  }
}

class _CardButton extends StatelessWidget {
  const _CardButton({
    required this.label,
    required this.onPressed,
    required this.highlighted,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool highlighted;

  @override
  Widget build(BuildContext context) {
    final fg = WabTheme.textColor;
    return Material(
      color: highlighted ? WabTheme.woodyColor : Colors.transparent,
      borderRadius: BorderRadius.circular(WAB_BADGE_RADIUS),
      child: InkWell(
        borderRadius: BorderRadius.circular(WAB_BADGE_RADIUS),
        onTap: onPressed,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(WAB_BADGE_RADIUS),
            border: highlighted
                ? null
                : Border.all(color: WabTheme.secondaryColor),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: fg,
              fontSize: 13,
              fontFamilyFallback: kWabFontFallback,
            ),
          ),
        ),
      ),
    );
  }
}
