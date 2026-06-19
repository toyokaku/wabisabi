import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'wab_widget.dart';
import '../theme/wab_theme.dart';
import '../tokens/spacing.dart';

export 'wab_utils.dart' show isIos;

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
        navigationBar: appBar?.createCupertinoWidget(context) ??
            WabAppBar(title: title).createCupertinoWidget(context),
        child: floatingActionButton == null
            ? body
            : PageView(children: [body]),
      );

  @override
  Scaffold createMaterialWidget(BuildContext context) => Scaffold(
        appBar: appBar?.createMaterialWidget(context) ??
            WabAppBar(title: title).createMaterialWidget(context),
        body: body,
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
        preferredSize: WAB_APP_BAR_SIZE,
        child: AppBar(
          leading: leading,
          title: title,
          actions: action == null ? null : [action!],
        ),
      );
}

class WabContainer extends Container {
  WabContainer({required Widget child, EdgeInsets? padding})
      : super(
          padding: padding ?? WAB_PADDING_CONTAINER_SMALL,
          margin: WAB_PADDING_ALL,
          decoration: BoxDecoration(
            color: WabTheme.primaryColor,
            borderRadius: BorderRadius.circular(WAB_SECTION_BORDER_RADIUS),
            border: Border.all(
              color: WabTheme.isDark
                  ? WabTheme.accentColor.withOpacity(0.28)
                  : WabTheme.secondaryColor,
              width: 0.8,
            ),
          ),
          child: child,
        );
}

class WabLiteContainer extends Container {
  WabLiteContainer({required Widget child})
      : super(
          margin: WAB_PADDING_ALL,
          padding: WAB_PADDING_CONTAINER_SMALL,
          decoration: BoxDecoration(
            color: WabTheme.surfaceColor,
            borderRadius: BorderRadius.circular(WAB_SECTION_BORDER_RADIUS),
            border: Border.all(
              color: WabTheme.isDark
                  ? WabTheme.accentColor.withOpacity(0.28)
                  : WabTheme.secondaryColor,
              width: 0.8,
            ),
          ),
          child: child,
        );
}

class WabContentContainer extends Container {
  WabContentContainer({
    required Widget child,
    EdgeInsets? padding,
    EdgeInsets? margin,
    double? maxWidth,
  }) : super(
          padding: padding,
          margin: margin ?? EdgeInsets.only(bottom: 8),
          // No default width cap — opt in via [maxWidth] only when needed.
          constraints:
              maxWidth == null ? null : BoxConstraints(maxWidth: maxWidth),
          child: child,
        );
}

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
        navigationBar: appBar?.createCupertinoWidget(context) ??
            WabAppBar(title: title).createCupertinoWidget(context),
        child: Stack(children: [
          Positioned.fill(
              child: CustomPaint(
                  painter: TexturePainter(isDark: WabTheme.isDark))),
          floatingActionButton == null ? body : PageView(children: [body]),
        ]),
      );

  @override
  Scaffold createMaterialWidget(BuildContext context) => Scaffold(
        backgroundColor: WabTheme.backgroundColor,
        appBar: appBar?.createMaterialWidget(context) ??
            WabAppBar(title: title).createMaterialWidget(context),
        body: Stack(children: [
          Positioned.fill(
              child: CustomPaint(
                  painter: TexturePainter(isDark: WabTheme.isDark))),
          body,
        ]),
        floatingActionButton: floatingActionButton,
        floatingActionButtonLocation: floatingActionButtonLocation,
        floatingActionButtonAnimator: floatingActionButtonAnimator,
      );
}

class TexturePainter extends CustomPainter {
  final bool isDark;
  TexturePainter({required this.isDark});

  // Deterministic pseudo-random in [0,1) from two ints.
  static double _rand(int a, int b) =>
      ((a * 1664525 + b * 1013904223 + 42) & 0x7FFFFFFF) / 0x7FFFFFFF;

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    if (isDark) {
      _paintDarkLacquer(canvas, w, h);
    } else {
      _paintLightWashi(canvas, w, h);
    }
  }

  void _paintLightWashi(Canvas canvas, double w, double h) {
    // Layer 1 — cloud tonal variation: overlapping translucent ellipses
    // Some warmer, some slightly cooler, creates the watercolor cloudiness.
    const cloudPositions = [
      [0.08, 0.12], [0.55, 0.07], [0.82, 0.18], [0.25, 0.35],
      [0.70, 0.30], [0.10, 0.60], [0.45, 0.55], [0.90, 0.65],
      [0.30, 0.80], [0.65, 0.75], [0.15, 0.92], [0.80, 0.88],
      [0.50, 0.20], [0.40, 0.70],
    ];
    final warmCloud = Paint()
      ..color = const Color(0x05A07040)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 60);
    final coolCloud = Paint()
      ..color = const Color(0x03809090)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 55);
    for (int k = 0; k < cloudPositions.length; k++) {
      final cx = cloudPositions[k][0] * w;
      final cy = cloudPositions[k][1] * h;
      final rx = 80.0 + _rand(k, 1) * 100;
      final ry = 60.0 + _rand(k, 2) * 80;
      canvas.drawOval(Rect.fromCenter(center: Offset(cx, cy), width: rx * 2, height: ry * 2),
          k.isEven ? warmCloud : coolCloud);
    }

    // Layer 2 — washi fiber threads: horizontal, slight organic wave, varying weight
    final fiberBase = Paint()..style = PaintingStyle.stroke;
    double jPos = 0;
    int row = 0;
    while (jPos < h) {
      final opacity = 0x06 + (_rand(row, 7).clamp(0, 1) * 0x0E).toInt();
      final strokeW = 0.3 + _rand(row, 11) * 0.7;
      fiberBase.color = Color.fromARGB(opacity, 0x90, 0x70, 0x50);
      fiberBase.strokeWidth = strokeW;

      if (_rand(row, 3) < 0.62) {
        final path = Path()..moveTo(0, jPos);
        for (double x = 0; x < w; x += 60) {
          final ctrlX = x + 30;
          final ctrlY = jPos + (_rand(row, (x ~/ 10)) * 3 - 1.5);
          final endY = jPos + (_rand(row, (x ~/ 7)) * 2 - 1.0);
          path.quadraticBezierTo(ctrlX, ctrlY, x + 60, endY);
        }
        canvas.drawPath(path, fiberBase);
      }

      jPos += 2 + (_rand(row, 5) * 4).toInt();
      row++;
    }

    // Layer 3 — grain: scattered micro-dots
    final grainPaint = Paint()..color = const Color(0x10A08055);
    for (int i = 0; i < w.toInt(); i += 3) {
      for (int j = 0; j < h.toInt(); j += 3) {
        if (_rand(i, j) > 0.80) {
          final r = 0.3 + _rand(i + 1, j) * 0.4;
          canvas.drawCircle(Offset(i.toDouble(), j.toDouble()), r, grainPaint);
        }
      }
    }
  }

  void _paintDarkLacquer(Canvas canvas, double w, double h) {
    // Layer 1 — vignette: soft black at corners to add depth
    final vigPaint = Paint()..color = const Color(0x18000000);
    final vRad = w * 0.45;
    canvas.drawCircle(Offset(0, 0), vRad, vigPaint);
    canvas.drawCircle(Offset(w, 0), vRad, vigPaint);
    canvas.drawCircle(Offset(0, h), vRad, vigPaint);
    canvas.drawCircle(Offset(w, h), vRad, vigPaint);

    // Layer 2 — warm amber cloud patches (barely visible)
    final warmPatch = Paint()
      ..color = const Color(0x06C8A84A)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 70);
    const patches = [[0.25, 0.30], [0.70, 0.60], [0.45, 0.80], [0.80, 0.20]];
    for (int k = 0; k < patches.length; k++) {
      final cx = patches[k][0] * w;
      final cy = patches[k][1] * h;
      canvas.drawOval(
        Rect.fromCenter(center: Offset(cx, cy), width: 160, height: 120),
        warmPatch,
      );
    }

    // Layer 3 — fine warm grain
    final grainPaint = Paint()..color = const Color(0x09C8A84A);
    for (int i = 0; i < w.toInt(); i += 3) {
      for (int j = 0; j < h.toInt(); j += 3) {
        if (_rand(i, j) > 0.85) {
          canvas.drawCircle(Offset(i.toDouble(), j.toDouble()), 0.6, grainPaint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
