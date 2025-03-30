// ignore_for_file: slash_for_doc_comments

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:yun_music/commons/models/banner_model.dart';
import 'package:yun_music/commons/res/app_routes.dart';
import 'package:yun_music/commons/res/app_themes.dart';
import 'package:yun_music/commons/res/dimens.dart';
import 'package:yun_music/commons/skeleton/music_recm.dart';
import 'package:yun_music/commons/values/constants.dart';
import 'package:yun_music/commons/widgets/music_refresh.dart';
import 'package:yun_music/pages/recommend/models/recom_ball_model.dart';
import 'package:yun_music/pages/recommend/models/recom_model.dart';
import 'package:yun_music/pages/recommend/recom_controller.dart';
import 'package:yun_music/pages/recommend/widgets/recom_balls.dart';
import 'package:yun_music/pages/recommend/widgets/recom_banner.dart';
import 'package:yun_music/pages/recommend/widgets/recom_hot_topic.dart';
import 'package:yun_music/pages/recommend/widgets/recom_music_calendar.dart';
import 'package:yun_music/pages/recommend/widgets/recom_playlist_cell.dart';
import 'package:yun_music/pages/recommend/widgets/recom_slide_song_align.dart';
import 'package:yun_music/pages/recommend/widgets/recom_song_album.dart';
import 'package:yun_music/pages/recommend/widgets/recom_yun_product.dart';
import 'package:yun_music/pages/recommend/widgets/recon_slide_single.dart';
import 'package:yun_music/utils/adapt.dart';
import 'package:yun_music/utils/common_utils.dart';
import 'package:yun_music/vmusic/playing_controller.dart';
import 'widgets/recom_appbar.dart';

class RecomPage extends StatefulWidget {
  const RecomPage({super.key});

  @override
  State<RecomPage> createState() => _RecomPageState();
}

class _RecomPageState extends State<RecomPage>
    with AutomaticKeepAliveClientMixin {
  final controller = GetInstance().putOrFind(() => RecomController());

  final refreshController = RefreshController();

  @override
  bool get wantKeepAlive => true;

  Future<void> _onRefresh() async {
    controller.getFoundRecList(refresh: true);
    controller.getDefaultSearch();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: RecomAppbar(onSubmit: (text) {
        Get.toNamed(RouterPath.Search_Page);
      }),
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      body: Obx(() {
        return Container(
          width: Adapt.screenW(),
          margin: EdgeInsets.only(
            bottom: PlayingController.to.mediaItems.isNotEmpty
                ? Adapt.tabbar_padding() + Dimens.gap_dp49
                : Adapt.tabbar_height(),
          ),
          color: Colors.transparent,
          child: Stack(
            children: [
              //顶部跟随banner变动的背景
              // const Positioned(
              //   top: 0,
              //   child: RecomHeaderBgColors(),
              // ),
              Positioned.fill(
                top:
                    (Get.theme.appBarTheme.toolbarHeight! + Adapt.topPadding()),
                child: controller.obx(
                    (state) {
                      refreshController.refreshCompleted();
                      return _buildListView(context, state);
                    },
                    onEmpty: const Text('empty'),
                    onError: (err) {
                      toast(err.toString());
                      refreshController.refreshFailed();
                      return const SizedBox.shrink();
                    },
                    onLoading: _buildLoading()),
              )
            ],
          ),
        );
      }),
    );
  }

  //创建试图
  Widget _buildListView(BuildContext context, RecomModel? state) {
    if (state != null) {
      controller.expirationTime = DateTime.now().millisecondsSinceEpoch +
          state.pageConfig.refreshInterval;
    }
    final listScroll = ScrollController();
    listScroll.addListener(() {
      controller.isScrolled.value = listScroll.position.pixels >= 15.0;
    });

    return SmartRefresher(
      controller: refreshController,
      // enablePullUp: true,
      enablePullDown: true,
      header: MusicRefresh(),
      onRefresh: _onRefresh,
      child: ListView.separated(
        padding: EdgeInsets.only(bottom: Dimens.gap_dp2),
        controller: listScroll,
        itemBuilder: (context, index) {
          final blocks = state!.blocks[index];
          final nextType = index + 1 < state.blocks.length
              ? state.blocks[index + 1].showType
              : null;
          return _buildItem(blocks, index, nextType);
        },
        separatorBuilder: (context, index) {
          final blocks = state!.blocks[index];
          return index == 0 ||
                  blocks.showType == "DRAGON_BALL" ||
                  blocks.showType == "SLIDE_PLAYABLE_DRAGON_BALL_NEW_BROADCAST"
              ? const SizedBox.shrink()
              : Container(
                  color: context.isDarkMode
                      ? AppThemes.dark_tab_bg_color
                      : AppThemes.color_237,
                  height: Dimens.gap_dp2,
                );
        },
        itemCount: state != null ? state.blocks.length : 0,
      ),
    );
  }

  /**
   * 根据类型创建 Item Cell
   */

  Widget _buildItem(Blocks blocks, int index, String? nextType) {
    final itemHeight = ((controller.itemHeightFromType[blocks.showType]) ?? 0);
    switch (blocks.showType) {
      //轮播图
      case SHOWTYPE_BANNER:
        return RecomBanner(
            key: Key(blocks.extInfo.hashCode.toString()),
            bannerModel: BannerModel.fromJson(blocks.extInfo),
            itemHeight: itemHeight);
      //balls标签
      case SHOWTYPE_BALL:
        return RecomBalls(
            (blocks.extInfo as List).map((e) => Ball.fromJson(e)).toList(),
            itemHeight: itemHeight);
      //热门推荐，横向滑动
      case SHOWTYPE_HOMEPAGE_SLIDE_PLAYLIST:
        return RecomPlaylistCell(
            uiElementModel: blocks.uiElement!,
            creatives: blocks.creatives!,
            curIndex: index,
            itemHeight: itemHeight);
      //新歌，新碟，热门播客
      case HOMEPAGE_SLIDE_PODCAST_VOICE_MORE_TAB:
      case SHOWTYPE_HOMEPAGE_NEW_SONG_NEW_ALBUM:
        return RecomSongAlbum(
            creatives: blocks.creatives!,
            itemHeight: itemHeight,
            bottomRadius: nextType != SHOWTYPE_SLIDE_SINGLE_SONG);
      case SHOWTYPE_SLIDE_SINGLE_SONG:
        return ReconSlideSingleSong(
          blocks: blocks,
          itemHeight: itemHeight,
        );
      //音乐日历
      case SHOWTYPE_SHUFFLE_MUSIC_CALENDAR:
        return RecomMusicCalendar(
          blocks: blocks,
          itemHeight: itemHeight,
        );
      case SHOWTYPE_HOMEPAGE_SLIDE_SONGLIST_ALIGN:
        return RecomSlideSongAlign(
          itemHeight: itemHeight,
          blocks: blocks,
        );
      //云村出品
      case HOMEPAGE_YUNCUN_PRODUCED:
        return RecomYunProduct(blocks: blocks, itemHeight: itemHeight);
      //热门话题
      case HOMEPAGE_BLOCK_HOT_TOPIC:
        return RecomHotTopic(blocks: blocks, itemHeight: itemHeight);

      default:
        return Container();
    }
  }

  Widget _buildLoading() {
    if (controller.state == null) {
      return Container(
          margin: const EdgeInsets.only(
            top: 0,
            bottom: 0,
          ),
          padding: const EdgeInsets.only(bottom: 0),
          child: const MusicRecmSkeleton());
    } else {
      return const SizedBox.shrink();
    }
  }
}
