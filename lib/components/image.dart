import 'package:flutter/material.dart';
import '../tokens/spacing.dart';

class WabImage extends ClipRRect {
  WabImage({
    required String path,
    double height = 150,
    double width = 180,
    double borderRadius = 0.0,
  }) : super(
          borderRadius: BorderRadius.circular(borderRadius),
          child: Image(
            fit: BoxFit.cover,
            height: height,
            width: width,
            image: AssetImage(path),
          ),
        );
}

class WabIcon extends ClipRRect {
  WabIcon({required String path})
      : super(
          borderRadius: BorderRadius.circular(0.0),
          child: Image(
            fit: BoxFit.cover,
            height: 80.0,
            image: AssetImage(path),
          ),
        );
}

class WabPaymentRow extends GestureDetector {
  WabPaymentRow({
    required ClipRRect image,
    required Text text,
    GestureTapCallback? callback,
  }) : super(
          onTap: callback,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            // Flexible label so a narrow row ellipsizes instead of overflowing.
            children: [image, WAB_SIZED_BOX_20, Flexible(child: text)],
          ),
        );
}
