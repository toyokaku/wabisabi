library songkoro;

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'utils/skr_widget.dart';
import 'utils/skr_theme.dart';
import 'button.dart';
import 'const.dart';

export 'utils/skr_theme.dart';
export 'utils/skr_utils.dart';

export 'button.dart';
export 'const.dart';
export 'image.dart';
export 'text.dart';

// Main
class SkrScaffold extends SkrWidget<CupertinoPageScaffold, Scaffold> {
  SkrScaffold({
    required this.body,
    this.title,
    this.appBar,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.floatingActionButtonAnimator,
  });

  final Widget body;
  final Text? title;
  final SkrAppBar? appBar;
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
                  SkrFloatingActionButton(floatingActionButton!)
                ],
              ),
        navigationBar: appBar?.createCupertinoWidget(context) ??
            SkrAppBar(
              title: title,
            ).createCupertinoWidget(context),
      );

  @override
  Scaffold createMaterialWidget(BuildContext context) => Scaffold(
        body: body,
        appBar: appBar?.createMaterialWidget(context) ??
            SkrAppBar(
              title: title,
            ).createMaterialWidget(context),
        floatingActionButton: floatingActionButton,
        floatingActionButtonLocation: floatingActionButtonLocation,
        floatingActionButtonAnimator: floatingActionButtonAnimator,
      );
}

class SkrAppBar extends SkrWidget<CupertinoNavigationBar, PreferredSize> {
  SkrAppBar({this.title, this.action});

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
      preferredSize: SKR_APP_BAR_SIZE);
}

// Container
class SkrContainer extends Container {
  SkrContainer({required Widget child, EdgeInsets? padding})
      : super(
          padding: padding ?? SKR_PADDING_CONTAINER_SMALL,
          margin: SKR_PADDING_ALL,
          decoration: BoxDecoration(
              color: SkrTheme.primaryColor,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: SkrTheme.hintColor.withOpacity(0.1),
                  offset: const Offset(0, 3),
                  blurRadius: 10.0,
                )
              ]),
          child: child,
        );
}

class SkrLiteContainer extends Container {
  SkrLiteContainer({required Widget child})
      : super(
          margin: SKR_PADDING_ALL,
          child: child,
        );
}


