import 'package:flutter/material.dart';
import '../tokens/spacing.dart';

/// Asset image with the kit's corner treatment.
///
/// Composes a [ClipRRect] rather than extending one: a Flutter composite widget
/// is not built to be subclassed, and a subclass cannot be const, cannot add a
/// field, and leaks the parent's whole API to consumers.
class WabImage extends StatelessWidget {
  const WabImage({
    super.key,
    required this.path,
    this.height = 150,
    this.width = 180,
    this.borderRadius = 0.0,
  });

  final String path;
  final double height;
  final double width;
  final double borderRadius;

  @override
  Widget build(BuildContext context) => ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: Image(
          fit: BoxFit.cover,
          height: height,
          width: width,
          image: AssetImage(path),
        ),
      );
}

/// Square-cornered asset icon at a fixed height.
class WabIcon extends StatelessWidget {
  const WabIcon({super.key, required this.path, this.height = 80.0});

  final String path;
  final double height;

  @override
  Widget build(BuildContext context) => Image(
        fit: BoxFit.cover,
        height: height,
        image: AssetImage(path),
      );
}

/// A tappable row of emblem + label.
@Deprecated('App domain, not a design-system primitive: a payment row belongs '
    'to whichever app needs one. Compose a Row of WabIcon and Text instead. '
    'Goes at the next major version.')
class WabPaymentRow extends StatelessWidget {
  const WabPaymentRow({
    super.key,
    required this.image,
    required this.text,
    this.callback,
  });

  final Widget image;
  final Widget text;
  final GestureTapCallback? callback;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: callback,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          // Flexible label so a narrow row ellipsizes instead of overflowing.
          children: [image, WAB_SIZED_BOX_20, Flexible(child: text)],
        ),
      );
}
