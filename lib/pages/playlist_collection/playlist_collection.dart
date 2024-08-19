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

class PlaylistCollectionPage extends GetView<PlaylistCollectionController>
    with RouteAware {
  PlaylistCollectionPage({super.key});

  late PlaylistCollectionController playlistCollectionController =
      Get.put(PlaylistCollectionController());

  @override
  void didPush() {
    //上一个页面push 过来viewWillappear
    super.didPush();
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
                        isScrollable: true,
                        labelStyle: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600),
                        dividerColor: Colors.transparent,
                        indicatorColor: const Color.fromRGBO(253, 105, 155, 1),
                        unselectedLabelColor:
                            const Color.fromRGBO(95, 95, 95, 0.8),
                        labelColor: const Color.fromRGBO(253, 105, 155, 1),
                        indicator: const CustomUnderlineTabIndicator(
                            width: 0.0,
                            borderSide: BorderSide(
                              width: 3,
                              color: Color.fromRGBO(253, 105, 155, 1),
                            ),
                            strokeCap: StrokeCap.round),
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
                              print(tagModel);
                              return PlaylistContentPage(
                                  mkey: Key('list$index'), tagModel: tagModel);
                            }))
                  ],
                );
        }));
  }
}
