import 'package:flutter/material.dart';
import '../theme/wab_theme.dart';
import '../tokens/spacing.dart';

/// Semantic kinds for a [WabStatusBadge].
enum WabBadgeKind { progress, done, neutral }

/// A small pill badge for statuses like "進行中" (progress) or "完成" (done).
class WabStatusBadge extends StatelessWidget {
  const WabStatusBadge(this.label, {super.key, this.kind = WabBadgeKind.neutral});

  final String label;
  final WabBadgeKind kind;

  Color get _bg {
    switch (kind) {
      case WabBadgeKind.progress:
        return WabTheme.progressColor;
      case WabBadgeKind.done:
        return WabTheme.onColor;
      case WabBadgeKind.neutral:
        return WabTheme.woodyColor;
    }
  }

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
          // Neutral sits on light wood, so use the readable text color there.
          color: kind == WabBadgeKind.neutral ? WabTheme.textColor : Colors.white,
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
