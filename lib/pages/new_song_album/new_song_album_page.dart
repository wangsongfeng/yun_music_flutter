import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yun_music/commons/res/app_themes.dart';
import 'package:yun_music/commons/widgets/keep_alive_wrapper.dart';
import 'package:yun_music/pages/new_song_album/new_album/new_album_page.dart';
import 'package:yun_music/pages/new_song_album/new_song/new_song_page.dart';
import 'package:yun_music/pages/new_song_album/new_song_album_controller.dart';
import 'package:yun_music/utils/image_utils.dart';

import '../../commons/event/index.dart';
import '../../commons/event/play_bar_event.dart';
import '../../commons/res/dimens.dart';
import '../../commons/skeleton/custom_underline_indicator.dart';
import '../../utils/approute_observer.dart';

class NewSongAlbumPage extends StatefulWidget {
  const NewSongAlbumPage({super.key});

  @override
  State<NewSongAlbumPage> createState() => _NewSongAlbumPageState();
}

class _NewSongAlbumPageState extends State<NewSongAlbumPage> with RouteAware {
  late NewSongAlbumController controller;

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
  void didPopNext() {
    //上一个页面pop回到当前页面 viewWillappear
    super.didPopNext();
    eventBus.fire(PlayBarEvent(PlayBarShowHiddenType.bootom));
  }

  @override
  void initState() {
    super.initState();
    controller = GetInstance().putOrFind(() => NewSongAlbumController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.theme.cardColor,
      appBar: AppBar(
        // backgroundColor: Get.theme.cardColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Image.asset(
            ImageUtils.getImagePath('dij'),
            color: Get.isDarkMode
                ? AppThemes.white.withOpacity(0.9)
                : Colors.black,
            width: Dimens.gap_dp25,
            height: Dimens.gap_dp25,
          ),
        ),
        centerTitle: true,
        title: Container(
          width: Dimens.gap_dp135,
          height: Dimens.gap_dp30,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(Dimens.gap_dp15)),
              border: Border.all(
                  color: AppThemes.app_main_light.withOpacity(0.5),
                  width: Dimens.gap_dp1)),
          child: TabBar(
            tabs: controller.myTabs,
            labelColor: Colors.white,
            unselectedLabelColor: AppThemes.app_main_light,
            controller: controller.tabController,
            isScrollable: false,
            dividerHeight: 0,
            indicator: CustomUnderlineTabIndicator(
                width: Dimens.gap_dp135 / 2.0,
                borderSide: BorderSide(
                  width: Dimens.gap_dp30,
                  color: AppThemes.indicator_color,
                ),
                strokeCap: StrokeCap.round),
          ),
        ),
      ),
      body: Stack(
        children: [
          TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              controller: controller.tabController,
              children: const [
                NewSongPage(),
                KeepAliveWrapper(child: NewAlbumPage()),
              ])
        ],
      ),
    );
  }
}
