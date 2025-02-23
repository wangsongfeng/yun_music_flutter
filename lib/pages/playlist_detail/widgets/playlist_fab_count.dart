// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yun_music/commons/res/app_themes.dart';
import 'package:yun_music/pages/playlist_detail/playlist_detail_controller.dart';

import '../../../commons/res/dimens.dart';
import '../../../utils/adapt.dart';
import '../../../utils/common_utils.dart';
import '../../../utils/image_utils.dart';

class PlaylistFabCountPage extends StatelessWidget
    implements PreferredSizeWidget {
  const PlaylistFabCountPage({super.key, required this.controller});

  final PlaylistDetailController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Dimens.gap_dp44,
      padding: EdgeInsets.only(left: Dimens.gap_dp5, right: Dimens.gap_dp5),
      decoration: BoxDecoration(
          boxShadow: Get.isDarkMode
              ? null
              : [
                  BoxShadow(
                      color: Get.theme.shadowColor,
                      offset: const Offset(0, 5),
                      blurRadius: 8.0)
                ],
          borderRadius: BorderRadius.all(Radius.circular(Dimens.gap_dp22)),
          color: Get.isDarkMode ? Colors.grey.shade900 : null,
          gradient: Get.isDarkMode
              ? null
              : LinearGradient(
                  colors: [AppThemes.white.withOpacity(0.9), AppThemes.white],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter)),
      child: Obx(() => Row(
            children: [
              Expanded(
                  child: GestureDetector(
                onTap: () {},
                child: _buildItem(
                    'btn_add',
                    controller.detail.value == null
                        ? '收藏'
                        : getPlayCountStrFromInt(
                            controller.detail.value!.playlist.subscribedCount),
                    controller.detail.value != null),
              )),
              _line(),
              Expanded(
                  child: GestureDetector(
                onTap: () {},
                behavior: HitTestBehavior.translucent,
                child: _buildItem(
                    'detail_icn_cmt',
                    controller.detail.value == null
                        ? '评论'
                        : getPlayCountStrFromInt(
                            controller.detail.value!.playlist.commentCount),
                    true),
              )),
              _line(),
              Expanded(
                  child: GestureDetector(
                onTap: () {
                  toast('分享');
                },
                child: _buildItem(
                    'icn_share',
                    controller.detail.value == null
                        ? '分享'
                        : getPlayCountStrFromInt(
                            controller.detail.value!.playlist.shareCount),
                    controller.detail.value != null),
              )),
            ],
          )),
    );
  }

  Widget _buildItem(String iconName, String name, bool canClicked) {
    final fColor =
        Get.isDarkMode ? AppThemes.color_109 : AppThemes.headline4_color;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          ImageUtils.getImagePath(iconName),
          width: Dimens.gap_dp20,
          height: Dimens.gap_dp20,
          colorBlendMode: BlendMode.srcIn,
          color: canClicked ? fColor : fColor.withOpacity(0.5),
        ),
        SizedBox(width: Dimens.gap_dp6),
        Text(
          name,
          style: TextStyle(
              color: canClicked ? fColor : fColor.withOpacity(0.2),
              fontSize: Dimens.font_sp13),
        )
      ],
    );
  }

  Widget _line() {
    return Container(
        width: 1,
        height: Dimens.gap_dp20,
        color: Get.isDarkMode ? Colors.white38 : AppThemes.label_bg);
  }

  @override
  Size get preferredSize =>
      Size(Adapt.screenW() - Adapt.px(100), Dimens.gap_dp44);
}
