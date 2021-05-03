import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:io' show Platform;

bool isIos() => !kIsWeb && (Platform.isIOS || Platform.isMacOS);

// for test
// bool isIos() => true;