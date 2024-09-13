// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:yun_music/commons/models/simple_play_list_model.dart';
import 'package:yun_music/commons/res/app_routes.dart';
import 'package:yun_music/commons/res/app_themes.dart';
import 'package:yun_music/commons/widgets/custom_touch.dart';
import 'package:yun_music/commons/widgets/footer_loading.dart';
import 'package:yun_music/pages/playlist_collection/model/plsy_list_tag_model.dart';
import 'package:yun_music/pages/playlist_collection/widget/generral_cover_playcount.dart';
import 'package:yun_music/pages/playlist_collection/widget/playlist_content_controller.dart';
import 'package:yun_music/utils/adapt.dart';

import '../../../commons/res/dimens.dart';
import '../../../commons/widgets/music_loading.dart';
import '../../../utils/common_utils.dart';
import '../../../utils/image_utils.dart';

class PlaylistContentPage extends StatefulWidget {
  const PlaylistContentPage({super.key, required this.tagModel, this.mkey});

  final PlayListTagModel tagModel;
  final String? mkey;

  @override
  State<PlaylistContentPage> createState() => _PlaylistContentPageState();
}

class _PlaylistContentPageState extends State<PlaylistContentPage>
    with AutomaticKeepAliveClientMixin {
  late PlaylistContentController playlistContentController;

  final refreshController = RefreshController();
  @override
  void initState() {
    super.initState();

    print("initState--${widget.tagModel.name}--${widget.mkey}");

    playlistContentController =
        Get.put(PlaylistContentController(), tag: widget.mkey);
    playlistContentController.tagModel = widget.tagModel;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return playlistContentController.obx(
        (state) {
          if (state == null)
            return Container(
              child: Center(
                child: Text("PlaylistContentController${widget.tagModel.name}"),
              ),
            );
          else
            refreshController.refreshCompleted();
          if ((state.totalCount ?? 0) > state.datas.length) {
            refreshController.loadComplete();
          } else {
            refreshController.loadNoData();
          }
          return Container(
              color: Get.theme.cardColor,
              margin: EdgeInsets.only(
                  bottom: Dimens.gap_dp49 + Adapt.bottomPadding()),
              child: SmartRefresher(
                controller: refreshController,
                footer: const FooterLoading(
                  noMoreText: "暂无更多歌单",
                ),
                onLoading: () async {
                  playlistContentController.loadMore();
                },
                onRefresh: () async {
                  playlistContentController.refreshData();
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
        onLoading:
            _buildLoading(playlistContentController.state?.datas == null));
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

  Widget _buildContent(List<SimplePlayListModel>? datas) {
    if (widget.tagModel.name == '精品') {
      return CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.only(
                  bottom: Dimens.gap_dp10,
                  left: Dimens.gap_dp15,
                  right: Dimens.gap_dp15),
              height: Dimens.gap_dp48,
              child: _buildFiltter(),
            ),
          ),
          SliverPadding(
            padding:
                EdgeInsets.only(left: Dimens.gap_dp15, right: Dimens.gap_dp15),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate((context, index) {
                final item = datas!.elementAt(index);
                return _buildItem(item);
              }, childCount: datas?.length ?? 0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: Dimens.gap_dp10,
                  crossAxisSpacing: Dimens.gap_dp9,
                  childAspectRatio: 0.69),
            ),
          ),
        ],
      );
    } else {
      return _buildListView(datas);
    }
  }

  Widget _buildListView(List<SimplePlayListModel>? datas) {
    return GridView.builder(
      padding: EdgeInsets.only(
          left: Dimens.gap_dp15, right: Dimens.gap_dp15, top: Dimens.gap_dp12),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: Dimens.gap_dp10,
        crossAxisSpacing: Dimens.gap_dp9,
        childAspectRatio: 114.2 / 165.4,
      ),
      itemBuilder: (context, index) {
        final item = datas!.elementAt(index);
        return _buildItem(item);
      },
      itemCount: datas?.length,
    );
  }

  //通用item
  Widget _buildItem(SimplePlayListModel item) {
    return BounceTouch(
      onPressed: () {
        Get.toNamed(RouterPath.PlayListDetailId(item.id.toString()));
      },
      child: Column(
        children: [
          GenerralCoverPlaycount(
            imageUrl: item.getCoverUrl(),
            playCount: item.playCount,
            coverSize: Size(Dimens.gap_dp109, Dimens.gap_dp108),
            coverRadius: 10.0,
            rightTopTagIcon: widget.tagModel.name == '精品'
                ? ImageUtils.getImagePath('c_k')
                : null,
          ),
          SizedBox(height: Dimens.gap_dp6),
          Text(
            item.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: body1Style(),
          )
        ],
      ),
    );
  }

  //精品列表筛选
  Widget _buildFiltter() {
    return Row(
      children: [
        Expanded(
          child: Obx(() => Text(
                playlistContentController.cat.value ?? '全部精品',
                style: body1Style(),
              )),
        ),
        GestureDetector(
          onTap: () {
            if (playlistContentController.highqualityTags == null ||
                playlistContentController.requesting) {
              return;
            }
            Get.bottomSheet(
                SizedBox(
                    height: Adapt.screenH() * 0.6,
                    child: Stack(
                      children: [
                        _buildFilterContent(),
                        Positioned(
                            top: Dimens.gap_dp16,
                            right: Dimens.gap_dp16,
                            child: GestureDetector(
                              onTap: () {
                                Get.back();
                              },
                              child: Container(
                                width: Dimens.gap_dp26,
                                height: Dimens.gap_dp26,
                                decoration: BoxDecoration(
                                    color: Get.isDarkMode
                                        ? Colors.white.withOpacity(0.2)
                                        : const Color.fromARGB(
                                            140, 229, 229, 229),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(Dimens.gap_dp13))),
                                child: Center(
                                  child: Image.asset(
                                    ImageUtils.getImagePath('brx'),
                                    color: body1Style().color,
                                  ),
                                ),
                              ),
                            ))
                      ],
                    )),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(Dimens.gap_dp8),
                        topLeft: Radius.circular(Dimens.gap_dp8))),
                backgroundColor: Get.theme.cardColor,
                enableDrag: false);
          },
          child: Container(
            padding: EdgeInsets.all(Dimens.gap_dp10),
            child: RichText(
                text: TextSpan(children: [
              WidgetSpan(
                  child: Image.asset(
                ImageUtils.getImagePath('cf'),
                width: Dimens.gap_dp15,
                color: body1Style().color,
              )),
              TextSpan(text: '筛选', style: body1Style())
            ])),
          ),
        )
      ],
    );
  }

  Widget _buildFilterContent() {
    return Column(
      children: [
        SizedBox(height: Dimens.gap_dp16),
        Text(
          '所有精品歌单',
          style: body1Style().copyWith(
              fontSize: Dimens.font_sp18, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: Dimens.gap_dp20),
        Expanded(
            child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
                child: Container(
              margin: EdgeInsets.only(
                  left: Dimens.gap_dp15, right: Dimens.gap_dp15),
              child: _buildFilterItem(null),
            )),
            SliverPadding(
              padding: EdgeInsets.only(
                  left: Dimens.gap_dp15,
                  bottom: Dimens.gap_bottom_play_height,
                  right: Dimens.gap_dp15,
                  top: Dimens.gap_dp20),
              sliver: SliverGrid(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final item = playlistContentController.highqualityTags!
                      .elementAt(index);
                  return _buildFilterItem(item);
                },
                    childCount:
                        playlistContentController.highqualityTags?.length ?? 0),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisSpacing: Dimens.gap_dp20,
                    crossAxisSpacing: Dimens.gap_dp9,
                    childAspectRatio: 78 / 40),
              ),
            )
          ],
        ))
      ],
    );
  }

  Widget _buildFilterItem(String? label) {
    return Obx(() {
      final isSelected = label == null
          ? playlistContentController.cat.value == null
          : playlistContentController.cat.value == label;
      return GestureDetector(
        onTap: () {
          playlistContentController.cat.value = label;
          playlistContentController.refreshData();
          Get.back();
        },
        child: Container(
          height: Dimens.gap_dp40,
          padding: EdgeInsets.only(left: Dimens.gap_dp9, right: Dimens.gap_dp9),
          decoration: BoxDecoration(
              color: _getLabelBgColor(isSelected),
              borderRadius: BorderRadius.all(Radius.circular(Dimens.gap_dp20))),
          child: Center(
            child: Text(
              label ?? '全部精品',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: isSelected
                  ? body1Style().copyWith(
                      fontSize: Dimens.font_sp14,
                      color: Get.isDarkMode
                          ? AppThemes.white_dark
                          : AppThemes.white)
                  : body1Style().copyWith(fontSize: Dimens.font_sp14),
            ),
          ),
        ),
      );
    });
  }

  Color _getLabelBgColor(bool isSelected) {
    if (isSelected) {
      //选中
      if (Get.isDarkMode) {
        return AppThemes.btn_selectd_color_dark;
      } else {
        return AppThemes.btn_selectd_color;
      }
    } else {
      if (Get.isDarkMode) {
        return AppThemes.label_bg_dark;
      } else {
        return AppThemes.label_bg;
      }
    }
  }

  @override
  bool get wantKeepAlive => true;
}
