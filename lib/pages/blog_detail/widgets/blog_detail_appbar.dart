import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yun_music/commons/values/constants.dart';
import 'package:yun_music/pages/blog_detail/blog_detail_controller.dart';

import '../../../commons/res/app_themes.dart';
import '../../../commons/res/dimens.dart';
import '../../../utils/adapt.dart';
import '../../../utils/image_utils.dart';

class BlogDetailAppbar extends StatelessWidget {
  const BlogDetailAppbar(
      {super.key, required this.appBarHeight, required this.controller});

  final double appBarHeight;
  final BlogDetailController controller;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Obx(() {
          return Container(
            width: Adapt.screenW(),
            height: appBarHeight,
            color: controller.headerBgColor.value != null
                ? controller.headerBgColor.value?.withOpacity(1.0)
                : const Color.fromRGBO(146, 150, 160, 1.0),
          );
        }),
        Positioned.fill(
            child: Container(
          padding: EdgeInsets.only(top: Adapt.topPadding()),
          height: Adapt.px(44),
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                  Get.back();
                },
                padding: EdgeInsets.only(left: Dimens.gap_dp2),
                icon: Image.asset(
                  ImageUtils.getImagePath('dij'),
                  color: AppThemes.white.withOpacity(0.9),
                  width: Dimens.gap_dp25,
                  height: Dimens.gap_dp25,
                ),
              ),
              Expanded(child: Obx(() => _buildCenterWidget())),
              IconButton(
                onPressed: () {},
                padding: EdgeInsets.only(left: Dimens.gap_dp2),
                icon: Image.asset(
                  ImageUtils.getImagePath('cm8_square_search'),
                  color: AppThemes.white.withOpacity(1.0),
                  width: Dimens.gap_dp25,
                  height: Dimens.gap_dp25,
                ),
              ),
              IconButton(
                onPressed: () {},
                padding: EdgeInsets.only(left: Dimens.gap_dp2),
                icon: Image.asset(
                  ImageUtils.getImagePath('cb'),
                  color: AppThemes.white.withOpacity(1.0),
                  width: Dimens.gap_dp25,
                  height: Dimens.gap_dp25,
                ),
              ),
            ],
          ),
        )),
      ],
    );
  }

  Widget _buildCenterWidget() {
    if (controller.titleStatus.value == PlayListTitleStatus.Normal) {
      return const SizedBox.shrink();
    } else if (controller.titleStatus.value == PlayListTitleStatus.Title) {
      return Center(
        child: Text(
          controller.detail.value?.name ?? "",
          style: const TextStyle(
              fontSize: 17,
              color: Colors.white,
              fontWeight: FontWeight.w600,
              decoration: TextDecoration.none),
        ),
      );
    } else if (controller.titleStatus.value ==
        PlayListTitleStatus.TitleAndBtn) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
              child: Text(
            controller.detail.value?.name ?? "",
            maxLines: 1,
            style: const TextStyle(
                fontSize: 17,
                color: Colors.white,
                fontWeight: FontWeight.w600,
                decoration: TextDecoration.none),
          )),
          Container(
            height: Dimens.gap_dp24,
            // margin: EdgeInsets.only(left: Dimens.gap_dp6),
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: Dimens.gap_dp6),
            decoration: BoxDecoration(
                color: AppThemes.app_main_light,
                borderRadius: BorderRadius.circular(Dimens.gap_dp12)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.add,
                  color: Colors.white,
                  size: Dimens.font_sp13,
                ),
                Text(
                  '收藏',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: Dimens.font_sp12,
                      decoration: TextDecoration.none),
                )
              ],
            ),
          )
        ],
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
