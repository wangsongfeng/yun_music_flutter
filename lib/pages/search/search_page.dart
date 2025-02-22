import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yun_music/commons/res/app_themes.dart';
import 'package:yun_music/commons/res/dimens.dart';
import 'package:yun_music/pages/search/widget/search_header_title.dart';
import 'package:yun_music/pages/search/widget/search_hotlist.dart';
import 'package:yun_music/pages/search/widget/search_hottopic.dart';
import 'package:yun_music/utils/image_utils.dart';

import '../../commons/event/index.dart';
import '../../commons/event/play_bar_event.dart';
import '../../utils/adapt.dart';
import '../../utils/approute_observer.dart';
import '../../vmusic/playing_controller.dart';
import 'search_controller.dart';
import 'widget/search_appbar.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>
    with RouteAware, TickerProviderStateMixin {
  late WSearchController controller = Get.put(WSearchController());

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
    eventBus.fire(PlayBarEvent(PlayBarShowHiddenType.bootom));
  }

  @override
  void didPop() {
    super.didPop();
    controller.focusNode.unfocus();
  }

  @override
  void initState() {
    super.initState();
    controller.selectedIndex = 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppThemes.search_page_bg,
      resizeToAvoidBottomInset: false,
      appBar: SearchAppbar(),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Listener(
      onPointerMove: (event) {
        controller.focusNode.unfocus();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Colors.transparent,
            padding:
                EdgeInsets.only(top: Dimens.gap_dp16, bottom: Dimens.gap_dp8),
            child: Row(
              children: controller.items
                  .map((e) => Expanded(child: _buildTopItem(e)))
                  .toList(),
            ),
          ),
          Expanded(
              child: SingleChildScrollView(
                  child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() {
                if (controller.recommendHots.value == null) {
                  return const SizedBox.shrink();
                } else {
                  return _buildRecommendHotHeader();
                }
              }),
              Obx(() => controller.requestEnd.value == false
                  ? const SizedBox.shrink()
                  : SizedBox(
                      height: 854,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            final data = controller.hotRecommList.value[index];
                            if (data["type"] == "hot") {
                              return SearchHotlist(
                                  title: "热搜榜", searchHotList: data["data"]);
                            } else if (data["type"] == "topic") {
                              return SearchHottopic(
                                title: "话题榜",
                                searchTopicList: data["data"],
                              );
                            } else {
                              return SizedBox.fromSize();
                            }
                          },
                          itemCount: controller.hotRecommList.value.length),
                    )),
              Obx(() {
                return SizedBox(
                  height: PlayingController.to.mediaItems.isNotEmpty
                      ? Adapt.tabbar_padding() + 20
                      : Adapt.bottomPadding(),
                );
              })
            ],
          )))
        ],
      ),
    );
  }

  //歌手，曲风，专区，识曲
  Widget _buildTopItem(SearchTopModel model) {
    return GestureDetector(
      onTap: () {},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            ImageUtils.getImagePath(model.imageName!),
            color: Colors.red,
            width: Dimens.gap_dp18,
          ),
          SizedBox(width: Dimens.gap_dp4),
          Text(
            model.text ?? "",
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black.withOpacity(0.8)),
          )
        ],
      ),
    );
  }

  //猜你喜欢 header
  Widget _buildRecommendHotHeader() {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: SearchHeaderTitle(
              imageName: 'cm8_home_header_refresh',
              text: "猜你喜欢",
            ),
          ),
          _buildRecommendHot(),
        ],
      ),
    );
  }

  //猜你喜欢 内容
  Widget _buildRecommendHot() {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: controller.recommendHots.value!.hots!
          .map((e) => GestureDetector(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.only(
                      left: 12, right: 12, bottom: 4, top: 4),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(15.0))),
                  child: Text(
                    e.first ?? "",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black.withOpacity(0.7),
                      fontFamily: W.fonts.PuHuiTiX,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ))
          .toList(),
    );
  }
}
