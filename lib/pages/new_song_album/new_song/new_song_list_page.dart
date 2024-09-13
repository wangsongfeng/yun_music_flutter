import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yun_music/pages/new_song_album/new_song/new_song_list_controller.dart';
import 'package:yun_music/pages/new_song_album/new_song/new_song_play_all.dart';

import '../../../commons/models/song_model.dart';
import '../../../commons/res/dimens.dart';
import '../../../commons/widgets/music_loading.dart';
import '../../../utils/adapt.dart';
import '../../day_song_recom/widgets/check_song_cell.dart';
import '../new_song_album_controller.dart';
import 'new_song_controller.dart';

class NewSongListPage extends StatefulWidget {
  const NewSongListPage(
      {super.key, required this.tagModel, required this.mkey});

  final NewSongTagModel tagModel;

  final String? mkey;

  @override
  State<NewSongListPage> createState() => _NewSongListPageState();
}

class _NewSongListPageState extends State<NewSongListPage>
    with AutomaticKeepAliveClientMixin {
  late ScrollController scrollController;
  late NewSongListController controller;

  late NewSongAlbumController newSongAlbumController;

  final double expandedTop = Adapt.px(146);

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    scrollController.addListener(() => setState(() {}));
    controller = Get.put(NewSongListController(typeId: widget.tagModel.id),
        tag: widget.mkey);

    newSongAlbumController = GetInstance().find<NewSongAlbumController>();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Stack(
      children: [
        CustomScrollView(
          physics: const ClampingScrollPhysics(),
          controller: scrollController,
          slivers: [
            SliverToBoxAdapter(
              child: SizedBox(
                child: Image.asset(
                  widget.tagModel.imgPath,
                  fit: BoxFit.fitWidth,
                  width: Adapt.screenW(),
                ),
              ),
            ),

            //占位
            SliverToBoxAdapter(
              child: SizedBox(
                height: Dimens.gap_dp30,
                child: Container(),
              ),
            ),
            Obx(() => (GetUtils.isNullOrBlank(controller.items.value) == true)
                ? SliverToBoxAdapter(
                    child: Padding(
                    padding: EdgeInsets.only(top: Dimens.gap_dp30),
                    child: MusicLoading(
                      axis: Axis.horizontal,
                    ),
                  ))
                : SliverFixedExtentList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      return _buildItem(
                          context, controller.items.value!.elementAt(index));
                    }, childCount: controller.items.value!.length),
                    itemExtent: Dimens.gap_dp60)),
            //pading bottom
          ],
        ),
        _buildPlayAll()
      ],
    );
  }

  Widget _buildItem(BuildContext context, Song song) {
    return CheckSongCell(
      song: song,
      checkSongController: newSongAlbumController,
      cellClickCallback: (item) {
        if (newSongAlbumController.showCheck.value) {
          //选择打开
          List<Song>? oldList = newSongAlbumController.selectedSong.value;
          if (GetUtils.isNullOrBlank(oldList) != true &&
              oldList?.indexWhere((element) => element.id == item.id) != -1) {
            //已选中
            oldList!.removeWhere((element) => element.id == item.id);
            newSongAlbumController.selectedSong.value = List.from(oldList);
          } else {
            //未选中
            if (oldList == null) {
              oldList = [item];
            } else {
              oldList.add(item);
            }
            newSongAlbumController.selectedSong.value = List.from(oldList);
          }
        } else {
          //点击播放音乐
          controller.playList(context, song: song);
        }
      },
    );
  }

  Widget _buildPlayAll() {
    double top = expandedTop;
    if (scrollController.hasClients) {
      final double offset = scrollController.offset;
      top -= offset > 0 ? offset : 0;
    }
    //悬浮效果
    top = top > 0 ? top : 0;
    return Positioned(
      top: top,
      left: 0,
      right: 0,
      child: NewSongPlayAll(
          newSongAlbumController: newSongAlbumController,
          controller: controller),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
