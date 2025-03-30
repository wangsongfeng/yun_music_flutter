import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yun_music/pages/mine/mine_controller.dart';

import '../../../commons/res/app_themes.dart';
import '../../../commons/res/dimens.dart';
import '../../../commons/skeleton/custom_underline_indicator.dart';
import '../../../commons/values/function.dart';

class MineMenuTab extends StatelessWidget {
  const MineMenuTab(
      {super.key, required this.controller, required this.clickCallback});

  final MineController controller;

  final ParamSingleCallback<int> clickCallback;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
            bottom: 2,
            child: Container(
              color: context.isDarkMode ? Colors.transparent : Colors.black,
            )),
        Positioned.fill(child: Obx(() {
          return Container(
              decoration: BoxDecoration(
                color: Get.theme.cardColor,
                borderRadius: BorderRadius.only(
                    topLeft:
                        controller.menuBarTop.value - controller.appbarHeight ==
                                0
                            ? const Radius.circular(0)
                            : const Radius.circular(16),
                    topRight:
                        controller.menuBarTop.value - controller.appbarHeight ==
                                0
                            ? const Radius.circular(0)
                            : const Radius.circular(16)),
              ),
              child: Align(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TabBar(
                      controller: controller.tabController,
                      tabs: controller.myTabs,
                      overlayColor: WidgetStateProperty.all(Colors.transparent),
                      labelPadding: const EdgeInsets.only(left: 40, right: 40),
                      isScrollable: false,
                      labelStyle: TextStyle(
                          fontSize: Dimens.font_sp14,
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
                        clickCallback.call(value);
                      },
                    ),
                  ],
                ),
              ));
        }))
      ],
    );
  }
}
