import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yun_music/pages/search_all/search_all_controller.dart';
import 'package:yun_music/pages/search_all/widgets/search_result_song.dart';

import '../../commons/widgets/music_loading.dart';
import '../../utils/adapt.dart';
import '../../utils/common_utils.dart';
import '../search/models/search_result_wrap.dart';

class SearchAllPage extends StatefulWidget {
  const SearchAllPage({super.key, required this.searchKey});

  final String searchKey;

  @override
  State<SearchAllPage> createState() => _SearchAllPageState();
}

class _SearchAllPageState extends State<SearchAllPage> {
  late final SearchAllController controller = Get.put(SearchAllController());

  @override
  void initState() {
    super.initState();
    controller.searchKey = widget.searchKey;
    controller.resultSearchKey(widget.searchKey);
  }

  @override
  Widget build(BuildContext context) {
    return controller.obx(
        (state) {
          return _buildMainContext(state!.result!);
        },
        onEmpty: const Text('empty'),
        onError: (err) {
          toast(err.toString());
          return const SizedBox.shrink();
        },
        onLoading: _buildLoading(true));
  }

  Widget _buildLoading(bool needShow) {
    if (needShow) {
      return Container(
        margin: EdgeInsets.only(top: Adapt.px(200)),
        child: MusicLoading(
          axis: Axis.horizontal,
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget _buildMainContext(SearchResultWrap result) {
    return CustomScrollView(
      slivers: [
        if (result.song != null && result.song!.songs!.isNotEmpty)
          SliverToBoxAdapter(child: SearchResultSong(song: result.song))
      ],
    );
  }
}
