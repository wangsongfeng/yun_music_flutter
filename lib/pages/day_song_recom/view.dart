import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yun_music/commons/event/index.dart';
import 'package:yun_music/commons/event/play_bar_event.dart';
import 'package:yun_music/pages/day_song_recom/controller.dart';
import 'package:yun_music/pages/day_song_recom/widgets/day_recom.dart';

import '../../utils/approute_observer.dart';

class RecomSongDayPage extends StatefulWidget {
  const RecomSongDayPage({super.key});

  @override
  State<RecomSongDayPage> createState() => _RecomSongDayPageState();
}

class _RecomSongDayPageState extends State<RecomSongDayPage> with RouteAware {
  late DaySongRecmController controller = Get.put(DaySongRecmController());

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
    print('day_song_recom didPush');
  }

  @override
  void didPopNext() {
    //上一个页面pop回到当前页面 viewWillappear
    super.didPopNext();
    eventBus.fire(PlayBarEvent(PlayBarShowHiddenType.bootom));
    print('day_song_recom didPopNext');
  }

  @override
  void didPushNext() {
    super.didPushNext();
    print('day_song_recom didPushNext');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.theme.cardColor,
      body: Stack(
        children: [
          Positioned.fill(child: RecomDailyPage()),
        ],
      ),
    );
  }
}
