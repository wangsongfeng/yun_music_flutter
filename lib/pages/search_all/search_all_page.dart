import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yun_music/pages/search_all/search_all_controller.dart';
import 'package:yun_music/pages/search_all/widgets/search_result_album.dart';
import 'package:yun_music/pages/search_all/widgets/search_result_playlist.dart';
import 'package:yun_music/pages/search_all/widgets/search_result_simquery.dart';
import 'package:yun_music/pages/search_all/widgets/search_result_single.dart';
import 'package:yun_music/pages/search_all/widgets/search_result_song.dart';
import 'package:yun_music/pages/search_all/widgets/search_result_users.dart';

import '../../commons/widgets/music_loading.dart';
import '../../utils/adapt.dart';
import '../../utils/common_utils.dart';
import '../../vmusic/playing_controller.dart';
import '../search/models/search_result_wrap.dart';
import '../search/search_controller.dart';

class SearchAllPage extends StatefulWidget {
  const SearchAllPage({super.key, required this.searchKey});

  final String searchKey;

  @override
  State<SearchAllPage> createState() => _SearchAllPageState();
}

class _SearchAllPageState extends State<SearchAllPage> {
  late final SearchAllController controller = Get.put(SearchAllController());
  late final WSearchController searchController =
      Get.put(WSearchController(), tag: "result");
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
          if (state!.result != null) {
            return _buildMainContext(state.result!);
          } else {
            return const SizedBox.shrink();
          }
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
    return Padding(
      padding: EdgeInsets.only(
          bottom: PlayingController.to.mediaItems.isNotEmpty
              ? Adapt.tabbar_padding()
              : Adapt.bottomPadding()),
      child: ListView.builder(
        itemBuilder: (context, index) {
          final orders = result.order![index];
          if (orders.contains("song")) {
            return SearchResultSong(
              song: result.song,
              searchKey: controller.searchKey,
            );
          } else if (orders.contains("playList")) {
            return SearchResultPlaylist(
                playList: result.playList, searchKey: controller.searchKey);
          } else if (orders.contains("album")) {
            return SearchResultAlbum(
                album: result.album, searchKey: controller.searchKey);
          } else if (orders.contains("artist")) {
            return SearchResultSingle(
                artist: result.artist, searchKey: controller.searchKey);
          } else if (orders.contains("user")) {
            return SearchResultUsers(
                user: result.user, searchKey: controller.searchKey);
          } else if (orders.contains("sim_query")) {
            return SearchResultSimquery(
              simQuery: result.sim_query,
              searchChange: (String data) {
                controller.searchKey = data;
                controller.resultSearchKey(data);
                searchController.textEditingController.text = data;
              },
            );
          }
          return Container();
        },
        itemCount: result.order!.length,
      ),
    );
  }
}
