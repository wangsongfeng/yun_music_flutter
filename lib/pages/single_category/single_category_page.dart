// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:yun_music/commons/res/app_routes.dart';
import 'package:yun_music/commons/widgets/user_avatar_page.dart';
import 'package:yun_music/pages/single_category/models/single_list_wrap.dart';
import 'package:yun_music/pages/single_category/single_category_controller.dart';
import 'package:yun_music/pages/single_category/wingets/single_cat_header.dart';
import 'package:yun_music/utils/adapt.dart';
import 'package:yun_music/utils/image_utils.dart';

import '../../commons/event/index.dart';
import '../../commons/event/play_bar_event.dart';
import '../../commons/res/app_themes.dart';
import '../../commons/res/dimens.dart';
import '../../commons/widgets/footer_loading.dart';
import '../../delegate/expaned_sliver_delegate.dart';
import '../../utils/common_utils.dart';
import '../../vmusic/playing_controller.dart';

class SingleCategoryPage extends StatefulWidget {
  const SingleCategoryPage({super.key});

  @override
  State<SingleCategoryPage> createState() => _SingleCategoryPageState();
}

class _SingleCategoryPageState extends State<SingleCategoryPage>
    with RouteAware, TickerProviderStateMixin {
  late SingleCategoryController controller =
      Get.put(SingleCategoryController());

  final ScrollController scrollController = ScrollController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context) as PageRoute);
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
    scrollController.dispose();
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
  }

  void setTrans(marginTop) {
    if (marginTop > 5) {
      if (controller.headerH.value == 48.0) {
        return;
      }
      controller.headerH.value = 48.0;
      controller.headerAlpha.value = 0.0;
      controller.sortAlpha.value = 1.0;
    } else {
      if (controller.headerH.value == 78.0) {
        return;
      }
      controller.headerH.value = 78.0;
      controller.headerAlpha.value = 1.0;
      controller.sortAlpha.value = 0.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          '歌手分类',
          style: TextStyle(
              fontSize: Dimens.font_sp16,
              fontWeight: FontWeight.w600,
              fontFamily: W.fonts.PuHuiTiX,
              color: Get.isDarkMode
                  ? AppThemes.white.withOpacity(0.9)
                  : Colors.black),
        ),
      ),
      body: NotificationListener(
        onNotification: (ScrollNotification notification) {
          setTrans(notification.metrics.pixels.toInt());
          return true;
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleCatHeader(controller: controller),
            Expanded(
                child: SmartRefresher(
              controller: controller.refreshController,
              footer: const FooterLoading(),
              onLoading: () async {
                controller.loadMore();
              },
              enablePullUp: true,
              enablePullDown: false,
              child: CustomScrollView(
                controller: scrollController,
                slivers: [
                  SliverToBoxAdapter(child: SizedBox.fromSize()),
                  SliverPersistentHeader(
                      pinned: true,
                      delegate: MySliverDelegate(
                          maxHeight: Dimens.gap_dp24,
                          minHeight: Dimens.gap_dp24,
                          child: Container(
                            color: AppThemes.color_250,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  '热门歌手',
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: AppThemes.body1_txt_color
                                          .withOpacity(0.8)),
                                ),
                              ),
                            ),
                          ))),
                  Obx(() => SliverList.builder(
                        itemBuilder: (context, index) {
                          final item = controller.artistsList[index];
                          return _buildSinglesItem(item!);
                        },
                        itemCount: controller.artistsList.length,
                      )),
                  Obx(() {
                    return SliverToBoxAdapter(
                      child: SizedBox(
                        height: PlayingController.to.mediaItems.isNotEmpty
                            ? Adapt.bottomPadding()
                            : Adapt.bottomPadding(),
                      ),
                    );
                  })
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }

  Widget _buildSinglesItem(Singles single) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(RouterPath.Artist_Detail,
            arguments: {"artist_id": single.id});
      },
      child: Container(
        color: Colors.white,
        height: 72,
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              UserAvatarPage(avatar: single.picUrl!, size: 52),
              const SizedBox(width: 8),
              Text(
                single.name!,
                style: const TextStyle(fontSize: 15, color: Colors.black),
              ),
              Expanded(
                  child: Text(
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                single.alias!.isNotEmpty
                    ? "(${single.alias?.first ?? ""})"
                    : "",
                style: TextStyle(
                    fontSize: 15,
                    color: AppThemes.body1_txt_color.withOpacity(0.9)),
              )),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: () {},
                child: Container(
                  width: 68,
                  height: 28,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(14)),
                    border: Border.all(color: Colors.red, width: 1.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                          ImageUtils.getImagePath('cm4_list_btn_icn_add'),
                          width: 16),
                      const SizedBox(width: 2),
                      const Text('关注',
                          style: TextStyle(fontSize: 13, color: Colors.red))
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
