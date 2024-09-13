// ignore_for_file: empty_constructor_bodies

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yun_music/commons/widgets/network_img_layer.dart';
import 'package:yun_music/pages/playlist_detail/playlist_detail_controller.dart';
import 'package:yun_music/pages/playlist_detail/widgets/playlist_top_official.dart';
import 'package:yun_music/utils/adapt.dart';

import '../../../commons/res/dimens.dart';
import '../../../commons/skeleton/music_skeleton.dart';
import '../../../commons/values/constants.dart';
import '../widgets/playlist_detail_top_normal.dart';

class PlaylistHeaderDelegate extends SliverPersistentHeaderDelegate {
  final PlaylistDetailController controller;

  double expandHeight;
  double minHeight;

  double extraPicHeight; //传入的加载到图片上的高度
  BoxFit fitType; //传入的填充方式

  PlaylistHeaderDelegate({
    required this.controller,
    required this.expandHeight,
    required this.minHeight,
    required this.extraPicHeight,
    required this.fitType,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final double mainHeight = maxExtent - shrinkOffset; //动态高度
    final offset = mainHeight / maxExtent;
    if (controller.detail.value != null) {
      if (offset <= 0.325) {
        controller.titleStatus.value = PlayListTitleStatus.TitleAndBtn;
      } else if (offset >= 0.75) {
        controller.titleStatus.value = PlayListTitleStatus.Normal;
      } else {
        controller.titleStatus.value = PlayListTitleStatus.Title;
      }
    }

    return ClipPath(
      clipper: _MyCoversRect(offset: offset),
      child: controller.secondOpenOfficial
          ? _buildOfficialCover(offset)
          : _buildNormalCover(offset),
    );
  }

  //普通歌单头部
  Widget _buildNormalCover(double offset) {
    return Stack(
      children: [
        //背景
        SizedBox(
          width: Adapt.screenW(),
          height: expandHeight + extraPicHeight,
          child: Obx(() {
            if (controller.coverImage.value == null) {
              return Container(
                padding: EdgeInsets.only(
                  left: Dimens.gap_dp15,
                  right: Dimens.gap_dp26,
                  top: Adapt.topPadding() + kToolbarHeight + Dimens.gap_dp12,
                ),
                color: Get.isDarkMode
                    ? Colors.transparent
                    : const Color.fromRGBO(146, 150, 160, 1.0),
                child: const Skeleton(child: PlaylistDetailTopPlaceholder()),
              );
            } else {
              return Obx(() {
                return Container(
                  width: Adapt.screenW(),
                  height: expandHeight + extraPicHeight,
                  color: controller.headerBgColor.value != null
                      ? controller.headerBgColor.value?.withOpacity(1.0)
                      : const Color.fromRGBO(146, 150, 160, 1.0),
                );
              });
            }
          }),
        ),

        Obx(() {
          return controller.detail.value == null
              ? Container()
              : Positioned(
                  left: Dimens.gap_dp15,
                  right: Dimens.gap_dp26,
                  bottom: Dimens.gap_dp56,
                  child: ClipRect(
                    clipper: MyContentRect(
                      yOffset: controller.clipOffset(),
                      scrollOffset: offset,
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Opacity(
                        opacity: offset,
                        child: PlaylistDetailTopNormal(controller: controller)),
                  ),
                );
        })
      ],
    );
  }

  //官方歌单非首次打开头部
  Widget _buildOfficialCover(double offset) {
    return Obx(
      () => Stack(
        children: [
          //背景
          Positioned.fill(
            child: NetworkImgLayer(
              width: Adapt.screenW(),
              height: expandHeight + extraPicHeight,
              src: controller.detail.value?.playlist.backgroundCoverUrl ?? '',
              fadeInDuration: const Duration(milliseconds: 200),
            ),
          ),
          if (controller.detail.value?.playlist.titleImageUrl != null)
            Positioned(
              left: 18,
              right: 18,
              bottom: Dimens.gap_dp40,
              child: ClipRect(
                clipper: MyContentRect(
                  yOffset: controller.clipOffset(),
                  scrollOffset: offset,
                ),
                clipBehavior: Clip.antiAlias,
                child: PlaylistTopOfficial(
                  key: controller.topContentKey,
                  controller: controller,
                ),
              ),
            ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => expandHeight + extraPicHeight;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

//滑动时候，header操作
class MyContentRect extends CustomClipper<Rect> {
  double yOffset;
  double scrollOffset;

  MyContentRect({required this.yOffset, required this.scrollOffset});

  @override
  Rect getClip(Size size) {
    double topClip = 0.0;
    if (scrollOffset == 0.0) {
      //收起
      topClip = size.height;
    } else if (scrollOffset == 1.0) {
      //展开
      topClip = 0.0;
    } else {
      //中间状态
      topClip = yOffset <= 0 ? 0.0 : yOffset;
    }

    return Rect.fromLTRB(0, topClip, size.width, size.height);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Rect> oldClipper) {
    return true;
  }
}

class _MyCoversRect extends CustomClipper<Path> {
  double offset;

  _MyCoversRect({required this.offset});

  @override
  Path getClip(Size size) {
    final roundnessFactor = offset * 10;
    final path = Path();
    path.moveTo(0, 0);
    path.lineTo(0, size.height - roundnessFactor);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - roundnessFactor);
    path.lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
