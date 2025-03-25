import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:yun_music/commons/res/app_themes.dart';
import 'package:yun_music/commons/widgets/keep_alive_wrapper.dart';
import 'package:yun_music/pages/search/search_result_controller.dart';
import 'package:yun_music/pages/search_all/search_all_page.dart';

import '../../commons/event/index.dart';
import '../../commons/event/play_bar_event.dart';
import '../../commons/res/dimens.dart';
import '../../commons/skeleton/custom_underline_indicator.dart';
import '../../utils/common_utils.dart';
import 'search_controller.dart';
import 'widget/search_appbar.dart';

class SearchResultPage extends StatefulWidget {
  const SearchResultPage({super.key});

  @override
  State<SearchResultPage> createState() => _SearchResultPageState();
}

class _SearchResultPageState extends State<SearchResultPage>
    with RouteAware, TickerProviderStateMixin {
  late WSearchController controller =
      Get.put(WSearchController(), tag: "result");

  late SearchResultController resultController =
      Get.put(SearchResultController());

  @override
  void initState() {
    super.initState();
    controller.appBarType = SearchAppBarType.Result;
    resultController.searchKey = Get.arguments["searchKey"];
    controller.textEditingController.text = resultController.searchKey;
    resultController.setTabController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context) as PageRoute);
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPopNext() {
    //上一个页面pop回到当前页面 viewWillappear
    super.didPopNext();
    eventBus.fire(PlayBarEvent(PlayBarShowHiddenType.bootom));

    ///这里延迟0.1秒执行，是为了确保已经push到其他页面了，当前页面路由已修改，再去修改导航栏状态栏，否则可能会被覆盖
    Future.delayed(const Duration(milliseconds: 100)).then((value) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppThemes.search_page_bg,
      resizeToAvoidBottomInset: false,
      appBar: SearchAppbar(
        type: SearchAppBarType.Result,
        controller: controller,
        onSubmit: (searchKey) {},
        onDelegate: () {
          Get.back(canPop: false);
        },
      ),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: getSystemUiOverlayStyle(isDark: true),
        child: Column(
          children: [
            Container(
              color: Colors.transparent,
              width: double.infinity,
              height: Dimens.gap_dp42,
              child: TabBar(
                controller: resultController.tabController,
                tabs: [for (var i in resultController.tabList) Tab(text: i)],
                padding: EdgeInsets.only(
                    left: Dimens.gap_dp6,
                    top: Dimens.gap_dp6,
                    right: Dimens.gap_dp6),
                labelPadding: EdgeInsets.only(
                    left: Dimens.gap_dp12, right: Dimens.gap_dp12),
                isScrollable: true,
                labelStyle: TextStyle(
                    fontSize: Dimens.font_sp13, fontWeight: FontWeight.w600),
                dividerColor: Colors.transparent,
                indicatorColor: AppThemes.indicator_color,
                unselectedLabelColor: const Color.fromARGB(255, 114, 114, 114),
                overlayColor: WidgetStateProperty.all(Colors.transparent),
                labelColor: const Color.fromARGB(255, 51, 51, 51),
                indicator: CustomUnderlineTabIndicator(
                    width: 20,
                    borderSide: BorderSide(
                      width: 3,
                      color: AppThemes.indicator_color,
                    ),
                    strokeCap: StrokeCap.round),
                indicatorPadding: EdgeInsets.only(
                    bottom: Dimens.gap_dp6, top: Dimens.gap_dp21),
                indicatorSize: TabBarIndicatorSize.label,
                enableFeedback: true,
                splashBorderRadius: BorderRadius.circular(10),
                tabAlignment: TabAlignment.center,
                onTap: (value) {
                  resultController.pageController.animateToPage(value,
                      duration: const Duration(milliseconds: 100),
                      curve: Curves.easeIn);
                },
              ),
            ),
            Expanded(
                child: PageView.builder(
                    physics: const ClampingScrollPhysics(),
                    itemCount: resultController.tabList.length,
                    controller: resultController.pageController,
                    onPageChanged: (page) {
                      resultController.tabController.animateTo(page);
                    },
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return KeepAliveWrapper(
                          child: SearchAllPage(
                              searchKey: resultController.searchKey),
                        );
                      }
                      return Container();
                    }))
          ],
        ),
      ),
    );
  }
}
