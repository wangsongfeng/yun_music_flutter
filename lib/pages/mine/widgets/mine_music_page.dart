import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yun_music/commons/res/dimens.dart';
import 'package:yun_music/pages/mine/widgets/mine_music_controller.dart';
import '../../../commons/skeleton/custom_underline_indicator.dart';
import 'mine_music_list_page.dart';

class MineMusicPage extends StatelessWidget {
  const MineMusicPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = GetInstance().putOrFind(() => MineMusicController());
    return Column(
      children: [
        Container(
          color: Get.theme.cardColor,
          width: double.infinity,
          height: Dimens.gap_dp24,
          child: TabBar(
            controller: controller.tabController,
            tabs: controller.myTabs,
            padding:
                EdgeInsets.only(left: Dimens.gap_dp6, right: Dimens.gap_dp6),
            labelPadding:
                EdgeInsets.only(left: Dimens.gap_dp10, right: Dimens.gap_dp10),
            isScrollable: false,
            labelStyle: TextStyle(
                fontSize: Dimens.font_sp12, fontWeight: FontWeight.w600),
            dividerColor: Colors.transparent,
            indicatorColor: Colors.transparent,
            overlayColor: WidgetStateProperty.all(Colors.transparent),
            indicatorWeight: 0.0,
            indicator: const CustomUnderlineTabIndicator(
                width: 20,
                borderSide: BorderSide(
                  width: 4,
                  color: Colors.transparent,
                ),
                strokeCap: StrokeCap.round),
            unselectedLabelColor: context.isDarkMode
                ? const Color.fromARGB(255, 188, 188, 189)
                : const Color.fromARGB(255, 114, 114, 114),
            labelColor: context.isDarkMode
                ? const Color.fromARGB(255, 236, 236, 237)
                : const Color.fromARGB(255, 51, 51, 51),
            enableFeedback: true,
            splashBorderRadius: BorderRadius.circular(10),
            tabAlignment: TabAlignment.center,
            onTap: (value) {},
          ),
        ),
        Expanded(
            child: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                controller: controller.tabController,
                children: [
              const MineMusicListPage(),
              Container(),
              Container(),
            ]))
      ],
    );
  }
}
