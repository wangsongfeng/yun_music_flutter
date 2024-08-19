import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yun_music/commons/player/player_context.dart';

class PlayerController extends GetxController {
  PageController? pageController;
  final isPlaying = false.obs;

  bool isManual = false;

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> playFromIndex(BuildContext context, int index) async {
    context.playerService.playFromIndex(index);
  }
}
