import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yun_music/commons/res/app_routes.dart';
import 'package:yun_music/commons/res/dimens.dart';
import 'package:yun_music/pages/dynamic_page/dynamic_controller.dart';

import '../../../commons/res/app_themes.dart';
import '../../../commons/skeleton/custom_underline_indicator.dart';
import '../../../utils/adapt.dart';
import '../../../utils/image_utils.dart';

class DynamicAppbar extends StatelessWidget implements PreferredSizeWidget {
  const DynamicAppbar({super.key, required this.controller});

  final DynamicController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: Adapt.topPadding()),
      child: Row(
        children: [
          Expanded(
              child: Container(
            color: Colors.transparent,
            padding:
                EdgeInsets.only(left: Get.theme.appBarTheme.toolbarHeight!),
            child: Center(
              child: Align(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TabBar(
                      controller: controller.tabController,
                      tabs: controller.myTabs,
                      overlayColor: WidgetStateProperty.all(Colors.transparent),
                      labelPadding: const EdgeInsets.only(left: 20, right: 20),
                      isScrollable: false,
                      labelStyle: TextStyle(
                          fontSize: Dimens.font_sp15,
                          fontWeight: FontWeight.w600),
                      dividerColor: Colors.transparent,
                      indicatorColor: AppThemes.indicator_color,
                      unselectedLabelColor: context.isDarkMode
                          ? const Color.fromARGB(255, 188, 188, 189)
                          : const Color.fromARGB(255, 114, 114, 114),
                      labelColor: context.isDarkMode
                          ? const Color.fromARGB(255, 236, 236, 237)
                          : const Color.fromARGB(255, 51, 51, 51),
                      indicator: CustomUnderlineTabIndicator(
                          width: 20,
                          borderSide: BorderSide(
                            width: 4,
                            color: AppThemes.indicator_color,
                          ),
                          strokeCap: StrokeCap.round),
                      indicatorPadding: EdgeInsets.only(
                          bottom: Dimens.gap_dp6, top: Dimens.gap_dp21),
                      indicatorSize: TabBarIndicatorSize.label,
                      enableFeedback: true,
                      splashBorderRadius: BorderRadius.circular(10),
                      tabAlignment: TabAlignment.center,
                      onTap: (value) {
                        // clickCallback.call(value);
                      },
                    ),
                  ],
                ),
              ),
            ),
          )),
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
