// ignore_for_file: deprecated_member_use, constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yun_music/commons/res/app_themes.dart';
import 'package:yun_music/commons/values/function.dart';
import 'package:yun_music/utils/adapt.dart';
import 'package:yun_music/utils/common_utils.dart';
import 'package:yun_music/utils/image_utils.dart';

import '../../../commons/res/dimens.dart';

const double SearchResultHeaderHeight = 48;

class SearchResultHeader extends StatelessWidget {
  const SearchResultHeader(
      {super.key, this.title, this.showRightBtn, this.btnTitle, this.callback});

  final String? title;
  final bool? showRightBtn;
  final String? btnTitle;
  final ParamVoidCallback? callback;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      height: SearchResultHeaderHeight,
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(title!, style: headlineStyle()),
            if (showRightBtn!)
              GestureDetector(
                onTap: () {
                  callback?.call();
                },
                child: Container(
                  height: Dimens.gap_dp24,
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  decoration: BoxDecoration(
                      color: context.isDarkMode
                          ? AppThemes.color_217.withOpacity(0.1)
                          : AppThemes.color_217.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(13)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(ImageUtils.getImagePath('icon_play_small'),
                          color: Get.theme.iconTheme.color,
                          width: Dimens.gap_dp12,
                          height: Dimens.gap_dp12),
                      const SizedBox(width: 2),
                      Center(
                        child: Text(btnTitle!,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: Dimens.font_sp12,
                                color: Get.theme.iconTheme.color,
                                fontFamily: W.fonts.PuHuiTiX,
                                fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
