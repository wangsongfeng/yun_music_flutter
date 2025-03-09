import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:yun_music/commons/res/app_themes.dart';
import 'package:yun_music/commons/res/dimens.dart';
import 'package:yun_music/delegate/general_sliver_delegate.dart';
import 'package:yun_music/pages/playlist_detail/delegate/playlist_header_delegate.dart';
import 'package:yun_music/pages/playlist_detail/widgets/playlist_detail_playall.dart';
import 'package:yun_music/pages/playlist_detail/widgets/playlist_fab_count.dart';
import 'package:yun_music/pages/playlist_detail/widgets/playlist_song_content.dart';
import 'package:yun_music/pages/playlist_detail/widgets/sliver_fab_main.dart';
import 'package:yun_music/utils/adapt.dart';
import 'package:yun_music/utils/common_utils.dart';

import '../../commons/event/index.dart';
import '../../commons/event/play_bar_event.dart';
import '../../utils/approute_observer.dart';
import '../../vmusic/playing_controller.dart';
import 'playlist_detail_controller.dart';
import 'widgets/playlist_detail_appbar.dart';

class PlaylistDetailPage extends StatefulWidget {
  const PlaylistDetailPage({super.key});

  @override
  State<PlaylistDetailPage> createState() => _PlaylistDetailPageState();
}

class _PlaylistDetailPageState extends State<PlaylistDetailPage>
    with RouteAware, TickerProviderStateMixin {
  int timeMill = DateTime.now().millisecondsSinceEpoch;
  late PlaylistDetailController controller;
  double appbarHeight = 0.0;

  late AnimationController animationController;
  late Animation<double> anim;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    AppRouteObserver().routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void dispose() {
    AppRouteObserver().routeObserver.unsubscribe(this);
    animationController.dispose();
    super.dispose();
  }

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
  void initState() {
    super.initState();
    controller = GetInstance()
        .putOrFind(() => PlaylistDetailController(), tag: timeMill.toString());
    //加在这里
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    anim = Tween(begin: 0.0, end: 0.0).animate(animationController);
  }

  runAnimate() {
    //设置动画让extraPicHeight的值从当前的值渐渐回到 0
    setState(() {
      anim = Tween(begin: controller.extraPicHeight, end: 0.0)
          .animate(animationController)
        ..addListener(() {
          if (controller.extraPicHeight >= 45) {
            //同样改变图片填充类型
            controller.fitType = BoxFit.fitHeight;
          } else {
            controller.fitType = BoxFit.fitWidth;
          }
          setState(() {
            controller.extraPicHeight = anim.value;
            controller.fitType = controller.fitType;
          });
        });
      controller.prev_dy = 0; //同样归零
    });
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
    if (controller.prev_dy == 0) {
      //如果是手指第一次点下时，我们不希望图片大小就直接发生变化，所以进行一个判定。
      controller.prev_dy = changed;
    }
    if (controller.extraPicHeight >= 45) {
      //当我们加载到图片上的高度大于某个值的时候，改变图片的填充方式，让它由以宽度填充变为以高度填充，从而实现了图片视角上的放大。
      controller.fitType = BoxFit.fitHeight;
    } else {
      controller.fitType = BoxFit.fitWidth;
    }
    if ((changed - controller.prev_dy) >= 0) {
      controller.extraPicHeight +=
          changed - controller.prev_dy; //新的一个y值减去前一次的y值然后累加，作为加载到图片上的高度。
    }

    if (controller.extraPicHeight > 240) {
      controller.extraPicHeight = 240;
    }

    setState(() {
      //更新数据
      controller.prev_dy = changed;
      controller.extraPicHeight = controller.extraPicHeight;
      controller.fitType = controller.fitType;
    });
  }

  @override
  Widget build(BuildContext context) {
    appbarHeight = Adapt.topPadding() + Adapt.px(44);
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(Adapt.px(44)),
            child: PlaylistDetailAppbar(
              key: controller.appBarKey,
              appBarHeight: appbarHeight,
              controller: controller,
            )),
        extendBodyBehindAppBar: true,
        backgroundColor: AppThemes.card_color,
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: getSystemUiOverlayStyle(isDark: false),
          child: Stack(
            children: [
              Positioned.fill(
                child: Obx(() {
                  return Padding(
                    padding: EdgeInsets.only(
                        bottom: PlayingController.to.mediaItems.isNotEmpty
                            ? Adapt.tabbar_padding()
                            : 0),
                    child: _buildContent(context),
                  );
                }),
              )
            ],
          ),
        ));
  }

  //滚动内容
  Widget _buildContent(BuildContext context) {
    return Listener(
      onPointerMove: (result) {
        //手指的移动时
        // updatePicHeight(result.position.dy); //自定义方法，图片的放大由它完成。

        onPointerMove(result);
      },
      onPointerUp: (_) {
        if (controller.isVerticalMove) {
          if (controller.extraPicHeight < 0) {
            controller.extraPicHeight = 0;
            controller.prev_dy = 0;
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
      child: SliverFabMain(
        topScalingEdge: appbarHeight,
        expandedHeight: controller.expandedHeight + controller.extraPicHeight,
        floadingPosition:
            FloatingPosition(left: Adapt.px(50), right: Adapt.px(50), top: -6),
        floatingWidget: PlaylistFabCountPage(controller: controller),
        slivers: [
          //头部内容
          SliverPersistentHeader(
              pinned: true,
              floating: false,
              delegate: PlaylistHeaderDelegate(
                  controller: controller,
                  expandHeight: controller.expandedHeight,
                  minHeight: appbarHeight,
                  extraPicHeight: controller.extraPicHeight,
                  fitType: controller.fitType)),

          //间距
          SliverPersistentHeader(
            delegate: GeneralSliverDelegate(
                child: PreferredSize(
                    preferredSize: Size.fromHeight(Dimens.gap_dp32),
                    child: const SizedBox.shrink())),
          ),

          //全部播放吸顶
          SliverPersistentHeader(
              pinned: true,
              delegate: GeneralSliverDelegate(
                  child: PlaylistDetailPlayall(
                controller: controller,
                playAllTap: () {
                  PlayingController.to.playByIndex(0, "queueTitle",
                      mediaItem: controller.mediaSongs.value);
                  toPlayingPage();
                },
              ))),
          //列表
          Obx(() {
            return controller.detail.value?.playlist.specialType == 200
                ? SliverToBoxAdapter(child: Container())
                : PlaylistSongContent(
                    controller: controller,
                    songs: controller.songs.value,
                  );
          })
        ],
        controller: controller,
      ),
    );
  }
}
