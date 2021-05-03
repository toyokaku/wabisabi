import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'const.dart';

// Image
class SkrImage extends ClipRRect {
  SkrImage(
      {required String path,
        double height = 150,
        double width = 180,
        double borderRadius = 20.0})
      : super(
    borderRadius: BorderRadius.circular(borderRadius),
    child: Image(
        fit: BoxFit.cover,
        height: height,
        width: width,
        image: AssetImage(path)),
  );
}

class SkrIcon extends ClipRRect {
  SkrIcon({required String path})
      : super(
    borderRadius: BorderRadius.circular(10.0),
    child: Image(
      fit: BoxFit.cover,
      height: 80.0,
      image: AssetImage(path),
    ),
  );
}


// Payment
class SkrPaymentRow extends GestureDetector {
  SkrPaymentRow(
      {required ClipRRect image, Text? text, GestureTapCallback? callback})
      : super(
    onTap: callback,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children:
      text == null ? [] : <Widget>[image, SKR_SIZED_BOX_20, text],
    ),
  );
}

