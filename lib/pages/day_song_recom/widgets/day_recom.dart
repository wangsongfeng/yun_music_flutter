import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yun_music/commons/models/song_model.dart';
import 'package:yun_music/commons/res/dimens.dart';
import 'package:yun_music/commons/widgets/music_loading.dart';
import 'package:yun_music/pages/day_song_recom/widgets/check_song_cell.dart';
import 'package:yun_music/pages/day_song_recom/widgets/day_recom_header.dart';

import '../../../delegate/general_sliver_delegate.dart';
import '../../../utils/adapt.dart';
import '../controller.dart';
import 'day_recom_playall.dart';

class RecomDailyPage extends StatelessWidget {
  RecomDailyPage({super.key});

  final controller = Get.find<DaySongRecmController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: Dimens.gap_dp49 + Adapt.bottomPadding()),
      child: CustomScrollView(
        slivers: [
          //header
          const RecomDailyHeaderPage(),
          //间距
          SliverPersistentHeader(
              delegate: GeneralSliverDelegate(
            child: PreferredSize(
                preferredSize: Size.fromHeight(Dimens.gap_dp12),
                child: const SizedBox.shrink()),
          )),
          //播放全部
          const DayRecomPlayallBtn(),
          //歌曲列表content
          _buildConetent(context)
        ],
      ),
    );
  }

  Widget _buildConetent(BuildContext conetxt) {
    return Obx(() {
      return controller.state.recomModel.value == null
          ? SliverToBoxAdapter(
              child: Container(
                margin: EdgeInsets.only(top: Dimens.gap_dp105),
                child: MusicLoading(),
              ),
            )
          : SliverFixedExtentList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return _buildItems(
                      context, controller.items().elementAt(index));
                },
                childCount: controller.items().length,
              ),
              itemExtent: Dimens.gap_dp60,
            );
    });
  }

  Widget _buildItems(BuildContext conetext, Song song) {
    return CheckSongCell(
      song: song,
      checkSongController: controller,
      cellClickCallback: (item) {
        if (controller.showCheck.value) {
          //选择打开
          List<Song>? oldList = controller.selectedSong.value;
          if (GetUtils.isNullOrBlank(oldList) != true &&
              oldList?.indexWhere((element) => element.id == item.id) != -1) {
            //已选中
            oldList!.removeWhere((element) => element.id == item.id);
            controller.selectedSong.value = List.from(oldList);
          } else {
            //未选中
            if (oldList == null) {
              oldList = [item];
            } else {
              oldList.add(item);
            }
            controller.selectedSong.value = List.from(oldList);
          }
        } else {
          //点击播放音乐
          controller.playList(conetext, song: song);
        }
      },
    );
  }
}
