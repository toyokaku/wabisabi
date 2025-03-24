import 'package:flutter/widgets.dart';
import 'wab_utils.dart';

abstract class WabWidget<C extends Widget, M extends Widget>
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (isIos()) {
      return createCupertinoWidget(context);
    }
    return createMaterialWidget(context);
  }

  C createCupertinoWidget(BuildContext context);

  M createMaterialWidget(BuildContext context);
}