import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yun_music/commons/player/player_context.dart';
import 'package:yun_music/pages/playing/playing_controller.dart';
import 'package:yun_music/pages/playing/widgets/blur_background.dart';
import 'package:yun_music/pages/playing/widgets/playing_nav_bar.dart';

class PlayingPage extends GetView<PlayingController> {
  const PlayingPage({super.key});

  @override
  Widget build(BuildContext context) {
    controller.showNeedle.value = true;
    return Scaffold(
      backgroundColor: Get.theme.cardColor,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Obx(() {
            return BlurBackground(
              musicCoverUrl: context.curPlayRx.value?.al.picUrl,
            );
          }),
          Material(
            color: Colors.transparent,
            child: Column(
              children: [
                Obx(() {
                  return PlayingNavBar(song: context.curPlayRx.value);
                })
              ],
            ),
          )
        ],
      ),
    );
  }
}
