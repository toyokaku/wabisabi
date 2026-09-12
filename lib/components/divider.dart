import 'package:flutter/material.dart';
import 'wab_widget.dart';
import '../theme/wab_theme.dart';

class WabDivider extends WabWidget<Container, Divider> {
  @override
  Container createCupertinoWidget(BuildContext context) =>
      Container(height: 0.8, color: WabTheme.of(context).lineColor);

  @override
  Divider createMaterialWidget(BuildContext context) => Divider(
        indent: 25.0,
        endIndent: 25.0,
        thickness: 0.8,
        color: WabTheme.of(context).lineColor,
      );
}
