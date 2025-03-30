import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yun_music/pages/blog_page/widgets/blog_home_appbar.dart';
import 'package:yun_music/pages/village/village_controller.dart';
import 'package:yun_music/pages/village/village_list_page.dart';

import '../../commons/res/app_routes.dart';
import '../../commons/res/app_themes.dart';
import '../../commons/res/dimens.dart';
import '../../commons/skeleton/custom_underline_indicator.dart';
import '../../commons/widgets/music_loading.dart';
import '../../utils/adapt.dart';
import '../../vmusic/playing_controller.dart';

class VillagePage extends StatefulWidget {
  const VillagePage({super.key});

  @override
  State<VillagePage> createState() => _VillagePageState();
}

class _VillagePageState extends State<VillagePage>
    with AutomaticKeepAliveClientMixin {
  final VillageController controller = Get.put(VillageController());
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      appBar: BlogHomeAppbar(rightClickTap: () {
        Get.toNamed(RouterPath.Video_Lists);
      }),
      extendBodyBehindAppBar: false,
      body: Obx(() {
        return controller.tags.value == null
            ? Center(
                child: MusicLoading(
                axis: Axis.horizontal,
              ))
            : Container(
                margin: EdgeInsets.only(
                    bottom: PlayingController.to.mediaItems.isNotEmpty
                        ? Adapt.tabbar_padding() + kToolbarHeight
                        : Adapt.tabbar_padding()),
                child: Column(
                  children: [
                    Container(
                      color: Colors.transparent,
                      width: double.infinity,
                      height: Dimens.gap_dp40,
                      child: TabBar(
                        controller: controller.tabController,
                        tabs: [
                          for (var i in controller.tags.value!)
                            Tab(text: i.name)
                        ],
                        padding: EdgeInsets.only(
                            left: Dimens.gap_dp6,
                            top: Dimens.gap_dp6,
                            right: Dimens.gap_dp6),
                        labelPadding: EdgeInsets.only(
                            left: Dimens.gap_dp12, right: Dimens.gap_dp12),
                        isScrollable: true,
                        labelStyle: TextStyle(
                            fontSize: Dimens.font_sp12,
                            fontWeight: FontWeight.w600),
                        dividerColor: Colors.transparent,
                        indicatorColor: AppThemes.indicator_color,
                        unselectedLabelColor: context.isDarkMode
                            ? const Color.fromARGB(255, 114, 114, 114)
                            : const Color.fromARGB(255, 114, 114, 114),
                        labelColor: context.isDarkMode
                            ? const Color.fromARGB(255, 236, 236, 237)
                            : const Color.fromARGB(255, 51, 51, 51),
                        overlayColor:
                            WidgetStateProperty.all(Colors.transparent),
                        indicator: CustomUnderlineTabIndicator(
                            width: 0.0,
                            borderSide: BorderSide(
                              width: 6,
                              color: AppThemes.indicator_color,
                            ),
                            strokeCap: StrokeCap.round),
                        indicatorPadding: EdgeInsets.only(
                            bottom: Dimens.gap_dp9, top: Dimens.gap_dp21),
                        indicatorSize: TabBarIndicatorSize.label,
                        enableFeedback: true,
                        splashBorderRadius: BorderRadius.circular(10),
                        tabAlignment: TabAlignment.center,
                        onTap: (value) {
                          controller.pageController.animateToPage(value,
                              duration: const Duration(milliseconds: 100),
                              curve: Curves.easeIn);
                        },
                      ),
                    ),
                    Expanded(
                        child: PageView.builder(
                            physics: const ClampingScrollPhysics(),
                            itemCount: controller.tags.value!.length,
                            controller: controller.pageController,
                            onPageChanged: (page) {
                              controller.tabController.animateTo(page);
                            },
                            itemBuilder: (context, index) {
                              final tagModel =
                                  controller.tags.value!.elementAt(index);
                              return VillageListPage(
                                  mkey: 'list${tagModel.name}',
                                  tagModel: tagModel);
                            }))
                  ],
                ),
              );
      }),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
