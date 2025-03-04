import 'dart:async';

import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:yun_music/pages/home/home_controller.dart';
import 'package:yun_music/pages/mine/mine_controller.dart';
import 'package:yun_music/pages/mine/widgets/mine_header.dart';
import 'package:yun_music/pages/mine/widgets/mine_music_page.dart';
import 'package:yun_music/utils/adapt.dart';

import '../../utils/common_utils.dart';
import 'widgets/mine_appbar.dart';
import 'widgets/mine_menu_tab.dart';

class MinePage extends StatefulWidget {
  const MinePage({super.key});

  @override
  State<MinePage> createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  StreamController<bool> mainStream = Get.find<HomeController>().homeMenuStream;

  final ScrollController _extendNestCtr = ScrollController();

  final controller = GetInstance().putOrFind(() => MineController());

  late bool tabClick = false;

  void setTrans(marginTop) {
    controller.menuBarTop.value =
        controller.menuBarTop_Normal - marginTop <= controller.appbarHeight
            ? controller.appbarHeight
            : controller.menuBarTop_Normal - marginTop;
    setState(() {
      final alpha = marginTop < 60
          ? 0.0
          : marginTop / (controller.headerHeight / 2.0) >= 1
              ? 1.0
              : marginTop / (controller.headerHeight / 2.0);
      controller.appbar_alpha.value = alpha;
    });
  }

  @override
  void initState() {
    super.initState();
    mainStream.add(true);
  }

  @override
  void dispose() {
    super.dispose();
    _extendNestCtr.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return AnnotatedRegion<SystemUiOverlayStyle>(
        value: controller.appbar_alpha.value < 0.3
            ? getSystemUiOverlayStyle(isDark: false)
            : getSystemUiOverlayStyle(isDark: true),
        child: Stack(
          children: [
            NotificationListener(
                onNotification: (ScrollNotification notification) {
                  if (notification.depth == 0) {
                    setTrans(notification.metrics.pixels.toInt());
                  }

                  return true;
                },
                child: ExtendedNestedScrollView(
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  controller: _extendNestCtr,
                  onlyOneScrollInBody: true,
                  pinnedHeaderSliverHeightBuilder: () => 0,
                  headerSliverBuilder: (context1, innerBoxIsScrolled) {
                    return [
                      SliverToBoxAdapter(
                        child: MineHeader(
                          controller: controller,
                        ),
                      ),
                    ];
                  },
                  body: Builder(builder: (BuildContext context) {
                    return Column(
                      children: [
                        Container(
                            color: Colors.white,
                            height: 46,
                            child: MineMenuTab(
                              controller: controller,
                              clickCallback: (int data) {},
                            )),
                        Expanded(
                            child: TabBarView(
                                controller: controller.tabController,
                                children: [
                              const MineMusicPage(),
                              Container(height: 0),
                              Container(height: 0)
                            ]))
                      ],
                    );
                  }),
                )),

            //appbar
            Positioned(
                left: 0, top: 0, child: MineAppbar(controller: controller)),
            //
            Obx(() {
              return Positioned(
                  top: controller.appbarHeight,
                  child: AnimatedOpacity(
                    opacity:
                        controller.menuBarTop.value <= controller.appbarHeight
                            ? 1
                            : 0,
                    duration: const Duration(milliseconds: 0),
                    child: SizedBox(
                      height:
                          controller.menuBarTop.value <= controller.appbarHeight
                              ? 46.0
                              : 0,
                      width: Adapt.screenW(),
                      child: MineMenuTab(
                        controller: controller,
                        clickCallback: (int data) {},
                      ),
                    ),
                  ));
            }),
          ],
        ),
      );
    });
  }
}
