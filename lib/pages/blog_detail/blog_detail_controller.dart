import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:yun_music/api/music_api.dart';
import 'package:yun_music/pages/blog_detail/models/blog_detail_lists.dart';
import 'package:yun_music/pages/blog_detail/models/blog_detail_model.dart';

import '../../commons/event/index.dart';
import '../../commons/event/play_bar_event.dart';
import '../../commons/res/dimens.dart';
import '../../commons/values/constants.dart';
import '../../utils/adapt.dart';

class BlogDetailController extends GetxController
    with GetTickerProviderStateMixin {
  int? rid;
  String? coverImgUrl;
  int? playcount;

  final List<Tab> myTabs = <Tab>[
    const Tab(text: '声音'),
    const Tab(text: '推荐'),
  ];

  late TabController tabController;
  late PageController pageController;

  final headerBgColor = Rx<Color?>(null);
  //标题状态
  final titleStatus = Rx<PlayListTitleStatus>(PlayListTitleStatus.Normal);
  //图片
  final coverImage = Rx<ImageProvider?>(null);

  final detail = Rx<BlogDetailModel?>(null);

  final indicatorList = <DetailIndicatorModel?>[];

  //是否展示编辑
  final showCheck = false.obs;
  //以选中的歌曲
  final selectedItem = Rx<List<BlogDetailProgramItem>?>(null);

  final detailListModel = Rx<BlogDetailListsModel?>(null);

  final headerHeight = 0.0.obs;

  final scoll_stickBar = false.obs;

  final appBarHeight = (Adapt.px(44) + Adapt.topPadding());

  @override
  void onInit() {
    super.onInit();

    rid = Get.arguments['rid'];
    coverImgUrl = Get.arguments['coverImgUrl'];
    playcount = Get.arguments['playcount'];

    setTabController();
    getHeaderHeight(null);
    scoll_stickBar.value = false;

    coverImage.listen((p) async {
      final paletteGenerator = await PaletteGenerator.fromImageProvider(p!,
          size: const Size(122, 122),
          region: Offset.zero & const Size(122, 122),
          maximumColorCount: 1);
      if (paletteGenerator.colors.isNotEmpty) {
        Future.delayed(const Duration(milliseconds: 0)).whenComplete(() {
          headerBgColor.value = paletteGenerator.dominantColor?.color;
        });
      }
    });
  }

  void getHeaderHeight(BlogDetailModel? model) {
    if (model == null) {
      final height = Dimens.gap_dp6 +
          Adapt.px(44) +
          110 +
          Dimens.gap_dp8 +
          Dimens.gap_dp20 +
          Dimens.gap_dp20 +
          42;
      headerHeight.value = height;
    } else {
      var height = Dimens.gap_dp6 +
          Adapt.px(44) +
          110 +
          Dimens.gap_dp8 +
          Dimens.gap_dp20 +
          Dimens.gap_dp20 +
          42;
      if (model.desc != null) {
        TextPainter textPainter = TextPainter(
            maxLines: 3,
            textAlign: TextAlign.left,
            text: TextSpan(
              text: model.desc,
              style: const TextStyle(color: Color(0xFFDDDDDD), fontSize: 13),
            ),
            textDirection: TextDirection.ltr);

        textPainter.layout(maxWidth: Adapt.screenW() - Dimens.gap_dp30);
        height += (textPainter.height + 20);
      }
      headerHeight.value = height;
    }
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
    pageController.dispose();
  }

  void setTabController() {
    tabController =
        TabController(length: myTabs.length, vsync: this, initialIndex: 0);
    pageController = PageController(initialPage: 0);
  }

  @override
  void onReady() {
    super.onReady();
    eventBus.fire(PlayBarEvent(PlayBarShowHiddenType.bootom));

    _requestDetail();
  }

  void _requestDetail() {
    MusicApi.getBlogDetail(rid.toString()).then((value) {
      if (value?.categoryId != null) {
        DetailIndicatorModel model = DetailIndicatorModel();
        model.id = value?.categoryId;
        model.title = value?.category;
        indicatorList.add(model);
      }
      if (value?.secondCategoryId != null) {
        DetailIndicatorModel model = DetailIndicatorModel();
        model.id = value?.secondCategoryId;
        model.title = value?.secondCategory;
        indicatorList.add(model);
      }
      detail.value = value;

      getHeaderHeight(value);

      _requestList();
    });
  }

  void _requestList() {
    MusicApi.getBlogDetailList(rid.toString(), 100).then((value) {
      if (value != null) {
        detailListModel.value = value;
      }
    });
  }
}
