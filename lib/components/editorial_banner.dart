import 'package:flutter/material.dart';

import '../theme/typography.dart';
import '../theme/wab_theme.dart';
import '../tokens/material.dart';

/// Editorial masthead matching the kit's document-source language: brand at
/// left, title/subtitle immediately after it, quiet motto/actions at right.
///
/// The row sheds its quieter parts as it narrows rather than overflowing: the
/// motto goes first, then the kit label and its rule. What is left — brand,
/// title, actions — is what a masthead cannot do without.
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
        child: LayoutBuilder(
          builder: (context, constraints) {
            final wab = WabTheme.of(context);
            final showMotto = motto != null && constraints.maxWidth >= _mottoWidth;
            final showKitLabel = constraints.maxWidth >= _kitLabelWidth;
            final showSubtitle = constraints.maxWidth >= _subtitleWidth;
            return Row(
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
              ).copyWith(color: wab.textColor),
            ),
            if (showKitLabel) ...[
              const SizedBox(width: 16),
              Container(
                width: WAB_RULE_HAIRLINE,
                height: 54,
                color: wab.lineColor,
              ),
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
                  ).copyWith(color: wab.mutedColor),
                ),
              ),
            ],
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
                          ).copyWith(color: wab.textColor),
                        ),
                      ),
                      if (seal != null) ...[const SizedBox(width: 9), seal!],
                    ],
                  ),
                  if (showSubtitle) ...[
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontFamily: kWabMonoFamily,
                        fontSize: 9,
                        letterSpacing: 3.1,
                      ).copyWith(color: wab.mutedColor),
                    ),
                  ],
                ],
              ),
            ),
            const Spacer(),
            if (showMotto)
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
                  ).copyWith(color: wab.mutedColor),
                ),
              ),
            ...trailing,
          ],
            );
          },
        ),
      ),
    );
  }
}

/// Below this the motto is dropped.
const double _mottoWidth = 720;

/// Below this the kit label and its rule are dropped too.
const double _kitLabelWidth = 520;

/// Below this only the title survives; the subtitle would be squeezed to a
/// column of single characters.
const double _subtitleWidth = 460;
