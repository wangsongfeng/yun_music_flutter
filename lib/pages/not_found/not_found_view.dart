// ignore_for_file: use_super_parameters, must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yun_music/pages/not_found/not_found_controller.dart';
import 'package:yun_music/utils/common_utils.dart';

class NotFoundPage extends GetView<NotFoundController> {
  const NotFoundPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final NotFoundController notFoundController = Get.put(NotFoundController());
    notFoundController.selected = 1;
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text(
          '未开发页面',
          style: headline2Style(),
        ),
      ),
    );
  }
}
