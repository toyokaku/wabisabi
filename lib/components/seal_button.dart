import 'package:flutter/material.dart';

import '../theme/wab_theme.dart';
import 'button.dart';
import 'seal_text.dart';

/// Canonical full-face cinnabar seal action.
///
/// Use [WabMaterialKind.zhuwen] when an outlined 朱文 button is desired; this
/// component represents the pressed red seal face itself.
class WabSealButton extends StatelessWidget {
  const WabSealButton({
    super.key,
    required this.label,
    this.onPressed,
    this.expand = false,
    this.fontSize = 22,
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
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        child: WabSealText(
          label,
          fontSize: fontSize,
          color: WabTheme.paperWhite,
          strokeWidth: .72,
        ),
      );
}
