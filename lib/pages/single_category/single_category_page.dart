// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yun_music/utils/adapt.dart';

import '../../commons/res/app_themes.dart';
import '../../commons/res/dimens.dart';

class SingleCategoryPage extends StatefulWidget {
  const SingleCategoryPage({super.key});

  @override
  State<SingleCategoryPage> createState() => _SingleCategoryPageState();
}

class _SingleCategoryPageState extends State<SingleCategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          '歌手分类',
          style: TextStyle(
              fontSize: Dimens.font_sp16,
              fontWeight: FontWeight.w600,
              fontFamily: W.fonts.PuHuiTiX,
              color: Get.isDarkMode
                  ? AppThemes.white.withOpacity(0.9)
                  : Colors.black),
        ),
      ),
      body: Container(),
    );
  }
}
