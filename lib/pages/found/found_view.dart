import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yun_music/commons/res/app_themes.dart';
import 'package:yun_music/commons/widgets/keep_alive_wrapper.dart';
import 'package:yun_music/pages/found/found_controller.dart';

import '../../commons/res/dimens.dart';
import '../../utils/adapt.dart';
import '../../vmusic/playing_controller.dart';
import '../blog_page/blog_home_page.dart';
import 'widgets/found_appbar.dart';

class FoundPage extends StatefulWidget {
  const FoundPage({super.key});

  @override
  State<FoundPage> createState() => _FoundPageState();
}

class _FoundPageState extends State<FoundPage>
    with AutomaticKeepAliveClientMixin {
  final controller = GetInstance().putOrFind(() => FoundController());

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: AppThemes.bg_color,
      extendBodyBehindAppBar: false,
      appBar: FoundAppbar(controller: controller),
      body: Obx(() {
        return Container(
          margin: EdgeInsets.only(
            bottom: PlayingController.to.mediaItems.isNotEmpty
                ? Adapt.tabbar_padding() + kToolbarHeight
                : Adapt.tabbar_padding(),
          ),
          child: TabBarView(controller: controller.tabController, children: [
            const FoundMusicPage(),
            const KeepAliveWrapper(child: BlogHomePage()),
            Container()
          ]),
        );
      }),
    );
  }
}

class FoundMusicPage extends StatefulWidget {
  const FoundMusicPage({super.key});

  @override
  State<FoundMusicPage> createState() => _FoundMusicPageState();
}

class _FoundMusicPageState extends State<FoundMusicPage>
    with AutomaticKeepAliveClientMixin {
  final controller = GetInstance().putOrFind(() => FoundController());

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: [
        Container(
          color: Colors.transparent,
          height: Dimens.gap_dp32,
          child: TabBar(
            controller: controller.musicTabController,
            tabs: [for (var i in controller.tabsConfig) Tab(text: i['label'])],
            padding: EdgeInsets.only(
                left: Dimens.gap_dp6,
                right: Dimens.gap_dp50,
                top: Dimens.gap_dp2),
            labelPadding:
                EdgeInsets.only(left: Dimens.gap_dp12, right: Dimens.gap_dp12),
            isScrollable: true,
            labelStyle: TextStyle(
                fontSize: Dimens.font_sp13, fontWeight: FontWeight.w600),
            unselectedLabelStyle: TextStyle(
                fontSize: Dimens.font_sp13, fontWeight: FontWeight.w500),
            dividerColor: Colors.transparent,
            indicatorColor: Colors.transparent,
            indicator: null,
            indicatorPadding: EdgeInsets.zero,
            unselectedLabelColor: const Color.fromARGB(255, 114, 114, 114),
            labelColor: const Color.fromARGB(255, 51, 51, 51),
            enableFeedback: true,
            dividerHeight: 0,
            splashBorderRadius: BorderRadius.circular(10),
            tabAlignment: TabAlignment.center,
            onTap: (value) {
              controller.pageController.animateToPage(value,
                  duration: const Duration(milliseconds: 100),
                  curve: Curves.easeIn);
            },
          ),
        ),
        Expanded(
            child: PageView.builder(
                physics: const ClampingScrollPhysics(),
                itemCount: controller.tabsConfig.length,
                controller: controller.pageController,
                onPageChanged: (page) {
                  controller.tabController.animateTo(page);
                },
                itemBuilder: (context, index) {
                  return Container();
                }))
      ],
    );
  }
}
