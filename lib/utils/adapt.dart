// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:yun_music/commons/res/dimens.dart';

class Adapt {
  Adapt._();

  static double _width = 0;
  static double _height = 0;
  static double _topPadding = 0;
  static double _bottomPadding = 0;

  static double? _ratio;

  static double _devicePixelRatio = 0;

  static bool padding_b_h = false;

  static void initContext(BuildContext context) {
    context.isDarkMode;

    /// 类似于 MediaQuery.of(context).size。
    final size = MediaQuery.sizeOf(context);
    if (_width == 0 || _height == 0) {
      _width = size.width;
      _height = size.height;
    }
    if (_bottomPadding == 0) {
      _bottomPadding = MediaQuery.paddingOf(context).bottom;
      padding_b_h = true;
    }
    if (_topPadding == 0) {
      _topPadding = MediaQuery.paddingOf(context).top;
    }
    if (_devicePixelRatio == 0) {
      _devicePixelRatio = MediaQuery.devicePixelRatioOf(context);
    }
  }

  static void _init(int number) {
    _ratio = _width / number;
  }

  static double px(double number) {
    if (_ratio == null || (_ratio ?? 0) <= 0) {
      Adapt._init(375);
    }
    if (!(_ratio is double || _ratio is int)) {
      Adapt._init(375);
    }
    return number * _ratio!;
  }

  static double screenW() {
    return _width;
  }

  static double screenH() {
    return _height;
  }

  static double bottomPadding() {
    return _bottomPadding;
  }

  static double topPadding() {
    return _topPadding;
  }

  static double tabbar_padding() {
    return Dimens.gap_dp49 + bottomPadding();
  }

  static tabbar_height() {
    return Dimens.gap_dp49;
  }

  static double contentHeight() {
    return screenH() - topPadding() - bottomPadding();
  }

  static double devicePixelRatio() {
    return _devicePixelRatio;
  }
}

class _Fonts {
  final PuHuiTi = 'PuHuiTi';
  final PuHuiTiX = 'PuHuiTiX';
  final IconFonts = 'iconfont';
  final PingFang = 'PingFang';
  final Dolphin_Medium = 'Dolphin-Medium';
  final MontserratM = 'MontserratM';
}

class W {
  static final fonts = _Fonts();
}
