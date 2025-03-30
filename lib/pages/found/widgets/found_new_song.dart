// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yun_music/pages/recommend/models/recom_model.dart';

import '../../../commons/models/song_model.dart';
import '../../../commons/models/ui_element_model.dart';
import '../../../commons/res/app_themes.dart';
import '../../../commons/res/dimens.dart';
import '../../../commons/values/function.dart';
import '../../../commons/widgets/custom_touch.dart';
import '../../../commons/widgets/network_img_layer.dart';
import '../../../utils/adapt.dart';
import '../../../utils/common_utils.dart';
import '../../../utils/image_utils.dart';
import '../../recommend/models/creative_model.dart';
import '../../recommend/models/recom_new_song.dart';
import 'found_appbar.dart';

double FoundNewSongImageWidth = Dimens.gap_dp56;

class FoundNewSong extends StatelessWidget {
  const FoundNewSong({super.key, required this.title, required this.blocks});

  final String title;
  final Blocks blocks;

  @override
  Widget build(BuildContext context) {
    final double itemheight =
        FoundNewSongImageWidth * 3 + Dimens.gap_dp8 * 3 + Dimens.gap_dp40;
    return Container(
      color: Colors.transparent,
      padding: EdgeInsets.only(top: Dimens.gap_dp8, bottom: 0),
      height: itemheight,
      child: Column(
        children: [
          FoundSectionTitleView(title: title),
          SizedBox(height: Dimens.gap_dp8),
          Expanded(
              child: PageView.builder(
                  controller: PageController(viewportFraction: 0.91),
                  itemCount: blocks.creatives?.length ?? 0,
                  itemBuilder: (context, index) {
                    final creative = blocks.creatives!.elementAt(index);
                    return Column(
                      children: _buildPageItems(creative),
                    );
                  }))
        ],
      ),
    );
  }

  List<Widget> _buildPageItems(CreativeModel creative) {
    if (creative.resources?.isEmpty == true) return List.empty();
    final List<Widget> widgets = List.empty(growable: true);

    for (final element in creative.resources!) {
      final song = RecomNewSong.fromJson(element.resourceExtInfo)
          .buildSong(element.action);
      widgets.add(Container(
        color: Colors.transparent,
        padding: EdgeInsets.only(right: Dimens.gap_dp15),
        child: Column(
          children: [
            if (widgets.isNotEmpty)
              Container(
                margin: EdgeInsets.only(left: FoundNewSongImageWidth),
                child: Divider(
                  height: 1,
                  color: Get.isDarkMode
                      ? AppThemes.dark_line_color
                      : AppThemes.line_color,
                ),
              ),
            SizedBox(
              height: FoundNewSongImageWidth,
              child: GeneralSongsThree(
                songInfo: song,
                uiElementModel: element.uiElement,
                onPressed: () {
                  //点击歌曲播放列表中的当前歌曲
                },
              ),
            )
          ],
        ),
      ));
    }
    return widgets;
  }
}

class GeneralSongsThree extends StatelessWidget {
  const GeneralSongsThree(
      {super.key,
      required this.songInfo,
      required this.uiElementModel,
      this.onPressed});

  final Song songInfo;
  final UiElementModel uiElementModel;
  final ParamVoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return BounceTouch(
      onPressed: () {},
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(
              Radius.circular(4),
            ),
            child: NetworkImgLayer(
              width: Dimens.gap_dp46,
              height: Dimens.gap_dp46,
              src: ImageUtils.getImageUrlFromSize(
                  songInfo.al.picUrl, Size(Dimens.gap_dp46, Dimens.gap_dp46)),
              imageBuilder: (context, provider) {
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    Image(image: provider),
                  ],
                );
              },
            ),
          ),
          SizedBox(width: Dimens.gap_dp10),
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                child: RichText(
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                    text: uiElementModel.mainTitle?.title.toString(),
                    style:
                        headline1Style().copyWith(fontWeight: FontWeight.bold),
                    children: [
                      const WidgetSpan(child: SizedBox(width: 4)),
                      TextSpan(
                        text: '-',
                        style: TextStyle(
                            fontSize: Dimens.font_sp10,
                            color: const Color.fromARGB(255, 166, 166, 166)),
                      ),
                      const WidgetSpan(child: SizedBox(width: 4)),
                      TextSpan(
                        text: songInfo.arString(),
                        style: TextStyle(
                            fontSize: Dimens.font_sp10,
                            color: const Color.fromARGB(255, 166, 166, 166)),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8),
              _buildSubTitle()
            ],
          )),
          const SizedBox(width: 8),
          Image.asset(
            ImageUtils.getImagePath("cm7_demo_play_icon"),
            width: 16,
            color: AppThemes.tab_grey_color,
          ),
          const SizedBox(width: 8),
        ],
      ),
    );
  }

  Widget _buildSubTitle() {
    if (GetUtils.isNullOrBlank(uiElementModel.subTitle?.title) == true) {
      return const SizedBox.shrink();
    }
    if (uiElementModel.subTitle?.titleType == 'songRcmdTag') {
      return Container(
          height: Adapt.px(13),
          padding: EdgeInsets.only(left: Adapt.px(4), right: Adapt.px(4)),
          decoration: BoxDecoration(
              color: Get.isDarkMode
                  ? Colors.white30
                  : const Color.fromARGB(255, 253, 246, 226),
              borderRadius: BorderRadius.all(Radius.circular(Adapt.px(2)))),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Text(
                uiElementModel.subTitle?.title ?? '',
                style: TextStyle(
                    fontSize: Adapt.px(9),
                    color: Get.isDarkMode
                        ? AppThemes.white
                        : const Color.fromARGB(255, 236, 192, 100)),
              ),
            ],
          ));
    } else {
      return Row(
        children: [
          Row(
            children: getSongTags(songInfo),
          ),
          Text(uiElementModel.subTitle?.title ?? "",
              style: TextStyle(
                  fontSize: Adapt.px(11),
                  color: const Color.fromARGB(255, 166, 166, 166)))
        ],
      );
    }
  }
}
