import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:yun_music/commons/res/dimens.dart';
import 'package:yun_music/commons/values/server.dart';
import 'package:yun_music/pages/moments/moments_controller.dart';
import 'package:yun_music/utils/image_utils.dart';
import 'package:yun_music/vmusic/widget/comment_button.dart';

import '../../commons/event/index.dart';
import '../../commons/event/play_bar_event.dart';
import '../../utils/approute_observer.dart';
import 'widgets/sliver_flexble_header.dart';

class MomentsPage extends StatefulWidget {
  const MomentsPage({super.key});

  @override
  State<MomentsPage> createState() => _MomentsPageState();
}

class _MomentsPageState extends State<MomentsPage> with RouteAware {
  final controller = GetInstance().putOrFind(() => MomentsController());

  final ScrollController _extendNestCtr = ScrollController();

  @override
  void initState() {
    super.initState();
  }

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
    eventBus.fire(PlayBarEvent(PlayBarShowHiddenType.hidden));
  }

  int trans = 0;

  final double headerImgHeight = 360.0;

  double scallTop = 360 * (1.0 / 3);

  void setTrans(marginTop) {
    setState(() {
      trans = marginTop;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: trans > scallTop
          ? ((trans - scallTop) / 40 > 1
              ? SystemUiOverlayStyle.dark
              : SystemUiOverlayStyle.dark)
          : SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            NotificationListener(
                onNotification: (ScrollNotification notification) {
                  setTrans(notification.metrics.pixels.toInt());
                  return true;
                },
                child: ExtendedNestedScrollView(
                  physics: const BouncingScrollPhysics(),
                  controller: _extendNestCtr,
                  onlyOneScrollInBody: true,
                  pinnedHeaderSliverHeightBuilder: () =>
                      50 + MediaQuery.of(context).padding.top,
                  headerSliverBuilder: (context1, innerBoxIsScrolled) {
                    return [
                      _buildHeaderWidget(),
                    ];
                  },
                  body: Builder(builder: (BuildContext context) {
                    return Stack(
                      children: [
                        Column(
                          children: [
                            Expanded(
                                child: TabBarView(
                                    controller: controller.tabController,
                                    children: [
                                  Container(
                                    height: 2000,
                                    color: Colors.red,
                                    child: CommentButton(
                                      countType:
                                          PlayingOperationBarCountType.message,
                                      onTaps: () {
                                        logger.d("message");
                                      },
                                    ),
                                  ),
                                  Container(height: 2000)
                                ]))
                          ],
                        ),
                      ],
                    );
                  }),
                )),
            _buildOpacityWidget(),
            _buildBackAndPubWidget(),
          ],
        ),
      ),
    );
  }

  //heaerView
  Widget _buildHeaderWidget() {
    return SliverFlexibleHeader(
      visibleExtent: (headerImgHeight + 36.0),
      builder: (context, availableHeight, direction) {
        return LayoutBuilder(builder: (context, cons) {
          return Stack(
            children: [
              Container(
                padding: const EdgeInsets.only(bottom: 20),
                child: Image.asset(
                  ImageUtils.getImagePath('moment_header_bg'),
                  height: availableHeight,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                left: 0,
                bottom: 36,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 48,
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: [
                        0.0,
                        1.0
                      ], //[渐变起始点, 渐变结束点]
                          //渐变颜色[始点颜色, 结束颜色]
                          colors: [
                        Color.fromRGBO(15, 15, 15, 0),
                        Color.fromRGBO(15, 15, 15, 0.5)
                      ])),
                ),
              ),
              Positioned(
                  right: Dimens.gap_dp16,
                  bottom: 0,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: Container(
                          padding: const EdgeInsets.only(top: 16),
                          child: const Text("hodor",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20,
                                  color: Colors.white)),
                        ),
                      ),
                      Container(
                          width: 72,
                          height: 72,
                          //设置了 decoration 就不能设置color，两者只能存在一个
                          decoration: const BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black26,
                                    offset: Offset(0, 0.0),
                                    //阴影y轴偏移量
                                    blurRadius: 2,
                                    //阴影模糊程度
                                    spreadRadius: 1 //阴影扩散程度
                                    )
                              ],
                              image: DecorationImage(
                                  image: AssetImage(
                                      "assets/images/mine_avatar.png")),
                              //设置图片
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6)))),
                    ],
                  )),
            ],
          );
        });
      },
    );
  }

  //返回按钮，发布按钮
  Widget _buildOpacityWidget() {
    return Positioned(
        top: 0,
        child: AnimatedOpacity(
            opacity: trans > scallTop
                ? ((trans - scallTop) / 40 > 1 ? 1 : (trans - scallTop) / 40)
                : 0,
            duration: const Duration(milliseconds: 400),
            child: ClipRRect(
              child: Container(
                padding:
                    EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                height: 50 + MediaQuery.of(context).padding.top,
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: Colors.white,

                  ///背景透明
                ),
                child: const Center(
                  child: Text(
                    '朋友圈',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            )));
  }

  Widget _buildBackAndPubWidget() {
    return Positioned(
        left: 0,
        right: 0,
        top: (MediaQuery.of(context).padding.top),
        child: Container(
          alignment: Alignment.center,
          height: 50,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Image.asset(
                    trans > scallTop
                        ? ((trans - scallTop) / 40 > 0.8
                            ? ImageUtils.getImagePath('icon_back_black')
                            : ImageUtils.getImagePath('icon_back_white'))
                        : ImageUtils.getImagePath('icon_back_white'),
                    width: 24,
                  )),
              const Expanded(child: SizedBox.shrink()),
              IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Image.asset(
                    trans > scallTop
                        ? ((trans - scallTop) / 40 > 0.8
                            ? ImageUtils.getImagePath('xiangji_black')
                            : ImageUtils.getImagePath('xiangji_white'))
                        : ImageUtils.getImagePath('xiangji_white'),
                    width: 24,
                  )),
            ],
          ),
        ));
  }
}
