import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yun_music/pages/splash/splash_controller.dart';
import 'package:yun_music/utils/adapt.dart';
import 'package:yun_music/utils/image_utils.dart';

import '../../commons/res/app_themes.dart';

class SplashPage extends GetView<SplashController> {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    Adapt.initContext(context);
    return Scaffold(
      backgroundColor: AppThemes.app_main,
      body: Container(
        padding: EdgeInsets.only(top: controller.isFirst ? 100 : 255),
        width: Adapt.screenW(),
        height: Adapt.screenH(),
        child: Column(
          children: [
            buildContent()
          ],
        ),
      ),
    );
  }

  Widget buildContent() {
    if (controller.isFirst) {
      return Image.asset(
        'assets/anim/cif.webp',
      );
    } else {
      return Image.asset(
        ImageUtils.getImagePath('erq'),
        height: 94,
        width: 94,
      );
    }
  }
}
