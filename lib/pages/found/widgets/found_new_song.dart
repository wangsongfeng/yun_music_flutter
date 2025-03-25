// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:yun_music/pages/recommend/models/recom_model.dart';

import '../../../commons/res/app_themes.dart';
import '../../../commons/res/dimens.dart';
import '../../../commons/widgets/general_song_two.dart';
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
        FoundNewSongImageWidth * 3 + Dimens.gap_dp8 * 3 + Dimens.gap_dp30;
    return Container(
      color: Colors.transparent,
      padding: EdgeInsets.only(top: Dimens.gap_dp8, bottom: 0),
      height: itemheight,
      child: Column(
        children: [
          FoundSectionTitleView(title: title),
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
        padding: EdgeInsets.only(right: Dimens.gap_dp15),
        child: Column(
          children: [
            if (widgets.isNotEmpty)
              Container(
                margin: EdgeInsets.only(left: FoundNewSongImageWidth),
                child: const Divider(
                  height: 1,
                  color: AppThemes.bg_color,
                ),
              ),
            SizedBox(
              height: FoundNewSongImageWidth,
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
