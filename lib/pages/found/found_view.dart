import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yun_music/commons/res/app_themes.dart';
import 'package:yun_music/commons/widgets/keep_alive_wrapper.dart';
import 'package:yun_music/pages/found/found_controller.dart';
import 'package:yun_music/pages/found/found_picked_view.dart';
import 'package:yun_music/pages/rank_list/ranklist_contrller.dart';
import 'package:yun_music/pages/rank_list/ranklist_view.dart';
import 'package:yun_music/utils/image_utils.dart';

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
  final ranklistController =
      GetInstance().putOrFind(() => RanklistContrller(), tag: "found");
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
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
        Stack(
          children: [
            Container(
              color: Colors.transparent,
              height: Dimens.gap_dp26,
              child: TabBar(
                controller: controller.musicTabController,
                tabs: [
                  for (var i in controller.tabsConfig) Tab(text: i['label'])
                ],
                padding: EdgeInsets.only(
                  left: Dimens.gap_dp12,
                  right: Dimens.gap_dp36,
                ),
                labelPadding: EdgeInsets.only(
                    left: Dimens.gap_dp14,
                    right: Dimens.gap_dp14,
                    top: Dimens.gap_dp2),
                isScrollable: true,
                labelStyle: TextStyle(
                    fontSize: Dimens.font_sp13, fontWeight: FontWeight.w600),
                unselectedLabelStyle: TextStyle(
                    fontSize: Dimens.font_sp13, fontWeight: FontWeight.w500),
                indicatorColor: Colors.transparent,
                overlayColor: WidgetStateProperty.all(Colors.transparent),
                indicator: BoxDecoration(
                    color: context.isDarkMode
                        ? const Color.fromARGB(255, 27, 28, 32)
                        : AppThemes.color_228,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(Dimens.gap_dp14)),
                indicatorPadding: EdgeInsets.only(
                    left: -Dimens.gap_dp12, right: -Dimens.gap_dp12),
                unselectedLabelColor: context.isDarkMode
                    ? const Color.fromARGB(255, 188, 188, 189)
                    : const Color.fromARGB(255, 114, 114, 114),
                labelColor: context.isDarkMode
                    ? const Color.fromARGB(255, 236, 236, 237)
                    : const Color.fromARGB(255, 51, 51, 51),
                enableFeedback: true,
                dividerHeight: 0,
                splashBorderRadius: BorderRadius.circular(Dimens.gap_dp14),
                tabAlignment: TabAlignment.center,
                onTap: (value) {
                  controller.musicPageController.animateToPage(value,
                      duration: const Duration(milliseconds: 100),
                      curve: Curves.easeIn);
                },
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                width: Dimens.gap_dp46,
                height: Dimens.gap_dp28,
                decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    boxShadow: [
                      BoxShadow(
                          color: Theme.of(context).cardColor,
                          offset: const Offset(1, 1),
                          blurRadius: 5.0),
                    ],
                    gradient: //线性渐变
                        LinearGradient(
                      colors: [
                        Theme.of(context).cardColor.withOpacity(0.1),
                        Theme.of(context).cardColor
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    )),
                child: GestureDetector(
                  child: Center(
                    child: Image.asset(
                      ImageUtils.getImagePath("cm8_profile_head_arrow_down"),
                      color: context.isDarkMode
                          ? const Color.fromARGB(255, 188, 188, 189)
                          : const Color.fromARGB(255, 114, 114, 114),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        Expanded(
            child: PageView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.tabsConfig.length,
                controller: controller.musicPageController,
                onPageChanged: (page) {
                  controller.musicTabController.animateTo(page);
                },
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return KeepAliveWrapper(
                        child: FoundPickedView(controller: controller));
                  } else if (index == 1) {
                    return const RanklistView(type: "found");
                  }
                  return Container();
                }))
      ],
    );
  }
}

class LeftEdgeClipper extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    return Rect.fromLTRB(0, 0, size.width * 0.2, size.height);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Rect> oldClipper) {
    return false;
  }
}
