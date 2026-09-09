import 'package:flutter/material.dart';
import '../theme/wab_theme.dart';
import '../tokens/spacing.dart';

/// Semantic kinds for a [WabStatusBadge].
///
/// [progress] and [done] remain as compatibility aliases for older consumers;
/// the golden board names the same semantic colors primary/success.
enum WabBadgeKind {
  neutral,
  primary,
  success,
  warning,
  error,
  progress,
  done,
}

/// A small status badge. Color comes from operational theme roles rather than
/// from literal palette values.
class WabStatusBadge extends StatelessWidget {
  const WabStatusBadge(this.label, {super.key, this.kind = WabBadgeKind.neutral});

  final String label;
  final WabBadgeKind kind;

  Color get _bg => switch (kind) {
        WabBadgeKind.neutral => WabTheme.secondaryColor,
        WabBadgeKind.primary || WabBadgeKind.progress => WabTheme.progressColor,
        WabBadgeKind.success || WabBadgeKind.done => WabTheme.onColor,
        WabBadgeKind.warning => WabTheme.accentColor,
        WabBadgeKind.error => WabTheme.sealColor,
      };

  bool get _darkText =>
      kind == WabBadgeKind.neutral || kind == WabBadgeKind.warning;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: _bg,
        borderRadius: BorderRadius.circular(WAB_BADGE_RADIUS),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: _darkText ? WabTheme.textColor : WabTheme.paperWhite,
          fontSize: 13,
          fontWeight: FontWeight.w600,
          fontFamilyFallback: kWabKaiFallback,
        ),
      ),
    );
  }
}

/// A 5-star rating row; filled stars use the theme accent (gold).
class WabStarRating extends StatelessWidget {
  const WabStarRating({super.key, required this.rating, this.max = 5, this.size = 16});

  final int rating;
  final int max;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Row(
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
}
