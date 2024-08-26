import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yun_music/commons/widgets/appbar_page.dart';
import 'package:yun_music/pages/rank_list/ranklist_contrller.dart';

import '../../commons/event/index.dart';
import '../../commons/event/play_bar_event.dart';
import '../../commons/res/app_themes.dart';
import '../../commons/res/dimens.dart';
import '../../utils/approute_observer.dart';

class RanklistView extends StatefulWidget {
  const RanklistView({super.key});

  @override
  State<RanklistView> createState() => _RanklistViewState();
}

class _RanklistViewState extends State<RanklistView> with RouteAware {
  late RanklistContrller controller;

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
    controller = GetInstance().putOrFind(() => RanklistContrller());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.theme.cardColor,
      appBar: MusicAppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          '排行榜',
          style: TextStyle(
              fontSize: Dimens.font_sp16,
              fontWeight: FontWeight.bold,
              color: Get.isDarkMode
                  ? AppThemes.white.withOpacity(0.9)
                  : Colors.black),
        ),
        actions: [
          UnconstrainedBox(
            child: GestureDetector(
              onTap: () {},
              child: Container(
                padding:
                    const EdgeInsets.only(left: 5, right: 5, top: 2, bottom: 2),
                margin: const EdgeInsets.only(right: 15),
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(12.0)),
                    border: Border.all(
                        color: const Color(0xFF999999).withOpacity(0.5))),
                child: Text("定制首页榜单",
                    style: TextStyle(
                      color: const Color(0xFF333333),
                      fontSize: Dimens.font_sp12,
                    )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
