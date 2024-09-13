import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:yun_music/pages/village/models/video_category.dart';
import 'package:yun_music/pages/village/village_list_controller.dart';
import 'package:yun_music/utils/adapt.dart';

import '../../commons/res/app_themes.dart';
import '../../commons/widgets/footer_loading.dart';
import '../../commons/widgets/music_loading.dart';
import '../../commons/widgets/network_img_layer.dart';
import '../../utils/common_utils.dart';
import '../../utils/image_utils.dart';
import 'models/video_group.dart';

class VillageListPage extends StatefulWidget {
  const VillageListPage({super.key, required this.tagModel, this.mkey});

  final VideoCategory tagModel;
  final String? mkey;

  @override
  State<VillageListPage> createState() => _VillageListPageState();
}

class _VillageListPageState extends State<VillageListPage>
    with AutomaticKeepAliveClientMixin {
  late VillageListController villageListController;

  final refreshController = RefreshController();
  @override
  void initState() {
    super.initState();

    villageListController = Get.put(VillageListController(), tag: widget.mkey);
    villageListController.tagModel = widget.tagModel;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return villageListController.obx(
        (state) {
          if (state == null) {
            return Center(
              child: Text("PlaylistContentController${widget.tagModel.name}"),
            );
          } else {
            refreshController.refreshCompleted();
          }
          refreshController.loadComplete();
          return Container(
              color: AppThemes.color_204.withOpacity(0.1),
              child: SmartRefresher(
                controller: refreshController,
                footer: const FooterLoading(
                  noMoreText: "暂无更多数据",
                ),
                onLoading: () async {
                  villageListController.loadMore();
                },
                onRefresh: () async {
                  villageListController.refreshData();
                },
                enablePullUp: true,
                enablePullDown: false,
                child: _buildContent(state.datas),
              ));
        },
        onEmpty: const Text('empty'),
        onError: (err) {
          toast(err.toString());
          refreshController.refreshFailed();
          return const SizedBox.shrink();
        },
        onLoading: _buildLoading(villageListController.state?.datas == null));
  }

  Widget _buildLoading(bool needShow) {
    if (needShow) {
      return Center(
        child: MusicLoading(
          axis: Axis.horizontal,
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget _buildContent(List<VideoSurceItem>? datas) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: StaggeredGrid.count(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        children: datas!.map((e) => _buildItem(e)).toList(),
      ),
    );
  }

  Widget _buildItem(VideoSurceItem item) {
    double width = Adapt.screenW();
    double imageWidth = (width - 3 * 10) / 2.0;
    double radio = (item.data?.height ?? 0.0) / (item.data?.width ?? 1.0);
    double imageHeight = radio * imageWidth;
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: imageWidth,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(8.0))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                //封面
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(4)),
                  child: NetworkImgLayer(
                    width: imageWidth,
                    height: imageHeight,
                    src: ImageUtils.getImageUrlFromSize(
                        item.data?.coverUrl, Size(imageWidth, imageHeight)),
                    customplaceholder:
                        Container(color: AppThemes.load_image_placeholder()),
                  ),
                ),
                if (item.data?.vid != null)
                  Positioned(
                    right: 10,
                    top: 10,
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.3),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10.0))),
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.play_arrow,
                        color: Colors.white,
                        size: 15,
                      ),
                    ),
                  )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.data?.title ?? "",
                    style: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.w500),
                    softWrap: true,
                    maxLines: 2,
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: _buildFocus(item.data?.creator?.avatarUrl,
                              null, item.data?.creator?.nickname)),
                      Row(
                        children: [
                          Image.asset(
                            ImageUtils.getImagePath('cm2_act_icn_praise'),
                            width: 12,
                          ),
                          Padding(
                              padding: const EdgeInsets.only(left: 3),
                              child: Text(
                                "${item.data?.praisedCount}",
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFF999999),
                                ),
                              ))
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFocus(String? avatarUrl, String? bottomUrl, String? name) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: Row(
        children: [
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 5),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(14)),
                  child: NetworkImgLayer(width: 28, height: 28, src: avatarUrl),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: bottomUrl != null
                    ? NetworkImgLayer(
                        width: 14,
                        height: 14,
                        src: bottomUrl,
                      )
                    : Image.asset(
                        ImageUtils.getImagePath('cm2_icn_daren'),
                        width: 14,
                        height: 14,
                      ),
              )
            ],
          ),
          Expanded(
              child: Text(
            name ?? "",
            softWrap: true,
            maxLines: 1,
            textAlign: TextAlign.left,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 13, color: Color(0xFF999999)),
          )),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
