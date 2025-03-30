// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yun_music/commons/widgets/appbar_page.dart';
import 'package:yun_music/commons/widgets/music_loading.dart';
import 'package:yun_music/pages/rank_list/ranklist_contrller.dart';

import '../../commons/event/index.dart';
import '../../commons/event/play_bar_event.dart';
import '../../commons/res/app_themes.dart';
import '../../commons/res/dimens.dart';
import '../../utils/adapt.dart';
import '../../utils/approute_observer.dart';
import '../../utils/common_utils.dart';
import '../../vmusic/playing_controller.dart';
import 'windgets/rank_global_page.dart';
import 'windgets/rank_official_page.dart';
import 'windgets/rank_recom_page.dart';

class RanklistView extends StatefulWidget {
  const RanklistView({super.key, this.type = "normal"});

  final String type;

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
  }

  @override
  void didPopNext() {
    //上一个页面pop回到当前页面 viewWillappear
    super.didPopNext();
    if (widget.type == "normal") {
      eventBus.fire(PlayBarEvent(PlayBarShowHiddenType.bootom));
    }
  }

  @override
  void initState() {
    super.initState();
    controller =
        GetInstance().putOrFind(() => RanklistContrller(), tag: widget.type);
    if (widget.type == "normal") {
      eventBus.fire(PlayBarEvent(PlayBarShowHiddenType.bootom));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.type == "normal") {
      return Scaffold(
        backgroundColor: Get.isDarkMode
            ? AppThemes.dark_card_color
            : AppThemes.rank_list_bg_color,
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
          systemUiOverlayStyle: context.isDarkMode
              ? getSystemUiOverlayStyle(isDark: false)
              : getSystemUiOverlayStyle(isDark: true),
          actions: [
            UnconstrainedBox(
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.only(
                      left: 5, right: 5, top: 2, bottom: 2),
                  margin: const EdgeInsets.only(right: 15),
                  decoration: BoxDecoration(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(12.0)),
                      border: Border.all(
                          color: const Color(0xFF999999).withOpacity(0.5))),
                  child: Text("定制首页榜单",
                      style: TextStyle(
                        color: context.isDarkMode
                            ? AppThemes.textColor999
                            : const Color(0xFF333333),
                        fontSize: Dimens.font_sp12,
                      )),
                ),
              ),
            ),
          ],
        ),
        body: _buildContent(),
      );
    } else {
      return _buildContent();
    }
  }

  Widget _buildContent() {
    return Obx(() => (controller.items.value == null)
        ? MusicLoading().paddingOnly(top: Dimens.gap_dp100)
        : Padding(
            padding: EdgeInsets.only(
                bottom: PlayingController.to.mediaItems.isNotEmpty
                    ? widget.type == "normal"
                        ? Adapt.tabbar_padding()
                        : 0
                    : 0),
            child: CustomScrollView(
              // physics: const ClampingScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: Container(),
                ),
                SliverToBoxAdapter(
                  child: RankRecomPage(contrller: controller),
                ),
                SliverToBoxAdapter(
                  child: RankOfficialPage(
                      contrller: controller,
                      items: controller.items.value!
                          .where((element) => element.tracks.isNotEmpty)
                          .toList()),
                ),
                SliverToBoxAdapter(
                  child: Column(
                    children: ranksection(),
                  ),
                )
              ],
            ),
          ));
  }

  List<Widget> ranksection() {
    final list = <Widget>[];

    for (var i = 0; i < controller.rankSections.value!.length; i++) {
      final model = controller.rankSections.value!.elementAt(i);
      list.add(RankGlobalPage(
        contrller: controller,
        section: model,
        key: Key(model.title ?? ""),
      ));
    }

    return list;
  }
}
