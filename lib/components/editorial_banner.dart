import 'package:flutter/material.dart';

import '../theme/typography.dart';
import '../theme/wab_theme.dart';
import '../tokens/material.dart';

/// Editorial masthead matching the kit's document-source language: brand at
/// left, title/subtitle immediately after it, quiet motto/actions at right.
class WabEditorialBanner extends StatelessWidget {
  const WabEditorialBanner({
    super.key,
    required this.brand,
    required this.kitLabel,
    required this.title,
    required this.subtitle,
    this.motto,
    this.seal,
    this.trailing = const [],
    this.height = 92,
  });

  final String brand;
  final String kitLabel;
  final String title;
  final String subtitle;
  final String? motto;
  final Widget? seal;
  final List<Widget> trailing;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 13, 24, 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              brand,
              style: const TextStyle(
                fontFamily: kWabDisplayFamily,
                fontFamilyFallback: kWabDisplayFallback,
                fontSize: 31,
                fontWeight: FontWeight.w500,
                letterSpacing: 7,
                height: 1,
              ).copyWith(color: WabTheme.textColor),
            ),
            const SizedBox(width: 16),
            Container(width: WAB_RULE_HAIRLINE, height: 54, color: WabTheme.lineColor),
            const SizedBox(width: 14),
            SizedBox(
              width: 72,
              child: Text(
                kitLabel,
                style: const TextStyle(
                  fontFamily: kWabMonoFamily,
                  fontSize: 9,
                  letterSpacing: 2.6,
                  height: 1.45,
                ).copyWith(color: WabTheme.mutedColor),
              ),
            ),
            const SizedBox(width: 22),
            Flexible(
              flex: 3,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Text(
                          title,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontFamily: kWabDisplayFamily,
                            fontFamilyFallback: kWabDisplayFallback,
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 2.5,
                          ).copyWith(color: WabTheme.textColor),
                        ),
                      ),
                      if (seal != null) ...[const SizedBox(width: 9), seal!],
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontFamily: kWabMonoFamily,
                      fontSize: 9,
                      letterSpacing: 3.1,
                    ).copyWith(color: WabTheme.mutedColor),
                  ),
                ],
              ),
            ),
            const Spacer(),
            if (motto != null)
              Padding(
                padding: const EdgeInsets.only(right: 18),
                child: Text(
                  motto!,
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    fontFamily: kWabKaiFamily,
                    fontFamilyFallback: kWabKaiFallback,
                    fontSize: 9,
                    letterSpacing: 1.6,
                  ).copyWith(color: WabTheme.mutedColor),
                ),
              ),
            ...trailing,
          ],
        ),
      ),
    );
  }
}
