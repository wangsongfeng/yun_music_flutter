// ignore_for_file: constant_identifier_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:yun_music/commons/res/app_themes.dart';
import 'package:yun_music/pages/search/search_controller.dart';
import 'package:yun_music/pages/search/widget/search_appbar.dart';
import 'package:yun_music/utils/adapt.dart';

import '../../../commons/values/function.dart';
import '../../../utils/image_utils.dart';

class CustomTextfiled extends StatelessWidget {
  CustomTextfiled({
    super.key,
    this.onSubmit,
    this.controller,
    required this.searchChange,
    this.onDelegate,
  });

  final WSearchController? controller;

  final Function(String)? onSubmit;

  final ParamSingleCallback<String> searchChange;

  final ParamVoidCallback? onDelegate;

  String regStr =
      "[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]";

  bool autoFocus = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.only(left: 12, right: 12),
      margin: const EdgeInsets.only(right: 8, left: 0),
      constraints: const BoxConstraints(minHeight: 40, maxHeight: 40),
      decoration: BoxDecoration(
        color: AppThemes.search_bg,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Row(
        children: [
          Expanded(
            child: Obx(() {
              return TextField(
                focusNode: controller?.focusNode,
                enabled: true,
                autofocus: autoFocus,
                enableInteractiveSelection: false,
                //禁用menu
                maxLines: 1,
                decoration: InputDecoration(
                    icon: SizedBox(
                      width: 20,
                      height: 20,
                      child: Image.asset(
                        ImageUtils.getImagePath('home_top_bar_search'),
                        color:
                            Get.isDarkMode ? Colors.white : AppThemes.text_gray,
                      ),
                    ),
                    border: InputBorder.none,
                    contentPadding:
                        const EdgeInsets.only(left: -10, right: 0, bottom: 8),
                    hintText: controller?.hintText.value,
                    hintStyle: TextStyle(
                        fontSize: 15,
                        color: Colors.grey,
                        fontFamily: W.fonts.IconFonts,
                        fontWeight: FontWeight.w500)),
                keyboardType: TextInputType.multiline,
                inputFormatters: [
                  FilteringTextInputFormatter.deny(RegExp(regStr))
                ],
                textInputAction: TextInputAction.search,
                onSubmitted: (String str) {
                  if (onSubmit != null) {
                    onSubmit!(str);
                  }
                },
                onChanged: (value) {
                  searchChange.call(value);
                },
                onTap: () {
                  if (onDelegate != null) {
                    onDelegate!.call();
                  }
                },
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: const Color(0xFF333333),
                    fontSize: 15,
                    fontFamily: W.fonts.IconFonts),
                controller: controller?.textEditingController,
                textCapitalization: TextCapitalization.sentences,
              );
            }),
          ),
          if (controller?.appBarType == SearchAppBarType.Result)
            GestureDetector(
              onTap: () {
                if (onDelegate != null) {
                  onDelegate!.call();
                }
              },
              child: Image.asset(
                ImageUtils.getImagePath('cm2_act_btn_del'),
                width: 18,
              ),
            )
        ],
      ),
    );
  }
}
