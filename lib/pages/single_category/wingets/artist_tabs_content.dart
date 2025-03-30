import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../commons/res/app_themes.dart';
import '../../../commons/res/dimens.dart';
import '../../../commons/skeleton/custom_underline_indicator.dart';
import '../artist_detail_controller.dart';

class ArtistTabsContent extends StatelessWidget {
  const ArtistTabsContent({super.key, required this.controller});
  final ArtistDetailController controller;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Get.theme.cardColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TabBar(
            controller: controller.tabController,
            tabs: tabsWidget(),
            overlayColor: WidgetStateProperty.all(Colors.transparent),
            labelPadding:
                EdgeInsets.only(left: Dimens.gap_dp26, right: Dimens.gap_dp26),
            isScrollable: false,
            labelStyle: TextStyle(
                fontSize: Dimens.font_sp14, fontWeight: FontWeight.w600),
            dividerColor: Colors.transparent,
            indicatorColor: AppThemes.indicator_color,
            unselectedLabelColor: context.isDarkMode
                ? const Color.fromARGB(255, 114, 114, 114)
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
            indicatorPadding:
                EdgeInsets.only(bottom: Dimens.gap_dp6, top: Dimens.gap_dp21),
            indicatorSize: TabBarIndicatorSize.label,
            enableFeedback: true,
            splashBorderRadius: BorderRadius.circular(10),
            tabAlignment: TabAlignment.center,
            onTap: (value) {},
          ),
        ],
      ),
    );
  }

  List<Widget> tabsWidget() {
    return controller.tabs!
        .map((e) => Tab(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(e.title),
                  if ((e.num ?? 0) > 0)
                    Padding(
                      padding: EdgeInsets.only(
                          top: Dimens.gap_dp2, left: Dimens.gap_dp1),
                      child: Text(
                        e.num! >= 1000 ? '999+' : e.num.toString(),
                        style: TextStyle(fontSize: Dimens.font_sp9),
                      ),
                    )
                ],
              ),
            ))
        .toList();
  }
}
