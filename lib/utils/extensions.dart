import 'package:flutter/material.dart';
import 'package:yun_music/utils/adapt.dart';

extension ImageExtension on num {
  int cacheSize(BuildContext context) {
    return (this * Adapt.devicePixelRatio()).round();
  }
}
