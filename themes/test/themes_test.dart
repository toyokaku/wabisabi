import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:songkoro/flutter.dart';

void main() {
  test('create all', () {
    ThemeData materialTheme = SkrTheme.materialTheme();
    CupertinoThemeData cupertinoTheme = SkrTheme.cupertinoTheme();
    expect(materialTheme.brightness, Brightness.dark);
    expect(cupertinoTheme.brightness, Brightness.dark);
  });
}
