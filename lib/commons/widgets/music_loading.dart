import 'package:flutter/material.dart';
import 'package:yun_music/commons/res/app_themes.dart';
import 'package:yun_music/commons/res/dimens.dart';
import 'package:yun_music/commons/widgets/frame_animation_image.dart';

class MusicLoading extends StatelessWidget {
  final Axis axis;

  final bool showText;

  final double width;

  MusicLoading(
      {super.key,
      this.axis = Axis.vertical,
      this.showText = true,
      this.width = 20});

  final List<String> list = [
    'ca_',
    'caa',
    'cab',
    'cac',
  ];
  @override
  Widget build(BuildContext context) {
    final bool ver = axis == Axis.vertical;
    if (ver) {
      return Center(
        child: Column(
          children: _loadingContent(ver),
        ),
      );
    } else {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _loadingContent(ver),
      );
    }
  }

  List<Widget> _loadingContent(bool ver) {
    return [
      if (!ver) const Expanded(child: SizedBox.shrink()),
      FrameAnimationImage(
        const Key('MusicLoading'),
        list,
        width: width,
        height: width,
        interval: 80,
      ),
      if (axis == Axis.vertical)
        SizedBox(height: Dimens.gap_dp15)
      else
        SizedBox(width: Dimens.gap_dp10),
      if (showText)
        Text(
          '正在加载中...',
          style:
              TextStyle(color: AppThemes.text_gray, fontSize: Dimens.font_sp13),
        ),
      if (!ver) const Expanded(child: SizedBox.shrink()),
    ];
  }
}
