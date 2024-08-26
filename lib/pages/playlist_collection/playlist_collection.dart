// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yun_music/commons/res/app_themes.dart';
import 'package:yun_music/commons/res/dimens.dart';
import 'package:yun_music/commons/skeleton/custom_underline_indicator.dart';
import 'package:yun_music/commons/widgets/music_loading.dart';
import 'package:yun_music/pages/playlist_collection/playlist_collection_controller.dart';
import 'package:yun_music/pages/playlist_collection/widget/playlist_content.dart';

import '../../commons/event/index.dart';
import '../../commons/event/play_bar_event.dart';
import '../../utils/approute_observer.dart';

class PlaylistCollectionPage extends StatefulWidget {
  const PlaylistCollectionPage({super.key});

  @override
  State<PlaylistCollectionPage> createState() => _PlaylistCollectionPageState();
}

class _PlaylistCollectionPageState extends State<PlaylistCollectionPage>
    with RouteAware {
  final PlaylistCollectionController controller =
      Get.put(PlaylistCollectionController());

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    AppRouteObserver().routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void dispose() {
    AppRouteObserver().routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPush() {
    //上一个页面push 过来viewWillappear
    super.didPush();
    print('PlaylistCollectionPage didPush');
  }

  @override
  void didPopNext() {
    //上一个页面pop回到当前页面 viewWillappear
    super.didPopNext();
    eventBus.fire(PlayBarEvent(PlayBarShowHiddenType.bootom));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            '歌单广场',
            style: TextStyle(
                fontSize: Dimens.font_sp16,
                fontWeight: FontWeight.w600,
                color: Get.isDarkMode
                    ? AppThemes.white.withOpacity(0.9)
                    : Colors.black),
          ),
        ),
        body: Obx(() {
          return controller.tags.value == null
              ? Container(
                  margin: const EdgeInsets.only(top: 100),
                  child: Center(child: MusicLoading()),
                )
              : Column(
                  children: [
                    Container(
                      color: AppThemes.white,
                      width: double.infinity,
                      height: Dimens.gap_dp40,
                      child: TabBar(
                        controller: controller.tabController,
                        tabs: [
                          for (var i in controller.tags.value!)
                            Tab(text: i.name)
                        ],
                        padding: EdgeInsets.only(
                            left: Dimens.gap_dp6,
                            top: Dimens.gap_dp6,
                            right: Dimens.gap_dp50),
                        labelPadding: EdgeInsets.only(
                            left: Dimens.gap_dp12, right: Dimens.gap_dp12),
                        isScrollable: true,
                        labelStyle: TextStyle(
                            fontSize: Dimens.font_sp14,
                            fontWeight: FontWeight.w600),
                        dividerColor: Colors.transparent,
                        indicatorColor: AppThemes.indicator_color,
                        unselectedLabelColor:
                            const Color.fromARGB(255, 114, 114, 114),
                        labelColor: const Color.fromARGB(255, 51, 51, 51),
                        indicator: CustomUnderlineTabIndicator(
                            width: 0.0,
                            borderSide: BorderSide(
                              width: 6,
                              color: AppThemes.indicator_color,
                            ),
                            strokeCap: StrokeCap.round),
                        indicatorPadding: EdgeInsets.only(
                            bottom: Dimens.gap_dp9, top: Dimens.gap_dp21),
                        indicatorSize: TabBarIndicatorSize.label,
                        enableFeedback: true,
                        splashBorderRadius: BorderRadius.circular(10),
                        tabAlignment: TabAlignment.center,
                        onTap: (value) {
                          controller.pageController.animateToPage(value,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeIn);
                        },
                      ),
                    ),
                    Expanded(
                        child: PageView.builder(
                            physics: const ClampingScrollPhysics(),
                            itemCount: controller.tags.value!.length,
                            controller: controller.pageController,
                            onPageChanged: (page) {
                              controller.tabController.animateTo(page);
                            },
                            itemBuilder: (context, index) {
                              final tagModel =
                                  controller.tags.value!.elementAt(index);
                              return PlaylistContentPage(
                                  mkey: 'list${tagModel.name}',
                                  tagModel: tagModel);
                            }))
                  ],
                );
        }));
  }
}
