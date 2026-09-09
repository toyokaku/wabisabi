import 'package:flutter/material.dart';

import '../theme/wab_theme.dart';
import '../materials/surface.dart';
import '../tokens/material.dart';
import 'button.dart';

/// Collection/content card: paper sheet, light ink boundary, no dashboard-style
/// heavy double frame. Elevation is reserved for explicit shadow specimens.
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

  final Widget icon;
  final String title;
  final String description;
  final String? buttonLabel;
  final VoidCallback? onPressed;
  final bool highlighted;

  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: WabTheme.lineColor,
            width: WAB_RULE_HAIRLINE,
          ),
        ),
        child: WabSurface(
          kind: WabSurfaceKind.paper,
          clip: false,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 38, child: Center(child: icon)),
                const SizedBox(height: 6),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: WabTheme.textColor,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    fontFamilyFallback: kWabKaiFallback,
                  ),
                ),
                const SizedBox(height: 6),
                Divider(
                  color: WabTheme.lineColor,
                  thickness: WAB_RULE_HAIRLINE,
                  height: WAB_RULE_HAIRLINE,
                  indent: 18,
                  endIndent: 18,
                ),
                const SizedBox(height: 6),
                Text(
                  description,
                  textAlign: TextAlign.center,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: WabTheme.mutedColor,
                    fontSize: 9,
                    height: 1.35,
                    fontFamilyFallback: kWabKaiFallback,
                  ),
                ),
                if (buttonLabel != null) ...[
                  const SizedBox(height: 9),
                  WabButton(
                    kind: highlighted
                        ? WabMaterialKind.wood
                        : WabMaterialKind.zhuwen,
                    onPressed: onPressed,
                    padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 6),
                    child: Text(buttonLabel!),
                  ),
                ],
              ],
            ),
          ),
        ),
      );
}
