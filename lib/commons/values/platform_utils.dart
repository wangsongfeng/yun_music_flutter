import 'dart:io';

import 'package:flutter/foundation.dart';

class PlatformUtils {
  static bool _isWeb() {
    return kIsWeb == true;
  }

  static bool _isAndroid() {
    return _isWeb() ? false : Platform.isAndroid;
  }

  static bool _isIOS() {
    return _isWeb() ? false : Platform.isIOS;
  }

  static bool get isIOS => _isIOS();

  static bool get isAndroid => _isAndroid();

  static bool get isWeb => _isWeb();
}
