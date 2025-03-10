import 'dart:async';
import 'dart:math';

import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yun_music/commons/res/app_themes.dart';
import 'package:yun_music/pages/home/home_controller.dart';
import 'package:yun_music/pages/mine/mine_controller.dart';
import 'package:yun_music/pages/mine/widgets/mine_header.dart';
import 'package:yun_music/pages/mine/widgets/mine_music_page.dart';

import '../../delegate/expaned_sliver_delegate.dart';
import '../../utils/common_utils.dart';
import 'widgets/mine_appbar.dart';
import 'widgets/mine_menu_tab.dart';

class MinePage extends StatefulWidget {
  const MinePage({super.key});

  @override
  State<MinePage> createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> with TickerProviderStateMixin {
  StreamController<bool> mainStream = Get.find<HomeController>().homeMenuStream;

  final ScrollController _extendNestCtr = ScrollController();

  final controller = GetInstance().putOrFind(() => MineController());

  late AnimationController animationController;
  late Animation<double> anim;

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

  runAnimate() {
    //设置动画让extraPicHeight的值从当前的值渐渐回到 0
    anim = Tween(begin: controller.extraPicHeight.value, end: 0.0)
        .animate(animationController)
      ..addListener(() {
        controller.extraPicHeight.value = anim.value.toDouble();
        if (controller.extraPicHeight >= 45) {
          //同样改变图片填充类型
          controller.fitType.value = BoxFit.fitHeight;
        } else {
          controller.fitType.value = BoxFit.fitHeight;
        }
      });
    controller.prev_dy.value = 0; //同样归零
  }

  onPointerMove(result) {
    //这里我们计算一下滑动倾角，超过45度无效，角度计算通过x,y坐标计算tan函数即可
    double deltaY = result.position.dy - controller.initialDy;
    double deltaX = result.position.dx - controller.initialDx;
    double angle =
        (deltaY == 0) ? 90 : atan(deltaX.abs() / deltaY.abs()) * 180 / pi;
    if (angle < 45) {
      controller.isVerticalMove = true; // It's a valid vertical movement
      updatePicHeight(
          result.position.dy); // Custom method to handle vertical movement
    } else {
      controller.isVerticalMove =
          false; // It's not a valid vertical movement, ignore it
    }
  }

  updatePicHeight(changed) {
    if (controller.prev_dy.value == 0) {
      //如果是手指第一次点下时，我们不希望图片大小就直接发生变化，所以进行一个判定。
      controller.prev_dy.value = changed;
    }
    if ((changed - controller.prev_dy.value) >= 0) {
      controller.extraPicHeight.value += (changed -
          controller.prev_dy.value); //新的一个y值减去前一次的y值然后累加，作为加载到图片上的高度。
    }

    if (controller.extraPicHeight.value > 150) {
      controller.extraPicHeight.value = 150.0;
    }

    if (controller.extraPicHeight >= 45) {
      //当我们加载到图片上的高度大于某个值的时候，改变图片的填充方式，让它由以宽度填充变为以高度填充，从而实现了图片视角上的放大。
      controller.fitType.value = BoxFit.contain;
    } else {
      controller.fitType.value = BoxFit.fitHeight;
    }

    //更新数据
    controller.prev_dy.value = changed;
    // controller.extraPicHeight.value = controller.extraPicHeight.value;
    // controller.fitType.value = controller.fitType.value;
  }

  @override
  void initState() {
    super.initState();
    mainStream.add(true);

    //加在这里
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    anim = Tween(begin: 0.0, end: 0.0).animate(animationController);
  }

  @override
  void dispose() {
    super.dispose();
    _extendNestCtr.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppThemes.bg_color,
      extendBodyBehindAppBar: true,
      appBar: MineAppbar(controller: controller),
      body: NotificationListener(
          onNotification: (ScrollNotification notification) {
            if (notification.depth == 0) {
              setTrans(notification.metrics.pixels.toInt());
            }
            return true;
          },
          child: Listener(
            onPointerMove: (result) {
              onPointerMove(result);
            },
            onPointerUp: (_) {
              if (controller.isVerticalMove) {
                if (controller.extraPicHeight.value < 0.0) {
                  controller.extraPicHeight.value = 0.0;
                  controller.prev_dy.value = 0.0;
                  return;
                }
                runAnimate(); //动画执行
                animationController.forward(from: 0); //重置动画
              }
            },
            onPointerDown: (result) {
              controller.initialDy = result.position.dy;
              controller.initialDx = result.position.dx;
            },
            child: ExtendedNestedScrollView(
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              controller: _extendNestCtr,
              onlyOneScrollInBody: true,
              pinnedHeaderSliverHeightBuilder: () => 0,
              headerSliverBuilder: (context1, innerBoxIsScrolled) {
                return [
                  Obx(() => SliverAppBar(
                        automaticallyImplyLeading: false,
                        pinned: true,
                        floating: false,
                        elevation: 1,
                        scrolledUnderElevation: 0,
                        toolbarHeight: 0,
                        collapsedHeight: 0,
                        systemOverlayStyle: controller.appbar_alpha.value < 0.3
                            ? getSystemUiOverlayStyle(isDark: false)
                            : getSystemUiOverlayStyle(isDark: true),
                        expandedHeight: controller.headerHeight.value +
                            controller.extraPicHeight.value,
                        flexibleSpace: FlexibleSpaceBar(
                          collapseMode: CollapseMode.pin,
                          stretchModes: const [
                            StretchMode.zoomBackground,
                          ],
                          background: LayoutBuilder(
                              builder: (context2, boxconstraints) {
                            return MineHeader(
                              controller: controller,
                            );
                          }),
                        ),
                      )),
                  SliverPersistentHeader(
                      pinned: true,
                      delegate: MySliverDelegate(
                          maxHeight: 46,
                          minHeight: 46,
                          child: Container(
                              color: Colors.white,
                              height: 46,
                              child: MineMenuTab(
                                controller: controller,
                                clickCallback: (int data) {},
                              ))))
                ];
              },
              body: Builder(builder: (BuildContext context) {
                return Column(
                  children: [
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
            ),
          )),
    );
  }
}
