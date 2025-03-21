import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PlayerController extends GetxController
    with GetSingleTickerProviderStateMixin {
  PageController? pageController;
  final isPlaying = false.obs;

  bool isManual = false;

  late AnimationController animationController;
  late Animation<double> animation;

  @override
  void onInit() {
    super.onInit();

    animationController = AnimationController(
      duration: const Duration(milliseconds: 50), // 动画持续时间
      vsync: this,
    );
    animation = Tween(begin: 1.0, end: 0.0).animate(animationController);
  }
}
