import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yun_music/commons/res/app_themes.dart';
import 'package:yun_music/commons/res/dimens.dart';
import 'package:yun_music/pages/single_category/artist_detail_controller.dart';
import 'package:yun_music/pages/single_category/wingets/artist_follow.dart';
import 'package:yun_music/utils/adapt.dart';

import '../../../utils/image_utils.dart';

class ArtistDetailAppbar extends StatelessWidget
    implements PreferredSizeWidget {
  const ArtistDetailAppbar({super.key, required this.controller});

  final ArtistDetailController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        color: AppThemes.bg_color.withOpacity(controller.appbar_alpha.value),
        padding: EdgeInsets.only(left: 6, right: 6, top: Adapt.topPadding()),
        height: Dimens.gap_dp44 + Adapt.topPadding(),
        child: Row(
          children: [
            Container(
              color: Colors.transparent,
              margin: const EdgeInsets.only(left: 10),
              width: 28,
              height: 28,
              child: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Image.asset(
                  ImageUtils.getImagePath('cm8_nav_icn_back'),
                  width: 24,
                  color: controller.appbarMenuTop.value
                      ? Colors.black
                      : Colors.white,
                ),
              ),
            ),
            Opacity(
                opacity: controller.appbar_alpha.value,
                child: Container(
                  margin: const EdgeInsets.only(left: 4),
                  child: Text(
                    controller.artistDetail.value?.artist?.name ?? "",
                    style: TextStyle(
                        fontSize: Dimens.font_sp16,
                        color: Colors.black.withOpacity(0.8),
                        fontFamily: W.fonts.IconFonts,
                        fontWeight: FontWeight.w600),
                  ),
                )),
            const Expanded(child: SizedBox.shrink()),
            Opacity(
              opacity: controller.follow_show.value == true ? 1 : 0,
              child: SizedBox(
                width: Dimens.gap_dp66,
                height: Dimens.gap_dp26,
                child: const ArtistFollow(Key("value"),
                    id: "id",
                    isFollowed: false,
                    isSolidWidget: true,
                    isSinger: true),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 10, right: 10),
              width: 24,
              height: 24,
              child: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Image.asset(
                  ImageUtils.getImagePath('cm6_nav_icn_more'),
                  width: 24,
                  color: controller.appbarMenuTop.value
                      ? Colors.black
                      : Colors.white,
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(Get.theme.appBarTheme.toolbarHeight ?? 56);
}
