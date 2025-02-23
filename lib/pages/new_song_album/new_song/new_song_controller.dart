import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/image_utils.dart';

class NewSongController extends GetxController
    with GetTickerProviderStateMixin {
  final tags = <NewSongTagModel>[
    NewSongTagModel(
        name: '全部', id: 0, imgPath: ImageUtils.getImagePath('img_all')),
    NewSongTagModel(
        name: '推荐',
        id: -1,
        imgPath: ImageUtils.getImagePath('img_r_c', format: 'jpg')),
    NewSongTagModel(
        name: '华语',
        id: 7,
        imgPath: ImageUtils.getImagePath('img_z_h', format: 'jpg')),
    NewSongTagModel(
        name: '欧美',
        id: 96,
        imgPath: ImageUtils.getImagePath('img_e_a', format: 'jpg')),
    NewSongTagModel(
        name: '韩国',
        id: 16,
        imgPath: ImageUtils.getImagePath('img_k_r', format: 'jpg')),
    NewSongTagModel(
        name: '日本',
        id: 8,
        imgPath: ImageUtils.getImagePath('img_j_p', format: 'jpg')),
  ];

  late TabController tabController;
  late PageController pageController;

  @override
  void onInit() {
    super.onInit();

    tabController =
        TabController(length: tags.length, vsync: this, initialIndex: 0);
    pageController = PageController(initialPage: 0);
  }
}

class NewSongTagModel {
  final String name;
  final int id;
  final String imgPath;

  const NewSongTagModel(
      {required this.name, required this.id, required this.imgPath});
}
