import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yun_music/pages/dynamic_page/dynamic_controller.dart';
import 'package:yun_music/pages/dynamic_page/widgets/attention_page.dart';
import 'package:yun_music/utils/adapt.dart';
import '../../vmusic/playing_controller.dart';
import 'widgets/dynamic_appbar.dart';
import 'widgets/square_page.dart';

class DynamicPage extends StatefulWidget {
  const DynamicPage({super.key});

  @override
  State<DynamicPage> createState() => _DynamicPageState();
}

class _DynamicPageState extends State<DynamicPage> {
  final controller = GetInstance().putOrFind(() => DynamicController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: DynamicAppbar(controller: controller),
      extendBodyBehindAppBar: true,
      body: Obx(() {
        return Container(
          margin: EdgeInsets.only(
              bottom: PlayingController.to.mediaItems.isNotEmpty
                  ? Adapt.tabbar_padding() + kToolbarHeight
                  : Adapt.tabbar_padding(),
              top: Adapt.topPadding() + Get.theme.appBarTheme.toolbarHeight!),
          child:
              TabBarView(controller: controller.tabController, children: const [
            SquarePage(),
            AttentionPage(),
          ]),
        );
      }),
    );
  }
}
