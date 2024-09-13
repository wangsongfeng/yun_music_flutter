// ignore_for_file: unnecessary_overrides

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController with GetTickerProviderStateMixin {
  final currentIndex = 0.obs;

  final pageController = PageController();

  final StreamController<bool> homeMenuStream =
      StreamController<bool>.broadcast();

  @override
  void onClose() {
    super.onClose();
  }

  void changePage(int index) {
    currentIndex.value = index;
    pageController.jumpToPage(index);
    if (index == 4) {
      homeMenuStream.add(true);
    } else {
      homeMenuStream.add(false);
    }
  }
}
