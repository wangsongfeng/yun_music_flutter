// ignore_for_file: constant_identifier_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yun_music/commons/res/app_themes.dart';
import 'package:yun_music/utils/common_utils.dart';
import 'package:yun_music/utils/image_utils.dart';

import '../../../utils/adapt.dart';
import '../search_controller.dart';
import 'custom_textfiled.dart';

enum SearchAppBarType { Default, Result }

class SearchAppbar extends StatelessWidget implements PreferredSizeWidget {
  SearchAppbar({
    super.key,
    this.type = SearchAppBarType.Default,
    this.onSubmit,
  });

  final SearchAppBarType type;

  final Function(String)? onSubmit;

  late String searchKey = "";

  final controller = Get.find<WSearchController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: Adapt.topPadding()),
      color: AppThemes.search_page_bg,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 12, right: 12),
            width: 24,
            height: 24,
            child: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Image.asset(
                ImageUtils.getImagePath('icon_back_black'),
                width: 22,
              ),
            ),
          ),
          Expanded(
              child: CustomTextfiled(
            controller: controller,
            onSubmit: (text) {
              if (onSubmit != null) {
                onSubmit!(text);
              }
            },
            searchChange: (String data) {
              searchKey = data;
            },
          )),
          GestureDetector(
            onTap: () {
              if (searchKey.isEmpty) {
                toast("请输入想要搜索的内容");
                return;
              }
              if (onSubmit != null) {
                onSubmit!(searchKey);
              }
            },
            child: Container(
              margin: const EdgeInsets.only(left: 8, right: 16),
              child: const Text(
                "搜索",
                style: TextStyle(fontSize: 15, color: Colors.black),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(Get.theme.appBarTheme.toolbarHeight!);
}
