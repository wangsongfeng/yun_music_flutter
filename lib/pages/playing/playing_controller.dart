import 'package:get/get.dart';

import '../../commons/player/bottom_player_controller.dart';

class PlayingController extends GetxController {
  final showNeedle = false.obs;

  @override
  void onClose() {
    print("PlayingController-onClose");
    super.onClose();

    final controller = Get.find<PlayerController>();
    controller.animationController.reverse();
  }
}
