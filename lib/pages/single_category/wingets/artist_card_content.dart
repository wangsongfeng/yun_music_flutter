import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yun_music/commons/res/app_themes.dart';
import 'package:yun_music/pages/single_category/wingets/artist_follow.dart';

import '../../../commons/res/dimens.dart';
import '../../../commons/widgets/music_loading.dart';
import '../../../commons/widgets/network_img_layer.dart';
import '../../../utils/adapt.dart';
import '../../../utils/common_utils.dart';
import '../../../utils/image_utils.dart';
import '../artist_detail_controller.dart';
import '../models/single_list_wrap.dart';

class ArtistCardContent extends StatelessWidget {
  const ArtistCardContent({super.key, required this.controller});
  final ArtistDetailController controller;
  @override
  Widget build(BuildContext context) {
    final BgColor = Get.isDarkMode
        ? const Color.fromRGBO(40, 40, 48, 1)
        : Get.theme.cardColor;
    return Obx(() {
      return Container(
        width: Adapt.screenW() - 32,
        height: controller.cardHeight.value +
            controller.animValue.value * controller.simitHeight,
        margin: const EdgeInsets.only(left: 16, right: 16, bottom: 12),
        padding: EdgeInsets.only(
            top: controller.getAvatarUrl()!.isEmpty
                ? Dimens.gap_dp16
                : Dimens.gap_dp36),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [BgColor.withOpacity(0.99), BgColor, BgColor]),
            boxShadow: [
              BoxShadow(
                  color: Get.isDarkMode
                      ? Colors.transparent
                      : Get.theme.shadowColor,
                  offset: const Offset(0, 5),
                  blurRadius: 12.0)
            ],
            borderRadius: const BorderRadius.all(Radius.circular(12))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //姓名
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  controller.artistDetail.value?.artist?.name ?? "",
                  style: TextStyle(
                      fontSize: Dimens.font_sp17,
                      color: Get.isDarkMode
                          ? Colors.white
                          : Colors.black.withOpacity(0.8),
                      fontFamily: W.fonts.IconFonts,
                      fontWeight: FontWeight.w600),
                ),
                if (GetUtils.isNullOrBlank(
                        controller.artistDetail.value?.identify?.imageUrl) ==
                    false)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(width: Dimens.gap_dp8),
                      Padding(
                        padding: EdgeInsets.only(top: Dimens.gap_dp4),
                        child: NetworkImgLayer(
                          width: Dimens.gap_dp16,
                          height: Dimens.gap_dp16,
                          src:
                              controller.artistDetail.value!.identify?.imageUrl,
                        ),
                      )
                    ],
                  )
              ],
            ),

            const SizedBox(height: 0),

            //副姓名
            Text(
              controller.getAliasName()!,
              style: body1Style().copyWith(
                  color: context.isDarkMode
                      ? AppThemes.dark_subtitle_text
                      : AppThemes.subtitle_text,
                  fontSize: Dimens.font_sp11),
            ),
            const SizedBox(height: 4),
            //粉丝，
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "399万",
                  style: body1Style().copyWith(
                      color: context.isDarkMode
                          ? AppThemes.dark_body1_txt_color.withOpacity(0.6)
                          : AppThemes.body1_txt_color.withOpacity(0.6),
                      fontSize: Dimens.font_sp11,
                      fontWeight: FontWeight.w600,
                      fontFamily: W.fonts.IconFonts),
                ),
                const SizedBox(width: 4),
                Text(
                  "粉丝",
                  style: body1Style().copyWith(
                      color: context.isDarkMode
                          ? AppThemes.dark_subtitle_text
                          : AppThemes.subtitle_text,
                      fontSize: Dimens.font_sp11),
                ),
              ],
            ),
            const SizedBox(height: 6),
            if (controller.artistDesc()!.isNotEmpty)
              Text(
                controller.artistDesc()!,
                style: body1Style().copyWith(
                    color: context.isDarkMode
                        ? AppThemes.dark_subtitle_text
                        : AppThemes.subtitle_text,
                    fontSize: Dimens.font_sp11),
              ),
            const SizedBox(height: 12),

            //关注按钮
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: Dimens.gap_dp72,
                  height: Dimens.gap_dp28,
                  child: const ArtistFollow(Key("value"),
                      id: "id",
                      isFollowed: false,
                      isSolidWidget: true,
                      isSinger: true),
                ),
                GestureDetector(
                  onTap: () {
                    controller.startAnim();
                  },
                  behavior: HitTestBehavior.translucent,
                  child: Container(
                    width: Dimens.gap_dp28,
                    height: Dimens.gap_dp28,
                    margin: EdgeInsets.only(left: Dimens.gap_dp6),
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.all(Radius.circular(Dimens.gap_dp14)),
                      border: Border.all(
                        color: Get.theme.dividerColor.withOpacity(0.6),
                      ),
                    ),
                    padding: EdgeInsets.all(Dimens.gap_dp5),
                    child: Obx(() => Transform.rotate(
                          angle:
                              (pi / 2) * (1 - 2 * controller.animValue.value),
                          child: Image.asset(
                            ImageUtils.getImagePath('icon_more'),
                            color: Get.textTheme.titleMedium?.color ??
                                Colors.black,
                            width: controller.artistDetail.value == null
                                ? Dimens.gap_dp12
                                : Dimens.gap_dp12,
                          ),
                        )),
                  ),
                )
              ],
            ),

            //相似歌手
            Obx(() {
              return ClipPath(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  heightFactor: controller.animValue.value,
                  child: Container(
                    width: double.infinity,
                    height: controller.simitHeight,
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(top: Dimens.gap_dp15),
                    child: Opacity(
                      opacity: controller.animValue.value,
                      child: simitListView(controller.artistsList),
                    ),
                  ),
                ),
              );
            })
          ],
        ),
      );
    });
  }

  ///相似歌手
  Widget simitListView(List<Singles>? items) {
    if (GetUtils.isNullOrBlank(items) == true) {
      return Center(
        child: MusicLoading(),
      );
    }
    return ListView.builder(
      padding: EdgeInsets.only(left: Dimens.gap_dp6, right: Dimens.gap_dp6),
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        final item = items.elementAt(index);
        return Container(
          height: controller.simitHeight,
          width: Dimens.gap_dp90,
          margin: EdgeInsets.only(left: Dimens.gap_dp6, right: Dimens.gap_dp6),
          alignment: Alignment.topCenter,
          decoration: BoxDecoration(
            color: Get.isDarkMode ? Colors.black45 : AppThemes.color_242,
            borderRadius: BorderRadius.all(
              Radius.circular(Dimens.gap_dp10),
            ),
          ),
          child: Column(
            children: [
              SizedBox(height: Dimens.gap_dp8),
              //头像
              ClipOval(
                child: CachedNetworkImage(
                  width: Dimens.gap_dp45,
                  height: Dimens.gap_dp45,
                  fit: BoxFit.cover,
                  imageUrl: ImageUtils.getImageUrlFromSize(
                      item.picUrl, Size(Dimens.gap_dp50, Dimens.gap_dp50)),
                  placeholder: (context, url) {
                    return Container(
                      color: AppThemes.load_image_placeholder(),
                    );
                  },
                ),
              ),
              SizedBox(height: Dimens.gap_dp6),
              //name
              Padding(
                padding: EdgeInsets.only(
                    left: Dimens.gap_dp10, right: Dimens.gap_dp10),
                child: Text(
                  item.name ?? "",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: headline1Style().copyWith(fontSize: Dimens.font_sp12),
                ),
              ),
              SizedBox(height: Dimens.gap_dp2),
              //fansCount
              Text(
                '99万粉丝',
                style: captionStyle().copyWith(fontSize: Dimens.font_sp11),
              ),
              SizedBox(height: Dimens.gap_dp6),
              //follow btn
              SizedBox(
                width: Dimens.gap_dp56,
                height: Dimens.gap_dp24,
                child: ArtistFollow(Key(item.accountId.toString()),
                    id: item.id.toString(),
                    isFollowed: item.followed ?? false,
                    isSolidWidget: false,
                    isSinger: true),
              )
            ],
          ),
        );
      },
      itemCount: items!.length,
    );
  }
}
