import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../commons/res/app_themes.dart';
import '../../../commons/res/dimens.dart';
import '../../../commons/skeleton/custom_underline_indicator.dart';
import '../../../utils/adapt.dart';
import '../../../utils/image_utils.dart';
import '../comment_controller.dart';

class CommentAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CommentAppbar({super.key, required this.controller});

  final MCommentController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      alignment: Alignment.center,
      padding: EdgeInsets.only(
          top: Adapt.topPadding(), left: Dimens.gap_dp4, right: Dimens.gap_dp6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () async {
              FocusManager.instance.primaryFocus?.unfocus();
              Get.back();
            },
            icon: Image.asset(
              ImageUtils.getImagePath('dij'),
              color: Colors.black,
              width: Dimens.gap_dp25,
              height: Dimens.gap_dp25,
            ),
          ),
          Expanded(
              child: Container(
            color: Colors.transparent,
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
                          fontWeight: FontWeight.bold),
                      dividerColor: Colors.transparent,
                      indicatorColor: AppThemes.indicator_color,
                      unselectedLabelColor:
                          const Color.fromARGB(255, 114, 114, 114),
                      labelColor: const Color.fromARGB(255, 51, 51, 51),
                      indicator: CustomUnderlineTabIndicator(
                          width: 20,
                          borderSide: BorderSide(
                            width: 3.0,
                            color: AppThemes.indicator_color,
                          ),
                          strokeCap: StrokeCap.round),
                      indicatorPadding: EdgeInsets.only(
                          bottom: Dimens.gap_dp8, top: Dimens.gap_dp21),
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
          IconButton(
            onPressed: () async {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            icon: Image.asset(
              ImageUtils.getImagePath('cm7_nav_icn_share'),
              color: Colors.black,
              width: Dimens.gap_dp25,
              height: Dimens.gap_dp25,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(Get.theme.appBarTheme.toolbarHeight!);
}
