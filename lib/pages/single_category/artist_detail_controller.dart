// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:yun_music/api/artist_api.dart';
import 'package:yun_music/commons/widgets/keep_alive_wrapper.dart';
import 'package:yun_music/pages/single_category/models/artist_detail_wrap.dart';
import 'package:yun_music/utils/adapt.dart';

import '../../utils/common_utils.dart';
import 'artist_song_page.dart';
import 'models/single_list_wrap.dart';

class ArtistDetailController extends GetxController
    with GetTickerProviderStateMixin {
  late String? artistid;

  final artistDetail = Rx<ArtistDetailData?>(null);

  late RxList<Singles>? artistsList = <Singles>[].obs;

  late RxBool loading = false.obs;

  late double artistBgheight = Adapt.px(360.0);

  //图片
  final coverImage = Rx<ImageProvider?>(null);
  final headerBgColor = Rx<Color?>(null);

  final headerHeight = Adapt.px(480.0 - 44.0 - Adapt.topPadding()).obs;

  final cardHeight = Adapt.px(152.0).obs;

  final simitHeight = Adapt.px(142.0);

  //相似歌手收起动画
  Animation<double>? animation;
  AnimationController? animController;
  final animValue = 0.0.obs;

  List<SingerTabModel>? tabs;
  TabController? tabController;

  //判断滑动导航栏颜色的变化
  final appbarMenuTop = false.obs; //是否已滑动到特定位置，返回按钮和more按钮变色
  final appbar_alpha = 0.0.obs;
  final follow_show = false.obs;
  @override
  void dispose() {
    super.dispose();
    animController?.dispose();
    tabController?.dispose();
  }

  @override
  void onReady() {
    super.onReady();

    artistid = Get.arguments["artist_id"].toString();
    requestDataDetail();

    coverImage.listen((p) async {
      final paletteGenerator = await PaletteGenerator.fromImageProvider(p!,
          size: Size(Adapt.screenW() / 2.0, artistBgheight / 2.0),
          region:
              Offset.zero & Size(Adapt.screenW() / 2.0, artistBgheight / 2.0),
          maximumColorCount: 1);
      if (paletteGenerator.colors.isNotEmpty) {
        Future.delayed(const Duration(milliseconds: 0)).whenComplete(() {
          headerBgColor.value = paletteGenerator.dominantColor?.color;
        });
      }
    });
  }

  //
  Future requestDataDetail() async {
    loading.value = true;
    final model = await ArtistApi.requestArtistDetail(artistId: artistid!);
    artistDetail.value = model;

    final list = await ArtistApi.artistSimiList(artistid!);
    artistsList?.value = list!;

    getCardViewHeight();

    _initAnimation();

    initTabs();

    Future.delayed(const Duration(milliseconds: 100)).then((value) {
      loading.value = false;
    });
  }

  void startAnim() {
    if (animController?.isAnimating == true) return;
    if (animValue.value == 0) {
      animController?.forward();
    } else {
      animController?.reverse();
    }
  }

  //获取Card的Height
  void getCardViewHeight() {
    if (artistDetail.value?.showPriMsg == true &&
        artistDetail.value?.user != null) {
      cardHeight.value = Adapt.px(176.0);
    } else {
      cardHeight.value = Adapt.px(152.0);
    }
  }

  void _initAnimation() {
    if (animation == null) {
      animController = AnimationController(
          vsync: this, duration: const Duration(milliseconds: 200));
      animation = Tween(begin: 0.0, end: 1.0).animate(animController!)
        ..addListener(() {
          animValue.value = animation!.value;
        });
    }
  }

  //处理tabs
  void initTabs() {
    tabs ??= List.empty(growable: true);
    tabs!.add(const SingerTabModel(type: SingerTabType.homePage, title: "主页"));
    tabs!.add(const SingerTabModel(type: SingerTabType.songPage, title: "歌曲"));
    tabs!.add(SingerTabModel(
        type: SingerTabType.albumPage, title: "专辑", num: getAlbumSize() ?? 0));
    tabs!.add(SingerTabModel(
        type: SingerTabType.mvPage, title: "专辑", num: getMvSize() ?? 0));
    tabController =
        TabController(length: tabs!.length, vsync: this, initialIndex: 1);
  }

  List<Widget> getTabBarViews() {
    final widgets = List<Widget>.empty(growable: true);
    for (var element in tabs!) {
      switch (element.type) {
        case SingerTabType.homePage:
          widgets.add(const KeepAliveWrapper(child: ArtistSongPage()));
          break;
        case SingerTabType.songPage:
          widgets.add(const KeepAliveWrapper(child: ArtistSongPage()));
          break;
        case SingerTabType.albumPage:
          widgets.add(KeepAliveWrapper(child: Container()));
          break;
        case SingerTabType.mvPage:
          widgets.add(KeepAliveWrapper(child: Container()));
          break;
        case SingerTabType.evenPage:
          widgets.add(KeepAliveWrapper(child: Container()));
          break;
      }
    }
    return widgets;
  }

  int? getAlbumSize() {
    if (artistDetail.value?.artist != null) {
      return artistDetail.value!.artist?.albumSize;
    }
    return 0;
  }

  int? getMvSize() {
    if (artistDetail.value?.artist != null) {
      return artistDetail.value!.artist?.mvSize;
    }
    return 0;
  }

  ///背景图片
  String getArtistHeaderBgUrl() {
    return (artistDetail.value?.showPriMsg == true &&
            artistDetail.value?.user != null)
        ? artistDetail.value?.user?.backgroundUrl ?? ""
        : artistDetail.value?.artist?.cover ?? "";
  }

  String? getAvatarUrl() {
    return (artistDetail.value?.showPriMsg == true
        ? artistDetail.value?.user?.avatarUrl
        : "");
  }

  String? getAliasName() {
    if (artistDetail.value?.artist != null) {
      if (artistDetail.value!.artist?.alias != null) {
        if (artistDetail.value!.artist!.alias!.isNotEmpty) {
          return artistDetail.value?.artist!.alias?.first;
        } else {
          return "";
        }
      } else {
        return "";
      }
    } else {
      return "";
    }
  }

  //粉丝数量
  String getArtistFansCount() {
    return getPlayCountStrFromInt(randomFloatInRange(1000, 1000000));
  }

  //描述
  String? artistDesc() {
    if (artistDetail.value?.identify != null) {
      if (GetUtils.isNullOrBlank(artistDetail.value?.identify?.imageDesc) ==
          false) {
        return artistDetail.value?.identify?.imageDesc;
      } else {
        return "";
      }
    } else {
      return "";
    }
  }
}

class SingerTabModel {
  final SingerTabType type;

  final String title;

  final int? num;

  const SingerTabModel({required this.type, required this.title, this.num});
}

enum SingerTabType {
  homePage,
  songPage,
  albumPage,
  evenPage,
  mvPage,
}
