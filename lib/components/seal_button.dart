import 'package:flutter/material.dart';

import '../theme/wab_theme.dart';
import 'button.dart';
import 'seal_text.dart';

/// Canonical full-face cinnabar seal action.
class WabSealButton extends StatelessWidget {
  const WabSealButton({
    super.key,
    required this.label,
    this.onPressed,
    this.expand = false,
    this.fontSize = 24,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool expand;
  final double fontSize;

  @override
  Widget build(BuildContext context) => WabButton(
        kind: WabMaterialKind.seal,
        onPressed: onPressed,
        expand: expand,
        padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 4),
        child: WabSealText(
          label,
          fontSize: fontSize,
          color: WabTheme.paperWhite,
          strokeWidth: .82,
        ),
      );
}
