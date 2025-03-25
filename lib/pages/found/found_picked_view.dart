import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:yun_music/commons/res/dimens.dart';
import 'package:yun_music/pages/found/found_controller.dart';
import 'package:yun_music/pages/found/widgets/found_new_song.dart';
import 'package:yun_music/pages/found/widgets/found_playlist.dart';

import '../../commons/widgets/music_loading.dart';
import '../../commons/widgets/music_refresh.dart';
import '../../utils/adapt.dart';
import 'widgets/found_picker_swiper.dart';

class FoundPickedView extends StatelessWidget {
  const FoundPickedView({super.key, required this.controller});

  final FoundController controller;

  Future<void> _onRefresh() async {
    controller.requestRecommendData();
    controller.refreshController.refreshCompleted();
  }

  Widget _buildLoading(bool needShow) {
    if (needShow) {
      return Container(
        margin: EdgeInsets.only(top: Adapt.px(100)),
        child: MusicLoading(
          axis: Axis.horizontal,
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value == true) {
        return _buildLoading(true);
      } else {
        controller.refreshController.refreshCompleted();
        return Padding(
          padding: EdgeInsets.only(top: Dimens.gap_dp8),
          child: SmartRefresher(
            controller: controller.refreshController,
            enablePullDown: true,
            header: MusicRefresh(),
            onRefresh: _onRefresh,
            child: ListView.builder(
              itemBuilder: (context, index) {
                final dic = controller.blocks[index];
                if (dic["type"] == "banner") {
                  return FoundPickerSwiper(carousels: dic["list"]);
                } else if (dic["type"] == "playlist") {
                  return FoundPlaylist(
                      title: dic["title"], songList: dic["list"]);
                } else if (dic["type"] == "newSong") {
                  return FoundNewSong(title: dic["title"], blocks: dic["list"]);
                }
                return Container();
              },
              itemCount: controller.blocks.length,
            ),
          ),
        );
      }
    });
  }
}
