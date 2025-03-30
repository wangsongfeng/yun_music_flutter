import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yun_music/commons/res/dimens.dart';
import 'package:yun_music/commons/widgets/element_title_widget.dart';
import 'package:yun_music/commons/widgets/general_song_two.dart';
import 'package:yun_music/pages/recommend/models/creative_model.dart';
import 'package:yun_music/pages/recommend/models/recom_model.dart';
import 'package:yun_music/pages/recommend/models/recom_new_song.dart';
import 'package:yun_music/utils/adapt.dart';

class RecomSlideSongAlign extends StatelessWidget {
  const RecomSlideSongAlign(
      {super.key, required this.blocks, required this.itemHeight});

  final Blocks blocks;

  final double itemHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: itemHeight,
      decoration: BoxDecoration(
        color: Get.theme.cardColor,
        borderRadius: BorderRadius.all(
          Radius.circular(Dimens.gap_dp10),
        ),
      ),
      child: Column(
        children: [
          ElementTitleWidget(
            elementModel: blocks.uiElement!,
            onPressed: () {},
          ),
          Expanded(
              child: PageView.builder(
                  controller: PageController(viewportFraction: 0.91),
                  itemCount: blocks.creatives?.length ?? 0,
                  itemBuilder: (context, index) {
                    final creative = blocks.creatives!.elementAt(index);
                    return Column(
                      children: _buildPageItems(creative, context),
                    );
                  }))
        ],
      ),
    );
  }

  List<Widget> _buildPageItems(CreativeModel creative, BuildContext context) {
    if (creative.resources?.isEmpty == true) return List.empty();
    final List<Widget> widgets = List.empty(growable: true);
    for (final element in creative.resources!) {
      final song = RecomNewSong.fromJson(element.resourceExtInfo)
          .buildSong(element.action);
      widgets.add(Container(
        padding: EdgeInsets.only(right: Dimens.gap_dp15),
        child: Column(
          children: [
            if (widgets.isNotEmpty)
              Container(
                margin: EdgeInsets.only(left: Adapt.px(58)),
                child: Divider(
                  height: 0.7,
                  color: context.isDarkMode
                      ? const Color.fromRGBO(45, 46, 49, 0.2)
                      : const Color.fromRGBO(45, 46, 49, 0.06),
                ),
              ),
            SizedBox(
              height: Adapt.px(58),
              child: GeneralSongTwo(
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
