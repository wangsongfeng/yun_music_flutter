import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:yun_music/commons/res/app_themes.dart';
import 'package:yun_music/pages/dynamic_page/models/square_info.dart';
import 'package:yun_music/pages/dynamic_page/widgets/square_controller.dart';
import 'package:yun_music/pages/dynamic_page/widgets/square_list_item.dart';

import '../../../commons/widgets/footer_loading.dart';
import '../../../commons/widgets/music_loading.dart';
import '../../../commons/widgets/music_refresh.dart';
import '../../../utils/adapt.dart';

class SquarePage extends StatefulWidget {
  const SquarePage({super.key});

  @override
  State<SquarePage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<SquarePage>
    with AutomaticKeepAliveClientMixin {
  final refreshController = RefreshController();
  late SquareController controller;

  @override
  void initState() {
    super.initState();

    controller = Get.put(SquareController());
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return controller.obx(
        (state) {
          if (state == null) {
            return const Center(
              child: Text("PlaylistContentController"),
            );
          } else {
            refreshController.refreshCompleted();
          }
          if ((state.size ?? 0) > state.list!.length) {
            refreshController.loadComplete();
          } else {
            refreshController.loadNoData();
          }
          return SmartRefresher(
            controller: refreshController,
            header: MusicRefresh(),
            footer: const FooterLoading(
              noMoreText: "暂无更多数据",
            ),
            onLoading: () async {
              controller.loadMore();
            },
            onRefresh: () async {
              controller.refreshData();
            },
            enablePullUp: true,
            enablePullDown: true,
            child: _buildContent(state.list),
          );
        },
        onEmpty: const Text('empty'),
        onError: (err) {
          refreshController.refreshFailed();
          return const SizedBox.shrink();
        },
        onLoading: _buildLoading(controller.state?.list == null));
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

  Widget _buildContent(List<SquareList>? datas) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.only(left: 0, right: 0),
          sliver: SliverList.separated(
            itemBuilder: (context, index) {
              final model = datas?.elementAt(index);
              return SquareListItem(model: model!);
            },
            separatorBuilder: (context, index) {
              return Container(
                  color: AppThemes.diver_color.withOpacity(0.3), height: 1);
            },
            itemCount: datas?.length,
          ),
        )
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
