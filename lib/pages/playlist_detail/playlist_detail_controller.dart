// ignore_for_file: non_constant_identifier_names

import 'dart:async';

import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:yun_music/api/bujuan_api.dart';
import 'package:yun_music/api/music_api.dart';

import '../../commons/event/index.dart';
import '../../commons/event/play_bar_event.dart';
import '../../commons/models/song_model.dart';
import '../../commons/res/dimens.dart';
import '../../commons/values/constants.dart';
import '../../commons/values/server.dart';
import '../../utils/adapt.dart';
import '../../utils/common_utils.dart';
import '../../vmusic/playing_controller.dart';
import 'models/playlist_detail_model.dart';

class PlaylistDetailController extends GetxController {
  String playlistId = ''; //歌单ID
  String autoplay = '0'; //自动播放 0否
  late double expandedHeight;
//top content info key
  final GlobalKey topContentKey = GlobalKey();

  //appbar key
  final GlobalKey appBarKey = GlobalKey();

//歌单详情
  final detail = Rx<PlaylistDetailModel?>(null);

  //图片
  final coverImage = Rx<ImageProvider?>(null);

  //标题状态
  final titleStatus = Rx<PlayListTitleStatus>(PlayListTitleStatus.Normal);

  //是否是官方歌单
  final isOfficial = false.obs;

  //全部歌曲集合
  final songs = Rx<List<Song>?>(null);

  Rx<List<MediaItem>> mediaSongs = Rx<List<MediaItem>>(<MediaItem>[]);

  //是否展示编辑
  final showCheck = false.obs;
  //已选中的歌曲
  final selectedSong = Rx<List<Song>?>(null);

  final itemSize = Rx<int?>(null);

  //是否是第二次打开官方歌单
  bool secondOpenOfficial = false;

  final headerBgColor = Rx<Color?>(null);

  final headerBgHeight = 0.0.obs;

  //是否是垂直滑动
  bool isVerticalMove = false;
  //初始坐标
  double initialDy = 0;
  double initialDx = 0;

  late double extraPicHeight;
  late BoxFit fitType;
  late double prev_dy;

  double header_top = (Adapt.topPadding() + Dimens.gap_dp58);
  double cover_width = Dimens.gap_dp122;

  @override
  void onInit() {
    super.onInit();

    playlistId = Get.parameters['id'] ?? "";
    autoplay = Get.parameters['autoplay'] ?? "";
    secondOpenOfficial = box.read<bool>(playlistId) ?? false;

    fitType = BoxFit.fitWidth;
    extraPicHeight = 0;
    prev_dy = 0;

    expandedHeight = secondOpenOfficial
        ? Adapt.screenH() * 0.55
        : (header_top + cover_width + 4 + Dimens.gap_dp50);
    headerBgHeight.value = expandedHeight;

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light,
    ));
    coverImage.listen((p) async {
      final paletteGenerator = await PaletteGenerator.fromImageProvider(p!,
          size: Size(cover_width, cover_width),
          region: Offset.zero & Size(cover_width, cover_width),
          maximumColorCount: 1);
      if (paletteGenerator.colors.isNotEmpty) {
        Future.delayed(const Duration(milliseconds: 0)).whenComplete(() {
          headerBgColor.value = paletteGenerator.dominantColor?.color;
        });
      }
    });
  }

  @override
  InternalFinalCallback<void> get onDelete =>
      InternalFinalCallback(callback: () {
        SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.light,
        ));
      });

  @override
  void onReady() {
    super.onReady();
    eventBus.fire(PlayBarEvent(PlayBarShowHiddenType.bootom));
    _getDetail();
  }

  Future<void> _getDetail({bool showLoading = false}) async {
    if (showLoading) EasyLoading.show();

    // final detailModel = await MusicApi.getPlaylistDetail(playlistId);

    final detailModel = await BujuanApi.playListDetail(playlistId);
    if (detailModel?.isOfficial() == true) {
      //官方歌单
      isOfficial.value = true;
      box.write(playlistId, true);
    }
    if (detailModel?.playlist.specialType == 200 &&
        GetUtils.isNullOrBlank(detailModel?.playlist.videos) != true) {
      //视频歌单
      detail.value = detailModel;
      itemSize.value = detailModel!.playlist.videos!.length;
    } else {
      await _getTracks(detailModel);
    }
    EasyLoading.dismiss();
  }

  //音乐歌单
  Future<void> _getTracks(PlaylistDetailModel? detailModel) async {
    List<Song>? result;
    if (detailModel?.playlist.trackIds.length !=
        detailModel?.playlist.tracks.length) {
      //歌曲数量和歌曲ID不一致,请求全部歌曲{id,id}
      //如果ids>1000分批请求
      final idLength = detailModel!.playlist.trackIds.length;
      if (idLength > 1000) {
        for (var i = 0; i < (idLength / 1000).ceil(); i++) {
          final start = 1000 * i;
          int end = 1000 * (i + 1);
          end = end > idLength + 1 ? idLength : end;
          final idList = detailModel.playlist.trackIds
              .getRange(start, end)
              .map((e) => e.id.toString());
          final ids = idList.reduce((value, element) => '$value,$element');
          final data = await MusicApi.getSongsInfo(ids);
          result ??= List.empty(growable: true);
          result.addAll(data!);

          logger.d(
              'id length = ${idList.length} request length = ${data.length} result lenght = ${result.length}');
        }
      } else {
        //小于一千 直接请求
        // final ids = detailModel.playlist.trackIds
        //     .map((e) => e.id.toString())
        //     .reduce((value, element) => '$value,$element');
        // result = await MusicApi.getSongsInfo(ids);

        List<String> newIds =
            detailModel.playlist.trackIds.map((e) => e.id.toString()).toList();
        result = await BujuanApi.getSongsInfo(newIds);
      }
    } else {
      result = detailModel?.playlist.tracks;
    }
    detail.value = detailModel;
    songs.value = result;
    itemSize.value = result?.length;

    mediaSongs.value = PlayingController.to.songToMediaItem(songs.value!);
  }

  double clipOffset() {
    double offset = 0.0;
    final RenderBox? barRender =
        appBarKey.currentContext?.findRenderObject() as RenderBox?;

    final RenderBox? contentRender =
        topContentKey.currentContext?.findRenderObject() as RenderBox?;

    if (barRender != null && contentRender != null) {
      final barUnderY = barRender
          .localToGlobal(Offset(0.0, barRender.size.height))
          .dy; //bar的底部的Y坐标
      final contentTopY =
          contentRender.localToGlobal(Offset.zero).dy; //内容的顶部Y坐标
      // Get.log('barUnderY = $barUnderY  contentTopY = $contentTopY');
      if (contentTopY <= barUnderY) {
        //内容超过了appbar的底部区域 裁剪
        offset = barUnderY - contentTopY;
      } else {
        offset = 0.0;
      }
    }
    return offset;
  }

  void playList(BuildContext context, {Song? song}) {}
}
