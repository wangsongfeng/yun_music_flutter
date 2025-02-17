import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yun_music/commons/res/app_themes.dart';
import 'package:yun_music/pages/search/widget/custom_textfiled.dart';

import '../../commons/event/index.dart';
import '../../commons/event/play_bar_event.dart';
import '../../utils/approute_observer.dart';
import 'search_controller.dart';

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
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.selectedIndex = 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppThemes.search_page_bg,
      appBar: AppBar(
        backgroundColor: AppThemes.search_page_bg,
        elevation: 0,
        titleSpacing: 0,
        title: CustomTextfiled(
          onSubmit: (text) {},
        ),
        actions: [
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {},
            child: Container(
              width: 44,
              height: 44,
              margin: const EdgeInsets.only(right: 10),
              alignment: Alignment.center,
              child: const Text(
                "搜索",
                style: TextStyle(fontSize: 15, color: Colors.black),
              ),
            ),
          )
        ],
      ),
      body: Container(),
    );
  }

  Widget_buildBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [],
    );
  }
}
