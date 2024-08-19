import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../utils/common_utils.dart';

class SplashController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final bool isFirst = box.read<bool>('isFirst') ?? true;

  @override
  void onInit() {
    super.onInit();
    //需要展示状态栏Top
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top]);
  }

  @override
  Future<void> onReady() async {
    super.onReady();
    await Future.delayed(Duration(milliseconds: isFirst ? 6000 : 2000));

    toHome();
  }

  @override
  void onClose() {
    super.onClose();
    //需要展示状态栏Top ,Bottom
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top]);
  }

  void toHome() {
    box.write('isFirst', false);
    Get.offAllNamed('/home');
  }
}
