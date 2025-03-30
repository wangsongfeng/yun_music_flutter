import 'dart:math';

import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yun_music/commons/event/play_bar_event.dart';
import 'package:yun_music/commons/res/app_themes.dart';
import 'package:yun_music/commons/res/dimens.dart';
import 'package:yun_music/commons/widgets/network_img_layer.dart';
import 'package:yun_music/delegate/expaned_sliver_delegate.dart';
import 'package:yun_music/pages/single_category/artist_detail_controller.dart';
import 'package:yun_music/utils/adapt.dart';
import 'package:yun_music/utils/approute_observer.dart';
import 'package:yun_music/utils/common_utils.dart';

import '../../commons/event/index.dart';
import '../../vmusic/comment/player/widgets/music_playbar_overlay.dart';
import '../../commons/widgets/keep_alive_wrapper.dart';
import '../../commons/widgets/music_loading.dart';
import '../../utils/image_utils.dart';
import 'arrist_detail_list_controller.dart';
import 'artist_song_page.dart';
import 'wingets/artist_detail_appbar.dart';
import 'wingets/artist_detail_header.dart';
import 'wingets/artist_tabs_content.dart';

class ArtistDetailPage extends StatefulWidget {
  const ArtistDetailPage({super.key});

  @override
  State<ArtistDetailPage> createState() => _ArtistDetailPageState();
}

class _ArtistDetailPageState extends State<ArtistDetailPage>
    with RouteAware, TickerProviderStateMixin {
  late ArtistDetailController? controller;

  late AnimationController animationController;
  late Animation<double> anim;

  late ArristDetailListController? arristDetailListController;

  @override
  void initState() {
    super.initState();
    final artistid = Get.arguments["artist_id"].toString();
    controller = Get.put(ArtistDetailController(), tag: artistid);
    arristDetailListController =
        Get.put(ArristDetailListController(), tag: artistid);
    //加在这里
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    anim = Tween(begin: 0.0, end: 0.0).animate(animationController);
  }

  @override
  void dispose() {
    super.dispose();

    AppRouteObserver().routeObserver.unsubscribe(this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    AppRouteObserver().routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPush() {
    //上一个页面push 过来viewWillappear
    super.didPush();
  }

  @override
  void didPop() {
    super.didPop();
    CustomAlertDialogShow.instance.hide();
  }

  @override
  void didPushNext() {
    super.didPushNext();
    CustomAlertDialogShow.instance.hide();
  }

  @override
  void didPopNext() {
    //上一个页面pop回到当前页面 viewWillappear
    super.didPopNext();
    eventBus.fire(PlayBarEvent(PlayBarShowHiddenType.bootom));
  }

  List<Widget> getTabBarViews() {
    final widgets = List<Widget>.empty(growable: true);
    for (var element in controller!.tabs!) {
      switch (element.type) {
        case SingerTabType.homePage:
          widgets.add(KeepAliveWrapper(child: Container()));
          break;
        case SingerTabType.songPage:
          widgets.add(KeepAliveWrapper(
              child: ArtistSongPage(
            artistId: controller!.artistid,
            controller: arristDetailListController!,
            artistDetailController: controller!,
          )));
          break;
        case SingerTabType.albumPage:
          widgets.add(KeepAliveWrapper(child: Container()));
          break;
        case SingerTabType.mvPage:
          widgets.add(KeepAliveWrapper(child: Container()));
          break;
        case SingerTabType.evenPage:
          widgets.add(KeepAliveWrapper(child: Container()));
          break;
      }
    }
    return widgets;
  }

  void setTrans(marginTop) {
    if (marginTop <= 0) {
      controller?.margin_top.value = 0;
    } else {
      controller?.margin_top.value = marginTop;
    }
    final appbarTop =
        controller!.headerHeight.value - controller!.cardHeight.value;
    if (marginTop > appbarTop / 1.4) {
      if (controller?.appbarMenuTop.value == false) {
        controller?.appbarMenuTop.value = true;
      }
    } else {
      if (controller?.appbarMenuTop.value == true) {
        controller?.appbarMenuTop.value = false;
      }
    }

    if (marginTop >= appbarTop) {
      if (controller?.appbar_alpha.value == 0) {
        controller?.appbar_alpha.value = 1;
      }
    } else {
      if (controller?.appbar_alpha.value == 1) {
        controller?.appbar_alpha.value = 0;
      }
    }

    if (marginTop >=
        controller!.headerHeight.value - Dimens.gap_dp44 - Adapt.topPadding()) {
      if (controller?.follow_show.value == false) {
        controller?.follow_show.value = true;
      }
    } else {
      if (controller?.follow_show.value == true) {
        controller?.follow_show.value = false;
      }
    }
  }

  runAnimate() {
    //设置动画让extraPicHeight的值从当前的值渐渐回到 0
    anim = Tween(begin: controller?.extraPicHeight.value, end: 0.0)
        .animate(animationController)
      ..addListener(() {
        controller?.extraPicHeight.value = anim.value.toDouble();
      });
    controller?.prev_dy.value = 0; //同样归零
  }

  onPointerMove(result) {
    //这里我们计算一下滑动倾角，超过45度无效，角度计算通过x,y坐标计算tan函数即可
    double deltaY = result.position.dy - controller?.initialDy;
    double deltaX = result.position.dx - controller?.initialDx;
    double angle =
        (deltaY == 0) ? 90 : atan(deltaX.abs() / deltaY.abs()) * 180 / pi;
    if (angle < 45) {
      controller?.isVerticalMove = true; // It's a valid vertical movement
      updatePicHeight(
          result.position.dy); // Custom method to handle vertical movement
    } else {
      controller?.isVerticalMove =
          false; // It's not a valid vertical movement, ignore it
    }
  }

  updatePicHeight(changed) {
    if (controller!.margin_top.value > 0) {
      return;
    }
    if (controller?.prev_dy.value == 0) {
      //如果是手指第一次点下时，我们不希望图片大小就直接发生变化，所以进行一个判定。
      controller?.prev_dy.value = changed;
    }
    if ((changed - controller?.prev_dy.value) >= 0) {
      controller?.extraPicHeight.value += (changed -
          controller?.prev_dy.value); //新的一个y值减去前一次的y值然后累加，作为加载到图片上的高度。
    }

    if (controller!.extraPicHeight.value > 180) {
      controller?.extraPicHeight.value = 180.0;
    }

    //更新数据
    controller?.prev_dy.value = changed;
    // controller?.extraPicHeight.value = controller!.extraPicHeight.value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Get.theme.cardColor,
        appBar: ArtistDetailAppbar(controller: controller!),
        extendBodyBehindAppBar: true,
        body: Obx(() {
          if (controller?.loading.value == true) {
            return Container(
              margin: EdgeInsets.only(
                  top: Adapt.px(Adapt.screenH() -
                          Adapt.tabbar_padding() -
                          Adapt.bottomPadding()) /
                      2.0),
              child: MusicLoading(
                axis: Axis.horizontal,
              ),
            );
          } else {
            return Stack(
              children: [_buildArtistTopBg(), _buildArtisterHeader()],
            );
          }
        }));
  }

  ///header
  Widget _buildArtisterHeader() {
    return NotificationListener(
        onNotification: (ScrollNotification notification) {
          if (notification.depth == 0) {
            setTrans(notification.metrics.pixels.toDouble());
          }

          return true;
        },
        child: Listener(
          onPointerMove: (result) {
            //手指的移动时
            // updatePicHeight(result.position.dy); //自定义方法，图片的放大由它完成。

            onPointerMove(result);
          },
          onPointerUp: (_) {
            if (controller!.isVerticalMove) {
              if (controller!.extraPicHeight.value < 0.0) {
                controller?.extraPicHeight.value = 0.0;
                controller?.prev_dy.value = 0.0;
                return;
              }
              runAnimate(); //动画执行
              animationController.forward(from: 0); //重置动画
            }
          },
          onPointerDown: (result) {
            controller?.initialDy = result.position.dy;
            controller?.initialDx = result.position.dx;
          },
          child: ExtendedNestedScrollView(
            physics: const BouncingScrollPhysics(),
            controller: controller?.extendNestCtr,
            onlyOneScrollInBody: true,
            pinnedHeaderSliverHeightBuilder: () => Dimens.gap_dp40,
            headerSliverBuilder: (context1, innerBoxIsScrolled) {
              return [
                Obx(() => SliverAppBar(
                      backgroundColor: controller?.follow_show.value == true
                          ? AppThemes.bg_color
                          : Colors.transparent,
                      automaticallyImplyLeading: false,
                      pinned: true,
                      floating: false,
                      elevation: 1,
                      scrolledUnderElevation: 0,
                      toolbarHeight: 0,
                      collapsedHeight: 0,
                      systemOverlayStyle:
                          controller!.appbarMenuTop.value == false
                              ? getSystemUiOverlayStyle(isDark: false)
                              : context1.isDarkMode
                                  ? getSystemUiOverlayStyle(isDark: false)
                                  : getSystemUiOverlayStyle(isDark: true),
                      expandedHeight: controller!.headerHeight.value +
                          controller!.animValue.value *
                              controller!.simitHeight +
                          controller!.extraPicHeight.value,
                      flexibleSpace: FlexibleSpaceBar(
                        collapseMode: CollapseMode.pin,
                        stretchModes: const [
                          StretchMode.zoomBackground,
                          // StretchMode.blurBackground,
                        ],
                        // collapseMode: CollapseMode.pin,
                        background:
                            LayoutBuilder(builder: (context2, boxconstraints) {
                          return ArtistDetailHeader(controller: controller!);
                        }),
                      ),
                    )),
                // SliverToBoxAdapter(
                //     child: ArtistDetailHeader(controller: controller!)),
                SliverPersistentHeader(
                    pinned: true,
                    delegate: MySliverDelegate(
                        maxHeight: Dimens.gap_dp40,
                        minHeight: Dimens.gap_dp40,
                        child: Obx(() {
                          if (controller?.artistDetail.value == null) {
                            return Container();
                          } else {
                            return ArtistTabsContent(controller: controller!);
                          }
                        })))
              ];
            },
            body: Builder(builder: (context) {
              return Obx(() {
                if (controller?.artistDetail.value == null) {
                  return Container(
                    color: Get.theme.cardColor,
                    width: double.infinity,
                    height: double.infinity,
                  );
                } else {
                  return Column(
                    children: [
                      const SizedBox.shrink(),
                      Expanded(
                          child: TabBarView(
                              controller: controller!.tabController,
                              children: getTabBarViews()))
                    ],
                  );
                }
              });
            }),
          ),
        ));
  }

  ///歌手背景图片
  Widget _buildArtistTopBg() {
    return Obx(() {
      return Stack(
        children: [
          //背景颜色
          Container(
            width: double.infinity,
            height: double.infinity,
            color: controller?.headerBgColor.value ?? AppThemes.color_250,
          ),

          Positioned(
              left: 0,
              top: -controller!.margin_top.value,
              child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                      Get.theme.cardColor,
                      Get.theme.scaffoldBackgroundColor
                    ])),
                width: Adapt.screenW(),
                height: controller?.artistBgheight,
                child: NetworkImgLayer(
                  width: double.infinity,
                  height: controller!.artistBgheight,
                  src: ImageUtils.getImageUrlFromSize(
                      controller?.getArtistHeaderBgUrl(),
                      Size(Adapt.screenW(), controller!.artistBgheight)),
                  imageBuilder: (context, provider) {
                    controller?.coverImage.value = provider;
                    return Image(
                      image: provider,
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ))
        ],
      );
    });
  }
}
