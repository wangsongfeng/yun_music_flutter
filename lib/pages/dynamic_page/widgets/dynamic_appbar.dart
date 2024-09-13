import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yun_music/commons/res/app_routes.dart';

import '../../../commons/res/app_themes.dart';
import '../../../utils/adapt.dart';
import '../../../utils/image_utils.dart';

class DynamicAppbar extends StatelessWidget implements PreferredSizeWidget {
  const DynamicAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: Adapt.topPadding()),
      child: Row(
        children: [
          Expanded(child: Container()),
          GestureDetector(
            onTap: () {
              Get.toNamed(RouterPath.Moments_Page);
            },
            child: Container(
              color: Colors.transparent,
              width: Get.theme.appBarTheme.toolbarHeight,
              height: Get.theme.appBarTheme.toolbarHeight,
              child: Center(
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  child: Container(
                    color: AppThemes.app_main,
                    child: SizedBox(
                      width: 30,
                      height: 30,
                      child: Image.asset(
                        ImageUtils.getImagePath('cm4_applewatch_add_btn'),
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(Get.theme.appBarTheme.toolbarHeight!);
}
