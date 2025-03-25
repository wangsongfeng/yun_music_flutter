import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yun_music/pages/found/found_controller.dart';
import 'package:yun_music/utils/common_utils.dart';

import '../../../commons/res/app_themes.dart';
import '../../../commons/res/dimens.dart';
import '../../../commons/skeleton/custom_underline_indicator.dart';
import '../../../utils/adapt.dart';
import '../../../utils/image_utils.dart';

class FoundAppbar extends StatelessWidget implements PreferredSizeWidget {
  const FoundAppbar({super.key, required this.controller});

  final FoundController controller;

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
                      overlayColor: WidgetStateProperty.all(Colors.transparent),
                      controller: controller.tabController,
                      tabs: controller.myTabs,
                      // padding: EdgeInsets.only(top: Dimens.gap_dp6),
                      labelPadding: EdgeInsets.only(
                          left: Dimens.gap_dp16, right: Dimens.gap_dp16),
                      isScrollable: false,
                      labelStyle: TextStyle(
                          fontSize: Dimens.font_sp15,
                          fontWeight: FontWeight.w600),
                      dividerColor: Colors.transparent,
                      indicatorColor: Colors.transparent,
                      unselectedLabelColor:
                          const Color.fromARGB(255, 114, 114, 114),
                      labelColor: const Color.fromARGB(254, 51, 51, 51),
                      indicator: CustomUnderlineTabIndicator(
                          width: 20,
                          borderSide: BorderSide(
                            width: 3,
                            color: AppThemes.indicator_color,
                          ),
                          strokeCap: StrokeCap.round),
                      indicatorPadding: EdgeInsets.only(
                          bottom: Dimens.gap_dp8, top: Dimens.gap_dp16),
                      indicatorSize: TabBarIndicatorSize.label,
                      enableFeedback: true,
                      tabAlignment: TabAlignment.center,
                      onTap: (value) {
                        controller.pageController.animateToPage(value,
                            duration: const Duration(milliseconds: 100),
                            curve: Curves.easeIn);
                      },
                    ),
                  ],
                ),
              ),
            ),
          )),
          GestureDetector(
            onTap: () {},
            child: Container(
              color: Colors.transparent,
              width: Get.theme.appBarTheme.toolbarHeight,
              height: Get.theme.appBarTheme.toolbarHeight,
              child: Center(
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  child: SizedBox(
                    width: Dimens.gap_dp28,
                    height: Dimens.gap_dp28,
                    child: Image.asset(
                      ImageUtils.getImagePath('home_top_bar_search'),
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

class FoundSectionTitleView extends StatelessWidget {
  const FoundSectionTitleView(
      {super.key, required this.title, this.showRightArrow = false});

  final String title;
  final bool showRightArrow;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      height: Dimens.gap_dp30,
      child: Padding(
        padding: EdgeInsets.only(left: Dimens.gap_dp16, right: Dimens.gap_dp16),
        child: Row(
          children: [
            Text(
              title,
              style: body1Style().copyWith(
                  fontSize: Dimens.font_sp14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black.withOpacity(0.8)),
            )
          ],
        ),
      ),
    );
  }
}
