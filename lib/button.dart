import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'utils/wab_widget.dart';
import 'utils/wab_theme.dart';
import 'const.dart';

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
          mainAxisSize: MainAxisSize.min,
          children: [
            icon,
            if (label != null) SizedBox(width: 6), 
            if (label != null) label!,
          ],
        ),
        onPressed: callback,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        borderRadius: BorderRadius.circular(WAB_CARD_BORDER_RADIUS),
      );

  @override
  TextButton createMaterialWidget(BuildContext context) => TextButton.icon(
    onPressed: callback,
    icon: icon,
    label: label ?? Text(''),
    style: ButtonStyle(
        padding: WidgetStateProperty.all(EdgeInsets.all(padding ?? 0)),
        backgroundColor: WidgetStateProperty.all(WabTheme.surfaceColor),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(WAB_CARD_BORDER_RADIUS),
          ),
        ),
    ),
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
        borderRadius: BorderRadius.circular(WAB_CARD_BORDER_RADIUS),
      );

  @override
  TextButton createMaterialWidget(BuildContext context) => TextButton(
    child: text,
    onPressed: callback,
    style: ButtonStyle(
        padding: WidgetStateProperty.all(EdgeInsets.all(padding!)),
        backgroundColor: WidgetStateProperty.all(WabTheme.surfaceColor),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(WAB_CARD_BORDER_RADIUS),
          ),
        ),
    ),
  );
}

class WabElevatedButton extends WabWidget<CupertinoButton, ElevatedButton> {
  WabElevatedButton({
    required this.text, 
    this.padding = 20.0, 
    this.callback, 
    this.icon, 
    this.showChevron = false
  });

  final Text text;
  final double? padding;
  final VoidCallback? callback;
  final Icon? icon;
  final bool showChevron;

  @override
  CupertinoButton createCupertinoWidget(BuildContext context) {
    Widget buttonContent = text;
    
    if (icon != null || showChevron) {
      buttonContent = Container(
        color: Colors.transparent,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (icon != null) 
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: icon!,
              ),
            Expanded(child: text),
            if (showChevron) 
              Icon(
                Icons.chevron_right,
                color: WabTheme.textColor,
                size: 18,
              ),
          ],
        ),
      );
    }
    
    return CupertinoButton(
      onPressed: callback,
      padding: EdgeInsets.zero,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: padding ?? 18, 
          vertical: padding != null ? padding! / 2 : 12
        ),
        decoration: BoxDecoration(
          color: WabTheme.woodyColor,
          borderRadius: BorderRadius.circular(WAB_CARD_BORDER_RADIUS),
          boxShadow: [
            // Left highlight
            BoxShadow(
              color: Colors.white.withOpacity(0.12),
              offset: Offset(-1, 0),
              blurRadius: 1,
            ),
          ],
        ),
        child: buttonContent,
      ),
    );
  }

  @override
  ElevatedButton createMaterialWidget(BuildContext context) {
    Widget buttonContent = text;
    
    if (icon != null || showChevron) {
      buttonContent = Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (icon != null) 
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: icon!,
            ),
          Expanded(child: text),
          if (showChevron)
            Icon(
              Icons.chevron_right,
              color: WabTheme.textColor,
              size: 18,
            ),
        ],
      );
    }
    
    return ElevatedButton(
      style: ButtonStyle(
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(WAB_CARD_BORDER_RADIUS),
          ),
        ),
        backgroundColor: WidgetStateProperty.all(WabTheme.woodyColor),
        foregroundColor: WidgetStateProperty.all(WabTheme.textColor),
        minimumSize: WidgetStateProperty.all(Size(double.infinity, 0)),
        elevation: WidgetStateProperty.all(0),
        padding: WidgetStateProperty.all(EdgeInsets.symmetric(
          horizontal: padding ?? 18, 
          vertical: padding != null ? padding! / 2 : 12)
        ),
      ),
      onPressed: callback,
      child: buttonContent,
    );
  }
}

class WabToggleButton extends WabWidget<CupertinoButton, ElevatedButton> {
  WabToggleButton({required this.text, required this.isOn, this.callback});

  final Text text;
  final bool isOn;
  final VoidCallback? callback;

  @override
  CupertinoButton createCupertinoWidget(BuildContext context) =>
      CupertinoButton(
        child: text,
        onPressed: callback,
        color: isOn ? WabTheme.onColor : WabTheme.offColor,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        borderRadius: BorderRadius.circular(WAB_CARD_BORDER_RADIUS),
      );

  @override
  ElevatedButton createMaterialWidget(BuildContext context) => ElevatedButton(
    style: ButtonStyle(
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(WAB_CARD_BORDER_RADIUS),
          ),
        ),
        backgroundColor: WidgetStateProperty.all(
          isOn ? WabTheme.onColor : WabTheme.offColor
        ),
        foregroundColor: WidgetStateProperty.all(
          isOn ? Colors.white : WabTheme.textColor
        ),
        elevation: WidgetStateProperty.all(0),
        padding: WidgetStateProperty.all(
          EdgeInsets.symmetric(horizontal: 20, vertical: 10)
        )),
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
        color: WabTheme.primaryColor,
        padding: EdgeInsets.all(16),
        borderRadius: BorderRadius.circular(30),
      );

  @override
  FloatingActionButton createMaterialWidget(BuildContext context) => 
      FloatingActionButton(
        onPressed: button.onPressed,
        child: button.child,
        backgroundColor: WabTheme.primaryColor,
        foregroundColor: WabTheme.textColor,
        elevation: 2,
      );
}

