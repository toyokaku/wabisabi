import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'wab_widget.dart';
import '../theme/wab_theme.dart';
import '../tokens/spacing.dart';

class WabIconButton extends WabWidget<CupertinoButton, TextButton> {
  WabIconButton(
      {required this.icon, this.label, this.callback, this.padding = 0.0});

  final Widget icon;
  final Widget? label;
  final VoidCallback? callback;
  final double? padding;

  @override
  CupertinoButton createCupertinoWidget(BuildContext context) =>
      CupertinoButton.filled(
        onPressed: callback,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        borderRadius: BorderRadius.circular(WAB_CARD_BORDER_RADIUS),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            icon,
            if (label != null) SizedBox(width: 6),
            if (label != null) label!,
          ],
        ),
      );

  @override
  TextButton createMaterialWidget(BuildContext context) => TextButton.icon(
        onPressed: callback,
        icon: icon,
        label: label ?? Text(''),
        style: ButtonStyle(
          padding: WidgetStateProperty.all(EdgeInsets.all(padding ?? 0)),
          backgroundColor: WidgetStateProperty.all(WabTheme.surfaceColor),
          shape: WidgetStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(WAB_CARD_BORDER_RADIUS),
          )),
        ),
      );
}

class WabTextButton extends WabWidget<CupertinoButton, TextButton> {
  WabTextButton({required this.text, this.padding = 20.0, this.callback});

  final Text text;
  final double? padding;
  final VoidCallback? callback;

  @override
  CupertinoButton createCupertinoWidget(BuildContext context) => CupertinoButton(
        onPressed: callback,
        padding: EdgeInsets.all(padding!),
        borderRadius: BorderRadius.circular(WAB_CARD_BORDER_RADIUS),
        child: text,
      );

  @override
  TextButton createMaterialWidget(BuildContext context) => TextButton(
        onPressed: callback,
        style: ButtonStyle(
          padding: WidgetStateProperty.all(EdgeInsets.all(padding!)),
          backgroundColor: WidgetStateProperty.all(WabTheme.surfaceColor),
          shape: WidgetStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(WAB_CARD_BORDER_RADIUS),
          )),
        ),
        child: text,
      );
}

class WabElevatedButton extends WabWidget<CupertinoButton, Widget> {
  WabElevatedButton({
    required this.text,
    this.padding = 20.0,
    this.callback,
    this.icon,
    this.showChevron = false,
  });

  final Text text;
  final double? padding;
  final VoidCallback? callback;
  final Icon? icon;
  final bool showChevron;

  @override
  CupertinoButton createCupertinoWidget(BuildContext context) {
    Widget content = _buildContent(WabTheme.textColor);
    return CupertinoButton(
      onPressed: callback,
      padding: EdgeInsets.zero,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: padding ?? 18,
          vertical: padding != null ? padding! / 2 : 12,
        ),
        decoration: BoxDecoration(
          color: WabTheme.woodyColor,
          borderRadius: BorderRadius.circular(WAB_CARD_BORDER_RADIUS),
          boxShadow: WabTheme.elevationShadow,
        ),
        child: content,
      ),
    );
  }

  @override
  Widget createMaterialWidget(BuildContext context) => DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(WAB_CARD_BORDER_RADIUS),
          boxShadow: WabTheme.elevationShadow,
        ),
        child: ElevatedButton(
          onPressed: callback,
          style: ButtonStyle(
            shape: WidgetStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(WAB_CARD_BORDER_RADIUS),
            )),
            backgroundColor: WidgetStateProperty.all(WabTheme.woodyColor),
            foregroundColor: WidgetStateProperty.all(WabTheme.textColor),
            minimumSize: WidgetStateProperty.all(Size(double.infinity, 0)),
            elevation: WidgetStateProperty.all(0),
            padding: WidgetStateProperty.all(EdgeInsets.symmetric(
              horizontal: padding ?? 18,
              vertical: padding != null ? padding! / 2 : 12,
            )),
          ),
          child: _buildContent(WabTheme.textColor),
        ),
      );

  Widget _buildContent(Color iconColor) {
    if (icon == null && !showChevron) return text;
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (icon != null)
          Padding(padding: const EdgeInsets.only(right: 8), child: icon!),
        Expanded(child: text),
        if (showChevron) Icon(Icons.chevron_right, color: iconColor, size: 18),
      ],
    );
  }
}

class WabToggleButton extends WabWidget<CupertinoButton, ElevatedButton> {
  WabToggleButton({required this.text, required this.isOn, this.callback});

  final Text text;
  final bool isOn;
  final VoidCallback? callback;

  @override
  CupertinoButton createCupertinoWidget(BuildContext context) => CupertinoButton(
        onPressed: callback,
        color: isOn ? WabTheme.onColor : WabTheme.offColor,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        borderRadius: BorderRadius.circular(WAB_CARD_BORDER_RADIUS),
        child: text,
      );

  @override
  ElevatedButton createMaterialWidget(BuildContext context) => ElevatedButton(
        onPressed: callback,
        style: ButtonStyle(
          shape: WidgetStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(WAB_CARD_BORDER_RADIUS),
          )),
          backgroundColor:
              WidgetStateProperty.all(isOn ? WabTheme.onColor : WabTheme.offColor),
          foregroundColor: WidgetStateProperty.all(
              isOn ? Colors.white : WabTheme.textColor),
          elevation: WidgetStateProperty.all(0),
          padding: WidgetStateProperty.all(
              EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
        ),
        child: text,
      );
}

class WabFloatingActionButton
    extends WabWidget<CupertinoButton, FloatingActionButton> {
  WabFloatingActionButton(this.button);

  final FloatingActionButton button;

  @override
  CupertinoButton createCupertinoWidget(BuildContext context) => CupertinoButton(
        onPressed: button.onPressed,
        color: WabTheme.primaryColor,
        padding: EdgeInsets.all(16),
        borderRadius: BorderRadius.circular(30),
        child: button.child!,
      );

  @override
  FloatingActionButton createMaterialWidget(BuildContext context) =>
      FloatingActionButton(
        onPressed: button.onPressed,
        backgroundColor: WabTheme.primaryColor,
        foregroundColor: WabTheme.textColor,
        elevation: 2,
        child: button.child,
      );
}
