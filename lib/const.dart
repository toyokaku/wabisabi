import 'package:flutter/material.dart';

import 'utils/wab_widget.dart';

// Constants
const SizedBox WAB_SIZED_BOX_20 = SizedBox(
  height: 20.0,
  width: 60.0,
);

const Size WAB_APP_BAR_SIZE = Size.fromHeight(50.0);

const EdgeInsets WAB_PADDING_ALL = EdgeInsets.all(10.0);

const EdgeInsets WAB_PADDING_CONTAINER_SMALL =
EdgeInsets.symmetric(vertical: 10.0, horizontal: 25);

const EdgeInsets WAB_PADDING_CONTAINER_LARGE =
EdgeInsets.symmetric(vertical: 20.0, horizontal: 50);

class WabDivider extends WabWidget<Container, Divider> {
  @override
  Container createCupertinoWidget(BuildContext context) =>
      Container(height: 1, color: Colors.white12);

  @override
  Divider createMaterialWidget(BuildContext context) => Divider(
    indent: 25.0,
    endIndent: 25.0,
    thickness: 1,
  );
}

