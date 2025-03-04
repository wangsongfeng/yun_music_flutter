import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:yun_music/commons/res/app_themes.dart';
import 'package:yun_music/commons/res/dimens.dart';
import 'package:yun_music/commons/widgets/network_img_layer.dart';
import 'package:yun_music/delegate/expaned_sliver_delegate.dart';
import 'package:yun_music/pages/single_category/artist_detail_controller.dart';
import 'package:yun_music/utils/adapt.dart';
import 'package:yun_music/utils/common_utils.dart';

import '../../commons/widgets/music_loading.dart';
import '../../utils/image_utils.dart';
import 'wingets/artist_detail_appbar.dart';
import 'wingets/artist_detail_header.dart';
import 'wingets/artist_tabs_content.dart';

class ArtistDetailPage extends StatefulWidget {
  const ArtistDetailPage({super.key});

  @override
  State<ArtistDetailPage> createState() => _ArtistDetailPageState();
}

class _ArtistDetailPageState extends State<ArtistDetailPage> {
  late ArtistDetailController? controller;

  final ScrollController _extendNestCtr = ScrollController();

  @override
  void initState() {
    super.initState();
    controller = Get.put(ArtistDetailController());
  }

  @override
  void dispose() {
    super.dispose();
    _extendNestCtr.dispose();
  }

  void setTrans(marginTop) {
    print(marginTop);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppThemes.bg_color,
      appBar: ArtistDetailAppbar(controller: controller!),
      extendBodyBehindAppBar: true,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: getSystemUiOverlayStyle(isDark: false),
        child: Obx(() {
          if (controller?.loading.value == true) {
            return Container(
              margin: EdgeInsets.only(
                  top: Adapt.px(Adapt.screenH() / 2.0) - Adapt.topPadding()),
              child: MusicLoading(
                axis: Axis.horizontal,
              ),
            );
          } else {
            return Stack(
              children: [_buildArtistTopBg(), _buildArtisterHeader()],
            );
          }
        }),
      ),
    );
  }

  ///header
  Widget _buildArtisterHeader() {
    return NotificationListener(
        onNotification: (ScrollNotification notification) {
          if (notification.depth == 0) {
            setTrans(notification.metrics.pixels.toInt());
          }

          return true;
        },
        child: ExtendedNestedScrollView(
          physics: const BouncingScrollPhysics(),
          controller: _extendNestCtr,
          onlyOneScrollInBody: true,
          pinnedHeaderSliverHeightBuilder: () => Dimens.gap_dp40,
          headerSliverBuilder: (context1, innerBoxIsScrolled) {
            return [
              Obx(() => SliverAppBar(
                    backgroundColor: Colors.transparent,
                    automaticallyImplyLeading: false,
                    pinned: true,
                    elevation: 0,
                    scrolledUnderElevation: 0,
                    toolbarHeight: 0,
                    collapsedHeight: 0,
                    forceElevated: true,
                    stretch: true,
                    expandedHeight: controller!.headerHeight.value +
                        controller!.animValue.value * controller!.simitHeight,
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
                  color: AppThemes.bg_color,
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
                            children: controller!.getTabBarViews()))
                  ],
                );
              }
            });
          }),
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
              top: 0,
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
