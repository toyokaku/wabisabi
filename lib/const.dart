import 'package:flutter/material.dart';

import 'utils/wab_widget.dart';
import 'utils/wab_theme.dart';

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

// Light Theme Colors
const Color WAB_LIGHT_BACKGROUND = Color(0xFFF4E9CD);
const Color WAB_LIGHT_SURFACE = Color(0xFFF8F5EE);
const Color WAB_LIGHT_PRIMARY = Color(0xFFFFFFFF);
const Color WAB_LIGHT_SECONDARY = Color(0xFFE8E3D9);
const Color WAB_LIGHT_ACCENT = Color(0xFF63BAF2);
const Color WAB_LIGHT_ON = Color(0xFF8AD192);
const Color WAB_LIGHT_OFF = Color(0xFFEEEEEE);
const Color WAB_LIGHT_TEXT = Color(0xFF333333);
const Color WAB_LIGHT_WOODY = Color(0xFFD8B87D);

// Dark Theme Colors
const Color WAB_DARK_BACKGROUND = Color(0xFF222222);
const Color WAB_DARK_SURFACE = Color(0xFF2A2A2A);
const Color WAB_DARK_PRIMARY = Color(0xFF333333);
const Color WAB_DARK_SECONDARY = Color(0xFF444444);
const Color WAB_DARK_ACCENT = Color(0xFFAD9E6C);
const Color WAB_DARK_ON = Color(0xFF65B96C);
const Color WAB_DARK_OFF = Color(0xFF444444);
const Color WAB_DARK_TEXT = Color(0xFFE0E0E0);
const Color WAB_DARK_WOODY = Color(0xFF3A352B);

// Layout Constants
const double WAB_CONTENT_MAX_WIDTH = 600.0;
const double WAB_CARD_BORDER_RADIUS = 8.0;

class WabDivider extends WabWidget<Container, Divider> {
  @override
  Container createCupertinoWidget(BuildContext context) =>
      Container(height: 1, color: WabTheme.secondaryColor);

  @override
  Divider createMaterialWidget(BuildContext context) => Divider(
    indent: 25.0,
    endIndent: 25.0,
    thickness: 1,
    color: WabTheme.secondaryColor,
  );
}

