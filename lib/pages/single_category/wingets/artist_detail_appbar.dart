import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yun_music/pages/single_category/artist_detail_controller.dart';
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
        color: Colors.white.withOpacity(controller.appbar_alpha.value),
        padding: EdgeInsets.only(left: 6, right: 6, top: Adapt.topPadding()),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              color: Colors.transparent,
              margin: const EdgeInsets.only(left: 8),
              width: 28,
              height: 28,
              child: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Image.asset(
                  ImageUtils.getImagePath('cm8_nav_icn_back'),
                  width: 24,
                  color: Colors.white,
                ),
              ),
            ),
            const Expanded(child: SizedBox.shrink()),
            Container(
              margin: const EdgeInsets.only(right: 8),
              width: 24,
              height: 24,
              child: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Image.asset(
                  ImageUtils.getImagePath('cm6_nav_icn_more'),
                  width: 24,
                  color: Colors.white,
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
