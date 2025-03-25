import 'package:flutter/material.dart';
import 'package:yun_music/utils/adapt.dart';

extension ImageExtension on num {
  int cacheSize(BuildContext context) {
    return (this * Adapt.devicePixelRatio()).round();
  }
}

extension ListExtension on List {
  List<List<E>> chunked<E>(int chunkSize) {
    return [
      for (var i = 0; i < length; i += chunkSize)
        sublist(i, i + chunkSize).cast<E>()
    ];
  }
}
