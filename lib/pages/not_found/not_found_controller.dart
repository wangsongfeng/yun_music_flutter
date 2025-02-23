// ignore_for_file: unnecessary_overrides

import 'package:get/get.dart';

import '../../commons/event/index.dart';
import '../../commons/event/play_bar_event.dart';

class NotFoundController extends GetxController {
  late int selected = 0;
  @override
  void onReady() {
    super.onReady();
    eventBus.fire(PlayBarEvent(PlayBarShowHiddenType.bootom));
  }

  @override
  void onClose() {
    super.onClose();
  }
}
