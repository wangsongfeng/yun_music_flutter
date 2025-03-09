import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:yun_music/commons/res/dimens.dart';
import 'package:yun_music/pages/dynamic_page/widgets/attention_controller.dart';

import '../../../commons/widgets/music_loading.dart';
import '../../../commons/widgets/music_refresh.dart';
import '../../../utils/adapt.dart';
import '../../blog_page/models/blog_recom_model.dart';
import '../../blog_page/widgets/blog_header_widget.dart';
import 'attention_personal.dart';
import 'attention_song.dart';

class AttentionPage extends StatefulWidget {
  const AttentionPage({super.key});

  @override
  State<AttentionPage> createState() => _AttentionPageState();
}

class _AttentionPageState extends State<AttentionPage>
    with AutomaticKeepAliveClientMixin {
  late AttentionController controller;

  final refreshController = RefreshController();

  @override
  void initState() {
    super.initState();
    controller = Get.put(AttentionController());
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Obx(() {
      if (controller.isLoading.value == true) {
        return _buildLoading(true);
      } else {
        refreshController.refreshCompleted();
        return _buildListView(context);
      }
    });
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

  Widget _buildListView(BuildContext context) {
    return SmartRefresher(
      controller: refreshController,
      enablePullDown: true,
      header: MusicRefresh(),
      onRefresh: () {
        controller.loadRefresh();
      },
      child: CustomScrollView(
        slivers: [
          if (controller.playListWarp.value!.result!.isNotEmpty)
            SliverToBoxAdapter(
                child: AttentionPersonal(
                    playLists: controller.playListWarp.value!.result!.length > 6
                        ? controller.playListWarp.value!.result!.sublist(0, 6)
                        : controller.playListWarp.value!.result!)),
          if (controller.newSongListWarp.value!.result!.isNotEmpty)
            SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.only(
                    top: Dimens.gap_dp6, bottom: Dimens.gap_dp6),
                child: BlogHeaderWidget(
                  onPressed: () {},
                  personal: null,
                  recomModel: BlogRecomModel(categoryName: '每日推荐'),
                  showRight: false,
                ),
              ),
            ),
          if (controller.newSongListWarp.value!.result!.isNotEmpty)
            SliverList.builder(
              itemBuilder: (context, index) {
                final item =
                    controller.newSongListWarp.value!.result!.elementAt(index);
                return AttentionSongItem(
                  song: item,
                  index: index,
                  cellClickCallback: (item) {},
                  controller: controller,
                );
              },
              itemCount: controller.newSongListWarp.value!.result!.length,
            )
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
