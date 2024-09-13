import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yun_music/pages/new_song_album/new_song/new_song_controller.dart';
import 'package:yun_music/utils/adapt.dart';

import '../../../commons/res/app_themes.dart';
import '../../../commons/res/dimens.dart';
import '../../../commons/skeleton/custom_underline_indicator.dart';
import '../new_song_album_controller.dart';
import 'new_song_list_page.dart';

class NewSongPage extends StatefulWidget {
  const NewSongPage({super.key});

  @override
  State<NewSongPage> createState() => _NewSongPageState();
}

class _NewSongPageState extends State<NewSongPage>
    with AutomaticKeepAliveClientMixin {
  final controller = GetInstance().putOrFind(() => NewSongController());

  final parentController = GetInstance().find<NewSongAlbumController>();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
      padding: EdgeInsets.only(bottom: Dimens.gap_dp49 + Adapt.bottomPadding()),
      child: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: Dimens.gap_dp38,
            child: Align(
              alignment: Alignment.center,
              child: TabBar(
                controller: controller.tabController,
                tabs: [for (var i in controller.tags) Tab(text: i.name)],
                padding: EdgeInsets.only(
                    left: Dimens.gap_dp6,
                    top: Dimens.gap_dp6,
                    right: Dimens.gap_dp6),
                labelPadding: EdgeInsets.only(
                    left: Dimens.gap_dp16, right: Dimens.gap_dp16),
                isScrollable: false,
                labelStyle: TextStyle(
                    fontSize: Dimens.font_sp13, fontWeight: FontWeight.bold),
                unselectedLabelStyle: TextStyle(
                    fontSize: Dimens.font_sp13, fontWeight: FontWeight.w500),
                dividerColor: Colors.transparent,
                indicatorColor: AppThemes.indicator_color,
                unselectedLabelColor: const Color.fromARGB(255, 114, 114, 114),
                labelColor: const Color.fromARGB(255, 51, 51, 51),
                overlayColor: WidgetStateProperty.all(Colors.transparent),
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
          ),
          Expanded(
              child: PageView.builder(
                  physics: const ClampingScrollPhysics(),
                  itemCount: controller.tags.length,
                  controller: controller.pageController,
                  onPageChanged: (page) {
                    controller.tabController.animateTo(page);
                    parentController.showCheck.value = false;
                    parentController.selectedSong.value = null;
                  },
                  itemBuilder: (context, index) {
                    final tagModel = controller.tags.elementAt(index);
                    return NewSongListPage(
                      mkey: 'list${tagModel.name}',
                      tagModel: tagModel,
                    );
                  }))
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
