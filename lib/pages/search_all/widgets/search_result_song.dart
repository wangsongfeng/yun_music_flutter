import 'package:flutter/material.dart';
import 'package:yun_music/pages/search_all/widgets/search_result_header.dart';

import '../../search/models/search_result_wrap.dart';

class SearchResultSong extends StatelessWidget {
  const SearchResultSong({super.key, this.song});
  final SearchComplexSong? song; //单曲
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SearchResultHeader(title: "单曲", showRightBtn: true, btnTitle: "播放")
      ],
    );
  }
}
