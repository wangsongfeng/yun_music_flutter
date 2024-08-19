// ignore_for_file: unnecessary_overrides

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController with GetTickerProviderStateMixin {
  final currentIndex = 0.obs;

  final pageController = PageController();

  @override
  void onClose() {
    super.onClose();
  }

  void changePage(int index) {
    currentIndex.value = index;
    pageController.jumpToPage(index);
  }

}
