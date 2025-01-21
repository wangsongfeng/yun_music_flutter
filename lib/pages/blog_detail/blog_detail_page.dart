import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yun_music/commons/res/dimens.dart';
import 'package:yun_music/commons/values/constants.dart';
import 'package:yun_music/delegate/general_sliver_delegate.dart';
import 'package:yun_music/pages/blog_detail/blog_detail_controller.dart';
import 'package:yun_music/pages/blog_detail/widgets/blog_detail_sticky.dart';
import 'package:yun_music/utils/adapt.dart';

import '../../commons/event/index.dart';
import '../../commons/event/play_bar_event.dart';
import '../../commons/res/app_themes.dart';
import '../../utils/approute_observer.dart';
import '../../vmusic/playing_controller.dart';
import 'blog_detail_songs_page.dart';
import 'widgets/blog_detail_appbar.dart';
import 'widgets/blog_detail_header.dart';

import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';

class BlogDetailPage extends StatefulWidget {
  const BlogDetailPage({super.key});

  @override
  State<BlogDetailPage> createState() => _BlogDetailPageState();
}

class _BlogDetailPageState extends State<BlogDetailPage> with RouteAware {
  final controller = GetInstance().putOrFind(() => BlogDetailController());

  final ScrollController _extendNestCtr = ScrollController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    AppRouteObserver().routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void dispose() {
    AppRouteObserver().routeObserver.unsubscribe(this);
    super.dispose();
    _extendNestCtr.dispose();
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

    _extendNestCtr.addListener(() {
      final double offset = _extendNestCtr.position.pixels;

      if (offset >= controller.headerHeight.value - controller.appBarHeight) {
        if (controller.scoll_stickBar.value == false) {
          controller.scoll_stickBar.value = true;
        }
      } else {
        if (controller.scoll_stickBar.value == true) {
          controller.scoll_stickBar.value = false;
        }
      }

      if (offset >
              (controller.headerHeight.value - controller.appBarHeight) / 3 &&
          offset <
              (controller.headerHeight.value - controller.appBarHeight) / 1.5) {
        if (controller.titleStatus.value != PlayListTitleStatus.Title) {
          controller.titleStatus.value = PlayListTitleStatus.Title;
        }
      } else if (offset >
          (controller.headerHeight.value - controller.appBarHeight) / 1.5) {
        if (controller.titleStatus.value != PlayListTitleStatus.TitleAndBtn) {
          controller.titleStatus.value = PlayListTitleStatus.TitleAndBtn;
        }
      } else {
        if (controller.titleStatus.value != PlayListTitleStatus.Normal) {
          controller.titleStatus.value = PlayListTitleStatus.Normal;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(0),
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
          ),
          backgroundColor: AppThemes.card_color,
          body: Obx(() {
            return Padding(
              padding: EdgeInsets.only(
                  bottom: PlayingController.to.mediaItems.isNotEmpty
                      ? Adapt.tabbar_padding()
                      : 0),
              child: ExtendedNestedScrollView(
                  // physics: const BouncingScrollPhysics(),
                  controller: _extendNestCtr,
                  onlyOneScrollInBody: true,
                  pinnedHeaderSliverHeightBuilder: () => Dimens.gap_dp40,
                  headerSliverBuilder: (context1, innerBoxIsScrolled) {
                    return [
                      Obx(
                        () => SliverAppBar(
                          automaticallyImplyLeading: false,
                          pinned: true,
                          elevation: 0,
                          scrolledUnderElevation: 0,
                          toolbarHeight: Dimens.gap_dp40,
                          collapsedHeight: Dimens.gap_dp40,
                          forceElevated: false,
                          stretch: true,
                          expandedHeight: controller.headerHeight.value,
                          flexibleSpace: FlexibleSpaceBar(
                            collapseMode: CollapseMode.pin,
                            stretchModes: const [
                              StretchMode.zoomBackground,
                              StretchMode.blurBackground,
                            ],
                            // collapseMode: CollapseMode.pin,
                            background: LayoutBuilder(
                                builder: (context2, boxconstraints) {
                              return BlogDetailHeader(controller: controller);
                            }),
                          ),
                        ),
                      ),
                      SliverPersistentHeader(
                          pinned: true,
                          delegate: GeneralSliverDelegate(
                              child: PreferredSize(
                                  preferredSize:
                                      Size.fromHeight(Dimens.gap_dp40),
                                  child: Container(
                                      color: controller.scoll_stickBar.value ==
                                              true
                                          ? Colors.white
                                          : Colors.white,
                                      child: BlogDetailSticky(
                                          controller: controller)))))
                    ];
                  },
                  body: Builder(builder: (BuildContext context) {
                    return Column(
                      children: [
                        Expanded(
                            child: TabBarView(
                                controller: controller.tabController,
                                children: [
                              BlogDetailSongsPage(),
                              Container(height: 2000)
                            ]))
                      ],
                    );
                  })),
            );
          }),
        ),
        BlogDetailAppbar(
            appBarHeight: Adapt.px(44) + Adapt.topPadding(),
            controller: controller),
      ],
    );
  }
}
