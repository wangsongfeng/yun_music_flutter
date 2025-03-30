// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yun_music/commons/res/dimens.dart';
import 'package:yun_music/utils/adapt.dart';
import 'package:yun_music/utils/common_utils.dart';
import '../../../utils/image_utils.dart';
import '../artist_detail_controller.dart';
import 'artist_card_content.dart';

class ArtistDetailHeader extends StatelessWidget {
  const ArtistDetailHeader({super.key, required this.controller});

  final ArtistDetailController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        height: controller.headerHeight.value +
            controller.animValue.value * controller.simitHeight +
            controller.extraPicHeight.value,
        color: Colors.transparent,
        child: Stack(
          children: [
            //最底部的歌手背景图
            Column(
              children: [
                Expanded(
                    child: Container(
                  color: Colors.transparent,
                )),
                ClipPath(
                  clipper: _CoverImgRect(),
                  child: Obx(() {
                    return Container(
                      color: Get.theme.cardColor,
                      width: Adapt.screenW(),
                      height: controller.cardHeight.value +
                          controller.animValue.value * controller.simitHeight,
                    );
                  }),
                )
              ],
            ),
            Positioned(
                left: 0,
                bottom: 0,
                child: ArtistCardContent(controller: controller)),

            //头像
            if (controller.getAvatarUrl()!.isNotEmpty)
              Positioned(
                  bottom: controller.cardHeight.value +
                      controller.animValue.value * controller.simitHeight -
                      Adapt.px(31) +
                      12,
                  left: 0,
                  right: 0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      buildUserAvatar(
                          ImageUtils.getImageUrlFromSize(
                              controller.getAvatarUrl(),
                              Size(Dimens.gap_dp105, Dimens.gap_dp105)),
                          Size(Adapt.px(62), Adapt.px(62))),
                    ],
                  ))
          ],
        ),
      );
    });
  }
}

class _CoverImgRect extends CustomClipper<Path> {
  final roundnessFactor = 10.0;

  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(size.width, size.height);
    path.lineTo(size.width, 0);
    //二阶贝塞尔弧
    path.quadraticBezierTo(size.width / 2, roundnessFactor, 0, 0);
    path.lineTo(0, size.height);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
