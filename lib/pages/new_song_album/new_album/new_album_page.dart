import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sticky_and_expandable_list/sticky_and_expandable_list.dart';
import 'package:yun_music/commons/widgets/music_loading.dart';
import 'package:yun_music/commons/widgets/network_img_layer.dart';
import 'package:yun_music/pages/new_song_album/new_album/new_album_controller.dart';
import 'package:yun_music/pages/new_song_album/new_album/new_album_top_page.dart';

import '../../../commons/res/dimens.dart';
import '../../../commons/widgets/footer_loading.dart';
import '../../../utils/adapt.dart';
import '../../../utils/common_utils.dart';
import '../../../utils/image_utils.dart';
import '../models/album_cover_info.dart';
import '../models/top_album_cover_info.dart';
import '../models/top_album_model.dart';

class NewAlbumPage extends GetView<NewAlbumController> {
  const NewAlbumPage({super.key});

  @override
  NewAlbumController get controller =>
      GetInstance().putOrFind(() => NewAlbumController());

  @override
  Widget build(BuildContext context) {
    return controller.obx(
      (state) {
        if (GetUtils.isNullOrBlank(controller.newAlbums) == true ||
            GetUtils.isNullOrBlank(state) == true) {
          return Container();
        } else {
          controller.refreshController ??= RefreshController();
          controller.refreshController!.refreshCompleted();
          if (GetUtils.isNullOrBlank(state) == true) {
            controller.refreshController!.loadNoData();
          } else {
            controller.refreshController!.loadComplete();
          }

          return Container(
            color: Get.theme.cardColor,
            child: SmartRefresher(
              controller: controller.refreshController!,
              footer: const FooterLoading(
                noMoreText: "暂无更多歌单",
              ),
              onLoading: () async {
                controller.loadMore();
              },
              enablePullUp: true,
              enablePullDown: false,
              child: _buildListContent(context, controller.newAlbums!, state!),
            ),
          );
        }
      },
      onEmpty: const Text("empty"),
      onError: (err) {
        Get.log('refresh error $err');
        toast(err.toString());
        controller.refreshController?.refreshFailed();
        return const SizedBox.shrink();
      },
      onLoading: _buildLoading(true),
    );
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

  Widget _buildListContent(BuildContext context, List<AlbumCoverInfo> list,
      List<TopAlbumModel> state) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: NewAlbumTopPage(newAlbums: list),
        ),
        SliverToBoxAdapter(
          child: Column(
            children: [
              Container(
                color: Get.theme.cardColor,
                width: Adapt.screenW(),
                height: Dimens.gap_dp8,
              ),
              Container(
                color: Get.theme.scaffoldBackgroundColor,
                width: Adapt.screenW(),
                height: Dimens.gap_dp8,
              ),
            ],
          ),
        ),
        SliverExpandableList(
            builder:
                SliverExpandableChildDelegate<TopAlbumCoverInfo, TopAlbumModel>(
                    sectionList: state,
                    sectionBuilder: _buildSection,
                    itemBuilder: (context, sectionIndex, itemIndex, index) {
                      final item =
                          state[sectionIndex].getItems().elementAt(itemIndex);
                      return _buildItem(item);
                    })),
      ],
    );
  }

  Widget _buildSection(
      BuildContext context, ExpandableSectionContainerInfo containerInfo) {
    containerInfo
      ..header = _buildHeader(context, containerInfo)
      ..content = _buildContent(context, containerInfo);
    return ExpandableSectionContainer(
      info: containerInfo,
    );
  }

  Widget _buildHeader(
      BuildContext context, ExpandableSectionContainerInfo containerInfo) {
    final section = controller.state![containerInfo.sectionIndex];
    return Container(
      color: Get.theme.cardColor,
      height: Dimens.gap_dp38,
      padding: EdgeInsets.only(left: Dimens.gap_dp16, top: Dimens.gap_dp5),
      alignment: Alignment.centerLeft,
      child: section.label != null
          ? Text(
              section.label!,
              style: headlineStyle(),
            )
          : RichText(
              text: TextSpan(
                text: '${section.dateTime?.month}月',
                style: headlineStyle(),
                children: [
                  TextSpan(
                      text: ' /${section.dateTime?.year}',
                      style:
                          captionStyle().copyWith(fontSize: Dimens.font_sp15))
                ],
              ),
            ),
    );
  }

  Widget? _buildContent(
      BuildContext context, ExpandableSectionContainerInfo containerInfo) {
    return Container(
      color: Get.theme.cardColor,
      padding: EdgeInsets.symmetric(
          horizontal: Dimens.gap_dp16, vertical: Dimens.gap_dp8),
      child: GridView.builder(
        padding: EdgeInsets.only(bottom: Dimens.gap_dp10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: Dimens.gap_dp20,
          crossAxisSpacing: Dimens.gap_dp15,
          childAspectRatio: 0.9,
        ),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: containerInfo.childDelegate!.builder as Widget Function(
            BuildContext, int),
        itemCount: containerInfo.childDelegate!.childCount,
      ),
    );
  }

  Widget _buildItem(TopAlbumCoverInfo item) {
    return GestureDetector(
      onTap: () {
        // Get.toNamed(Routes.ALBUM_DETAIL_ID(item.id.toString()));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Image.asset(
                ImageUtils.getImagePath(GetPlatform.isAndroid
                    ? 'ic_cover_alb_android'
                    : 'ic_cover_alb_ios'),
                width: Dimens.gap_dp164,
              ),
              Positioned(
                  top: 0,
                  left: 0,
                  child: ClipRRect(
                      borderRadius:
                          BorderRadius.all(Radius.circular(Dimens.gap_dp6)),
                      child: NetworkImgLayer(
                        width: Adapt.px(142),
                        height: Adapt.px(142),
                        src: ImageUtils.getImageUrlFromSize(
                          item.picUrl,
                          Size(Dimens.gap_dp140, Dimens.gap_dp140),
                        ),
                      )))
            ],
          ),
          SizedBox(height: Dimens.gap_dp5),
          Text(
            item.getAlbumName(),
            style: body1Style().copyWith(fontWeight: FontWeight.w500),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          // Gaps.vGap4,
          Text(item.getArName(),
              style: captionStyle(),
              maxLines: 1,
              overflow: TextOverflow.ellipsis)
          // Text(data)
        ],
      ),
    );
  }
}
