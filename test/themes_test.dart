import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:wabisabi/wabisabi.dart';

void main() {
  test('create all', () {
    ThemeData materialTheme = WabTheme.materialTheme();
    CupertinoThemeData cupertinoTheme = WabTheme.cupertinoTheme();
    expect(materialTheme.brightness, Brightness.light);
    expect(cupertinoTheme.brightness, Brightness.dark);
  });
}
