import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yun_music/commons/res/dimens.dart';
import 'package:yun_music/commons/values/server.dart';

import '../../commons/res/app_themes.dart';
import '../../utils/adapt.dart';
import '../../utils/common_utils.dart';
import '../../utils/image_utils.dart';
import '../playing_controller.dart';

class PlayListContent extends StatefulWidget {
  const PlayListContent({super.key});

  @override
  State<PlayListContent> createState() => _PlayListContentState();
}

class _PlayListContentState extends State<PlayListContent> {
  final PlayingController playingController = Get.find<PlayingController>();

  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    super.dispose();

    _scrollController.dispose();
    logger.d("释放了");
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToIndex(
          playingController.currentIndex.value); // 注意索引是从0开始的，所以第5个项目是索引4
    });
  }

  void _scrollToIndex(int index) {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.minScrollExtent +
            Dimens.gap_dp46 * index -
            (Adapt.screenH() * 0.7 - Dimens.gap_dp100 - Adapt.bottomPadding()) /
                2.0, // 计算偏移量，50.0是每个项目的高度假设值，根据实际情况调整
        duration: const Duration(milliseconds: 200), // 动画持续时间
        curve: Curves.easeInOut, // 动画曲线
      );
    } else {
      // 或者使用 ensureVisible 方法，如果已知每个item的高度：
      // _scrollController.position.ensureVisible(index, alignmentPolicy: Curves.easeInOut);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppThemes.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(Dimens.gap_dp12),
              topRight: Radius.circular(Dimens.gap_dp12))),
      padding:
          EdgeInsets.only(top: Dimens.gap_dp8, bottom: Adapt.bottomPadding()),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              padding: EdgeInsets.only(
                left: Dimens.gap_dp16,
                right: Dimens.gap_dp16,
              ),
              width: Dimens.gap_dp32,
              height: 3.6,
              decoration: const BoxDecoration(
                  color: AppThemes.diver_color,
                  borderRadius: BorderRadius.all(Radius.circular(1.8))),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: Dimens.gap_dp16,
              right: Dimens.gap_dp16,
              top: Dimens.gap_dp12,
            ),
            child: Text(
              '当前播放',
              style: TextStyle(
                  fontSize: Dimens.font_sp15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black.withOpacity(0.78)),
            ),
          ),
          Divider(color: AppThemes.diver_color.withOpacity(0.2)),
          _buildSettingContent(),
          _buildListContent(),
        ],
      ),
    );
  }

  Widget _buildSettingContent() {
    return Padding(
      padding: EdgeInsets.only(
          left: Dimens.gap_dp16,
          right: Dimens.gap_dp16,
          top: Dimens.gap_dp2,
          bottom: Dimens.gap_dp8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Obx(() {
            return GestureDetector(
              onTap: () {
                playingController.changeRepeatMode();
              },
              child: Container(
                padding: EdgeInsets.only(
                    left: Dimens.gap_dp8, right: Dimens.gap_dp8),
                height: Dimens.gap_dp28,
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.1),
                    borderRadius:
                        BorderRadius.all(Radius.circular(Dimens.gap_dp14))),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        playingController.repeartAsset.value,
                        width: Dimens.gap_dp16,
                        color: Colors.black,
                      ),
                      SizedBox(
                        width: Dimens.gap_dp4,
                      ),
                      Text(
                        playingController.repeartTitle.value,
                        style: TextStyle(fontSize: Dimens.font_sp12),
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
          const Spacer(),
          GestureDetector(
            onTap: () {},
            child: Container(
              padding: EdgeInsets.only(left: Dimens.gap_dp16),
              child: Image.asset(
                ImageUtils.getImagePath('cm8_playlist_download'),
                width: Dimens.gap_dp18,
                color: Colors.black,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              padding: EdgeInsets.only(left: Dimens.gap_dp16),
              child: Image.asset(
                ImageUtils.getImagePath('cm8_playlist_add_video'),
                width: Dimens.gap_dp18,
                color: Colors.black,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              padding: EdgeInsets.only(left: Dimens.gap_dp16),
              child: Image.asset(
                ImageUtils.getImagePath('cm8_playlist_delete'),
                width: Dimens.gap_dp18,
                color: Colors.black,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildListContent() {
    return Expanded(
        child: CustomScrollView(
      controller: _scrollController,
      physics: const ClampingScrollPhysics(),
      slivers: [
        const SliverToBoxAdapter(
          child: SizedBox(height: 1),
        ),
        Obx(() {
          return SliverList.builder(
              itemBuilder: (context, index) {
                final item = playingController.mediaItems[index];
                return _buildItemContent(item, index);
              },
              itemCount: playingController.mediaItems.length);
        })
      ],
    ));
  }

  Widget _buildItemContent(MediaItem item, int index) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          PlayingController.to.playByIndex(index, "queueTitle",
              mediaItem: playingController.mediaItems);
        },
        child: Container(
          height: Dimens.gap_dp46,
          padding:
              EdgeInsets.only(left: Dimens.gap_dp16, right: Dimens.gap_dp16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ///播放中...
              Obx(() {
                if (playingController.mediaItem.value.id ==
                    item.id.toString()) {
                  return Padding(
                    padding: EdgeInsets.only(right: Dimens.gap_dp10),
                    child: Image.asset(
                      ImageUtils.getPlayingMusicTag(),
                      color: AppThemes.btn_selectd_color,
                      width: Dimens.gap_dp12,
                    ),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              }),
              Obx(() {
                return RichText(
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                    text: item.title,
                    style: body1Style().copyWith(
                        fontSize: Dimens.font_sp14,
                        color: playingController.mediaItem.value.id ==
                                item.id.toString()
                            ? AppThemes.btn_selectd_color
                            : Colors.black,
                        fontWeight: FontWeight.normal),
                  ),
                );
              }),
              SizedBox(
                width: Dimens.gap_dp4,
              ),
              Expanded(
                child: Text(
                  "- ${item.artist ?? ""}",
                  style: captionStyle(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
