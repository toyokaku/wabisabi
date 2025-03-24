library wabisabi;

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'utils/wab_widget.dart';
import 'utils/wab_theme.dart';
import 'button.dart';
import 'const.dart';

export 'utils/wab_theme.dart';
export 'utils/wab_utils.dart';

export 'button.dart';
export 'const.dart';
export 'image.dart';
export 'text.dart';

// Main 
class WabScaffold extends WabWidget<CupertinoPageScaffold, Scaffold> {
  WabScaffold({
    required this.body,
    this.title,
    this.appBar,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.floatingActionButtonAnimator,
  });

  final Widget body;
  final Text? title;
  final WabAppBar? appBar;
  final FloatingActionButton? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final FloatingActionButtonAnimator? floatingActionButtonAnimator;

  @override
  CupertinoPageScaffold createCupertinoWidget(BuildContext context) =>
      CupertinoPageScaffold(
        child: floatingActionButton == null
            ? body
            : PageView(
                children: <Widget>[
                  body,
                  WabFloatingActionButton(floatingActionButton!)
                ],
              ),
        navigationBar: appBar?.createCupertinoWidget(context) ??
            WabAppBar(
              title: title,
            ).createCupertinoWidget(context),
      );

  @override
  Scaffold createMaterialWidget(BuildContext context) => Scaffold(
        body: body,
        appBar: appBar?.createMaterialWidget(context) ??
            WabAppBar(
              title: title,
            ).createMaterialWidget(context),
        floatingActionButton: floatingActionButton,
        floatingActionButtonLocation: floatingActionButtonLocation,
        floatingActionButtonAnimator: floatingActionButtonAnimator,
      );
}

class WabAppBar extends WabWidget<CupertinoNavigationBar, PreferredSize> {
  WabAppBar({this.title, this.action});

  final Text? title;
  final Widget? action;

  @override
  CupertinoNavigationBar createCupertinoWidget(BuildContext context) =>
      CupertinoNavigationBar(
        middle: title,
        trailing: action,
      );

  @override
  PreferredSize createMaterialWidget(BuildContext context) => PreferredSize(
      child: AppBar(
        title: title,
        actions: action == null ? null : <Widget>[action!],
      ),
      preferredSize: WAB_APP_BAR_SIZE);
}

// Container
class WabContainer extends Container {
  WabContainer({required Widget child, EdgeInsets? padding})
      : super(
          padding: padding ?? WAB_PADDING_CONTAINER_SMALL,
          margin: WAB_PADDING_ALL,
          decoration: BoxDecoration(
              color: WabTheme.primaryColor,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: WabTheme.hintColor.withOpacity(0.1),
                  offset: const Offset(0, 3),
                  blurRadius: 10.0,
                )
              ]),
          child: child,
        );
}

class WabLiteContainer extends Container {
  WabLiteContainer({required Widget child})
      : super(
          margin: WAB_PADDING_ALL,
          child: child,
        );
}


