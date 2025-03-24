import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'utils/wab_widget.dart';
import 'utils/wab_theme.dart';

// Button
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
        child: Row(
          children: [
            icon,
            if (label != null) label!,
          ],
        ),
        onPressed: callback,
      );

  @override
  TextButton createMaterialWidget(BuildContext context) => TextButton.icon(
    onPressed: callback,
    icon: icon,
    label: label ?? Text(''),
    style: ButtonStyle(
        padding: WidgetStateProperty.all(EdgeInsets.all(padding ?? 0))),
  );
}

class WabTextButton extends WabWidget<CupertinoButton, TextButton> {
  WabTextButton({required this.text, this.padding = 20.0, this.callback});

  late final Text text;
  late final double? padding;
  late final VoidCallback? callback;

  @override
  CupertinoButton createCupertinoWidget(BuildContext context) =>
      CupertinoButton(
        child: text,
        onPressed: callback,
        padding: EdgeInsets.all(padding!),
      );

  @override
  TextButton createMaterialWidget(BuildContext context) => TextButton(
    child: text,
    onPressed: callback,
    style: ButtonStyle(
        padding: WidgetStateProperty.all(EdgeInsets.all(padding!))),
  );
}

class WabElevatedButton extends WabWidget<CupertinoButton, ElevatedButton> {
  WabElevatedButton({required this.text, this.padding = 20.0, this.callback});

  final Text text;
  final double? padding;
  final VoidCallback? callback;

  @override
  CupertinoButton createCupertinoWidget(BuildContext context) =>
      CupertinoButton.filled(
        child: text,
        padding: EdgeInsets.all(padding!),
        onPressed: callback,
      );

  @override
  ElevatedButton createMaterialWidget(BuildContext context) => ElevatedButton(
    style: ButtonStyle(
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        backgroundColor: WidgetStateProperty.all(WabTheme.primaryColor),
        padding: WidgetStateProperty.all(EdgeInsets.all(padding!))),
    onPressed: callback,
    child: text,
  );
}

class WabFloatingActionButton
    extends WabWidget<CupertinoButton, FloatingActionButton> {
  WabFloatingActionButton(this.button);

  final FloatingActionButton button;

  @override
  CupertinoButton createCupertinoWidget(BuildContext context) =>
      CupertinoButton(
        child: button.child!,
        onPressed: button.onPressed,
      );

  @override
  FloatingActionButton createMaterialWidget(BuildContext context) => button;
}

