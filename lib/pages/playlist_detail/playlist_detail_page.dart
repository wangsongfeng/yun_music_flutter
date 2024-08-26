import 'package:flutter/material.dart';
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

import '../../commons/event/index.dart';
import '../../commons/event/play_bar_event.dart';
import '../../utils/approute_observer.dart';
import 'playlist_detail_controller.dart';
import 'widgets/playlist_detail_appbar.dart';

class PlaylistDetailPage extends StatefulWidget {
  const PlaylistDetailPage({super.key});

  @override
  State<PlaylistDetailPage> createState() => _PlaylistDetailPageState();
}

class _PlaylistDetailPageState extends State<PlaylistDetailPage>
    with RouteAware {
  int timeMill = DateTime.now().millisecondsSinceEpoch;
  late PlaylistDetailController controller;
  double appbarHeight = 0.0;

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
    print('PlaylistDetailPage didPush');
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
  }

  @override
  Widget build(BuildContext context) {
    appbarHeight = context.mediaQueryPadding.top + Adapt.px(44);
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
        body: Stack(
          children: [
            // Positioned(
            //     left: 0,
            //     right: 0,
            //     top: 0,
            //     child: Obx(() => Container(
            //           height: controller.expandedHeight - 20,
            //           color: controller.headerBgColor.value != null
            //               ? controller.headerBgColor.value?.withOpacity(1.0)
            //               : const Color.fromRGBO(146, 150, 160, 1.0),
            //         ))),
            Positioned.fill(
              child: Padding(
                padding: EdgeInsets.only(
                    bottom: Dimens.gap_dp49 + Adapt.bottomPadding()),
                child: _buildContent(context),
              ),
            )
          ],
        ));
  }

  //滚动内容
  Widget _buildContent(BuildContext context) {
    return SliverFabMain(
      topScalingEdge: appbarHeight,
      expandedHeight: controller.expandedHeight,
      floadingPosition:
          FloatingPosition(left: Adapt.px(50), right: Adapt.px(50), top: -6),
      floatingWidget: PlaylistFabCountPage(controller: controller),
      slivers: [
        SliverToBoxAdapter(
          child: Container(),
        ),
        //头部内容
        SliverPersistentHeader(
            pinned: true,
            floating: false,
            delegate: PlaylistHeaderDelegate(
                controller: controller,
                expandHeight: controller.expandedHeight,
                minHeight: appbarHeight)),

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
    );
  }
}
