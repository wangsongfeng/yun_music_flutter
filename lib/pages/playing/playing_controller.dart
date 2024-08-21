import 'package:get/get.dart';

import '../../commons/models/song_model.dart';
import '../../commons/player/bottom_player_controller.dart';
import '../../commons/player/player_service.dart';

class PlayingController extends GetxController {
  final curPlaying = Rx<Song?>(PlayerService.to.curPlay.value);

  final showNeedle = false.obs;

  @override
  void onClose() {
    print("PlayingController-onClose");
    super.onClose();

    final controller = Get.find<PlayerController>();
    controller.animationController.reverse();
  }
}
