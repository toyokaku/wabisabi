library wabisabi;

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'utils/wab_widget.dart';
import 'utils/wab_theme.dart';
import 'button.dart';
import 'const.dart';
import 'text.dart';

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
  WabAppBar({this.title, this.action, this.leading});

  final Text? title;
  final Widget? action;
  final Widget? leading;

  @override
  CupertinoNavigationBar createCupertinoWidget(BuildContext context) =>
      CupertinoNavigationBar(
        leading: leading,
        middle: title,
        trailing: action,
      );

  @override
  PreferredSize createMaterialWidget(BuildContext context) => PreferredSize(
      child: AppBar(
        leading: leading,
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
          constraints: BoxConstraints(maxWidth: WAB_CONTENT_MAX_WIDTH),
          decoration: BoxDecoration(
              color: WabTheme.primaryColor,
              borderRadius: BorderRadius.circular(WAB_CARD_BORDER_RADIUS),
              boxShadow: <BoxShadow>[
                // Left highlight only - no shadows to match design in image
                BoxShadow(
                  color: Colors.white.withOpacity(0.12),
                  offset: const Offset(-1, 0),
                  blurRadius: 1.0,
                )
              ]),
          child: child,
        );
}

class WabLiteContainer extends Container {
  WabLiteContainer({required Widget child})
      : super(
          margin: WAB_PADDING_ALL,
          padding: WAB_PADDING_CONTAINER_SMALL,
          constraints: BoxConstraints(maxWidth: WAB_CONTENT_MAX_WIDTH),
          decoration: BoxDecoration(
            color: WabTheme.surfaceColor,
            borderRadius: BorderRadius.circular(WAB_CARD_BORDER_RADIUS),
            boxShadow: <BoxShadow>[
              // Left highlight only - no shadows to match design in image
              BoxShadow(
                color: Colors.white.withOpacity(0.12),
                offset: const Offset(-1, 0),
                blurRadius: 1.0,
              )
            ],
          ),
          child: child,
        );
}

// Invisible content container to constrain width
class WabContentContainer extends Container {
  WabContentContainer({
    required Widget child, 
    EdgeInsets? padding, 
    EdgeInsets? margin,
    double? maxWidth,
  }) : super(
          padding: padding,
          margin: margin ?? EdgeInsets.only(bottom: 8),
          constraints: BoxConstraints(
            maxWidth: maxWidth ?? WAB_CONTENT_MAX_WIDTH,
          ),
          child: child,
        );
}

// Scaffold with textured background
class WabTexturedScaffold extends WabWidget<CupertinoPageScaffold, Scaffold> {
  WabTexturedScaffold({
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
        backgroundColor: WabTheme.backgroundColor,
        child: Stack(
          children: [
            // Textured background - use a shader instead of image to avoid asset issues
            Positioned.fill(
              child: CustomPaint(
                painter: TexturePainter(isDark: WabTheme.isDark),
              ),
            ),
            // Main content
            floatingActionButton == null
                ? body
                : PageView(
                    children: <Widget>[
                      body,
                      WabFloatingActionButton(floatingActionButton!)
                    ],
                  ),
          ],
        ),
        navigationBar: appBar?.createCupertinoWidget(context) ??
            WabAppBar(
              title: title,
            ).createCupertinoWidget(context),
      );

  @override
  Scaffold createMaterialWidget(BuildContext context) => Scaffold(
        backgroundColor: WabTheme.backgroundColor,
        body: Stack(
          children: [
            // Textured background - use a shader instead of image to avoid asset issues
            Positioned.fill(
              child: CustomPaint(
                painter: TexturePainter(isDark: WabTheme.isDark),
              ),
            ),
            // Main content
            body,
          ],
        ),
        appBar: appBar?.createMaterialWidget(context) ??
            WabAppBar(
              title: title,
            ).createMaterialWidget(context),
        floatingActionButton: floatingActionButton,
        floatingActionButtonLocation: floatingActionButtonLocation,
        floatingActionButtonAnimator: floatingActionButtonAnimator,
      );
}

// Custom painter to generate texture effect
class TexturePainter extends CustomPainter {
  final bool isDark;
  
  TexturePainter({required this.isDark});
  
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    final random = DateTime.now().millisecondsSinceEpoch;
    
    if (isDark) {
      // Dark marble-like texture
      paint.color = Color.fromRGBO(40, 40, 40, 0.015);
      
      for (int i = 0; i < size.width; i += 20) {
        for (int j = 0; j < size.height; j += 20) {
          final noise = ((i * j + random) % 100) / 100;
          if (noise > 0.7) {
            final radius = 1 + noise * 3;
            canvas.drawCircle(
              Offset(i + (noise * 10), j + (noise * 10)),
              radius,
              paint,
            );
          }
        }
      }
      
      // Add some subtle marble veins
      paint.color = Color.fromRGBO(80, 75, 65, 0.02);
      for (int i = 0; i < 10; i++) {
        final startX = (random + i * 100) % size.width;
        final startY = (random + i * 200) % size.height;
        
        final path = Path();
        path.moveTo(startX, startY);
        
        for (int j = 0; j < 5; j++) {
          final endX = startX + ((random + i + j) % 200) - 100;
          final endY = startY + 50 + ((random + i + j) % 100);
          final controlX = startX + ((random + i + j * 2) % 150) - 75;
          final controlY = startY + 25 + ((random + i + j * 3) % 50);
          
          path.quadraticBezierTo(controlX, controlY, endX, endY);
        }
        
        canvas.drawPath(path, paint);
      }
    } else {
      // Light paper-like texture - very subtle
      paint.color = Color.fromRGBO(240, 235, 215, 0.025);
      
      for (int i = 0; i < size.width; i += 15) {
        for (int j = 0; j < size.height; j += 15) {
          final noise = ((i * j + random) % 100) / 100;
          if (noise > 0.6) {
            canvas.drawCircle(
              Offset(i + (noise * 5), j + (noise * 5)),
              0.5 + noise * 1.5,
              paint,
            );
          }
        }
      }
      
      // Slightly darker speckles
      paint.color = Color.fromRGBO(200, 190, 170, 0.015);
      for (int i = 0; i < size.width; i += 25) {
        for (int j = 0; j < size.height; j += 25) {
          final noise = ((i * j + random + 50) % 100) / 100;
          if (noise > 0.8) {
            canvas.drawCircle(
              Offset(i + (noise * 10), j + (noise * 10)),
              0.5 + noise,
              paint,
            );
          }
        }
      }
    }
  }
  
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
