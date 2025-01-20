import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yun_music/commons/res/dimens.dart';
import 'package:yun_music/pages/mine/widgets/mine_music_controller.dart';

import '../../../commons/res/app_themes.dart';
import 'mine_music_list_page.dart';

class MineMusicPage extends StatelessWidget {
  const MineMusicPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = GetInstance().putOrFind(() => MineMusicController());
    return Column(
      children: [
        Container(
          color: Colors.transparent,
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
            indicatorColor: AppThemes.indicator_color,
            indicatorWeight: 0.0,
            indicator: const UnderlineTabIndicator(),
            unselectedLabelColor: const Color.fromARGB(180, 114, 114, 114),
            labelColor: const Color.fromARGB(255, 51, 51, 51),
            enableFeedback: true,
            splashBorderRadius: BorderRadius.circular(10),
            tabAlignment: TabAlignment.center,
            onTap: (value) {
              // controller.pageController.animateToPage(value,
              //     duration: const Duration(milliseconds: 100),
              //     curve: Curves.easeIn);
            },
          ),
        ),
        Expanded(
            child: TabBarView(controller: controller.tabController, children: [
          const MineMusicListPage(),
          Container(),
          Container(),
        ]))
      ],
    );
  }
}
