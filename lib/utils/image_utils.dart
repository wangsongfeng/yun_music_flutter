// ignore_for_file: slash_for_doc_comments

import 'package:flutter/material.dart';

class ImageUtils {
  static String getImagePath(String name, {String format = 'png'}) {
    return 'assets/images/$name.$format';
  }

  /**
   * 正在播放中的loging
   */
  static String getPlayingMusicTag() {
    return getImagePath('listen_music_tag_red', format: 'webp');
  }

  static String getAnimPath(String name, {String format = 'json'}) {
    return 'assets/anim/$name.$format';
  }

  static String getImageUrlFromSize(String? url, Size size) {
    if (url == null || url.isEmpty) {
      return '';
    }
    //向上取整
    final width = (size.width * 2).ceil();
    final height = (size.height * 2).ceil();
    return '$url?param=${width}y$height';
  }
}
