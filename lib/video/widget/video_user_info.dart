import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marquee_list/marquee_list.dart';
import 'package:yun_music/commons/res/dimens.dart';
import 'package:yun_music/utils/image_utils.dart';

import '../controller/video_list_controller.dart';
import '../logic.dart';
import '../state.dart';

class VideoUserInfo extends StatelessWidget {
  VideoUserInfo({super.key, required this.controller});
  final VideoState state = Get.find<VideoLogic>().videoState;

  final VPVideoController? controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          left: Dimens.gap_dp15,
          right: Dimens.gap_dp80,
          bottom: Dimens.gap_dp8,
          top: Dimens.gap_dp12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: const [
              0,
              0.6,
              1
            ],
            colors: [
              Colors.black.withOpacity(0.03),
              Colors.black.withOpacity(0.01),
              Colors.black.withOpacity(0)
            ]),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          creatUserName(),
          SizedBox(
            height: Dimens.gap_dp6,
          ),
          creatDesc(),
          SizedBox(
            height: Dimens.gap_dp12,
          ),
          marqueeText(),
        ],
      ),
    );
  }

  Widget creatUserName() {
    return Text(
      "@${controller!.videoInfo.value!.avatar!.nickname}",
      style: TextStyle(
          fontSize: Dimens.font_sp15,
          color: Colors.white,
          fontWeight: FontWeight.bold),
    );
  }

  Widget creatDesc() {
    return Text(
      "${controller!.videoInfo.value!.desc}",
      style: TextStyle(
          fontSize: Dimens.font_sp13,
          color: Colors.white.withOpacity(0.9),
          fontWeight: FontWeight.w600),
    );
  }

  //文字走马灯
  Widget marqueeText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(right: Dimens.gap_dp6),
          child: Image.asset(
            ImageUtils.getImagePath('icon_home_musicnote'),
            width: Dimens.gap_dp14,
          ),
        ),
        MarqueeList(
            scrollDuration: Duration(milliseconds: 240),
            scrollDirection: Axis.horizontal,
            children: [
              Text(
                  '${controller!.videoInfo.value?.music?.title} - ${controller!.videoInfo.value?.music?.author}',
                  style: TextStyle(
                      fontSize: Dimens.font_sp13,
                      color: Colors.white,
                      fontWeight: FontWeight.w600)),
              Text(
                  '${controller!.videoInfo.value?.music?.title} - ${controller!.videoInfo.value?.music?.author}',
                  style: TextStyle(
                      fontSize: Dimens.font_sp13,
                      color: Colors.white,
                      fontWeight: FontWeight.w600)),
            ])
      ],
    );
  }
}
