// ignore_for_file: constant_identifier_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yun_music/commons/res/app_themes.dart';
import 'package:yun_music/utils/common_utils.dart';
import 'package:yun_music/utils/image_utils.dart';

import '../../../commons/values/function.dart';
import '../../../utils/adapt.dart';
import '../search_controller.dart';
import 'custom_textfiled.dart';

enum SearchAppBarType { Default, Result }

class SearchAppbar extends StatelessWidget implements PreferredSizeWidget {
  SearchAppbar({
    super.key,
    this.type = SearchAppBarType.Default,
    this.onSubmit,
    this.controller,
    this.onDelegate,
  });

  final SearchAppBarType type;

  final Function(String)? onSubmit;

  final ParamVoidCallback? onDelegate;

  late String searchKey = "";

  final WSearchController? controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: Adapt.topPadding()),
      alignment: Alignment.center,
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
              if (text.isEmpty &&
                  (controller!.defuleSearch.value?.showKeyword ?? "").isEmpty) {
                toast("请输入想要搜索的内容");
                return;
              } else if (text.isEmpty &&
                  (controller!.defuleSearch.value?.showKeyword ?? "")
                      .isNotEmpty) {
                if (onSubmit != null) {
                  onSubmit!(
                      (controller!.defuleSearch.value?.showKeyword ?? ""));
                }
                return;
              }
              if (onSubmit != null) {
                onSubmit!(text);
              }
            },
            searchChange: (String data) {
              searchKey = data;
            },
            onDelegate: () {
              if (onDelegate != null) {
                onDelegate!.call();
              }
            },
          )),
          if (type == SearchAppBarType.Default)
            GestureDetector(
              onTap: () {
                if (searchKey.isEmpty &&
                    (controller!.defuleSearch.value?.showKeyword ?? "")
                        .isEmpty) {
                  toast("请输入想要搜索的内容");
                  return;
                } else if (searchKey.isEmpty &&
                    (controller!.defuleSearch.value?.showKeyword ?? "")
                        .isNotEmpty) {
                  if (onSubmit != null) {
                    onSubmit!(
                        (controller!.defuleSearch.value?.showKeyword ?? ""));
                  }
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
          else
            const SizedBox(width: 12)
        ],
      ),
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(Get.theme.appBarTheme.toolbarHeight!);
}
