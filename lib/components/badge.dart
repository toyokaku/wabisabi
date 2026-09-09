import 'package:flutter/material.dart';

import '../theme/wab_theme.dart';
import '../tokens/spacing.dart';

enum WabBadgeKind {
  neutral,
  primary,
  success,
  warning,
  error,
  progress,
  done,
}

/// Small semantic pill used for status labels on the material board.
class WabStatusBadge extends StatelessWidget {
  const WabStatusBadge(
    this.label, {
    super.key,
    this.kind = WabBadgeKind.neutral,
  });

  final String label;
  final WabBadgeKind kind;

  Color get _bg => switch (kind) {
        WabBadgeKind.neutral => WabTheme.secondaryColor.withOpacity(.72),
        WabBadgeKind.primary || WabBadgeKind.progress => WabTheme.progressColor,
        WabBadgeKind.success || WabBadgeKind.done => WabTheme.onColor,
        WabBadgeKind.warning => WabTheme.accentColor.withOpacity(.82),
        WabBadgeKind.error => WabTheme.sealColor,
      };

  bool get _darkText =>
      kind == WabBadgeKind.neutral || kind == WabBadgeKind.warning;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
        decoration: BoxDecoration(
          color: _bg,
          borderRadius: BorderRadius.circular(999),
          border: kind == WabBadgeKind.neutral
              ? Border.all(color: WabTheme.lineColor, width: WAB_RULE_HAIRLINE)
              : null,
        ),
        child: Text(
          label,
          style: TextStyle(
            color: _darkText ? WabTheme.textColor : WabTheme.paperWhite,
            fontSize: 11,
            fontWeight: FontWeight.w600,
            height: 1,
            fontFamilyFallback: kWabKaiFallback,
          ),
        ),
      );
}

class WabStarRating extends StatelessWidget {
  const WabStarRating({
    super.key,
    required this.rating,
    this.max = 5,
    this.size = 16,
  });

  final int rating;
  final int max;
  final double size;

  @override
  Widget build(BuildContext context) => Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(max, (i) {
          final filled = i < rating;
          return Icon(
            filled ? Icons.star : Icons.star_border,
            size: size,
            color: filled ? WabTheme.accentColor : WabTheme.secondaryColor,
          );
        }),
      );
}
