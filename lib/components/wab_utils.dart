import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:io' show Platform;

bool wabIsIos() => !kIsWeb && (Platform.isIOS || Platform.isMacOS);

/// Old name, kept so consumers can migrate without a broken build.
@Deprecated('Renamed to wabIsIos. This alias goes at the next major version.')
bool isIos() => wabIsIos();
