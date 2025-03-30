// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yun_music/commons/res/app_themes.dart';
import 'package:yun_music/utils/adapt.dart';
import 'package:yun_music/utils/image_utils.dart';

class SearchHeaderTitle extends StatelessWidget {
  const SearchHeaderTitle(
      {super.key, this.text, this.imageName, this.callBack, this.iconW = 18});

  final String? text;
  final String? imageName;
  final Function? callBack;
  final double? iconW;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          text ?? "",
          style: TextStyle(
            fontSize: 14,
            color: context.isDarkMode
                ? Colors.white
                : Colors.black.withOpacity(0.8),
            fontFamily: W.fonts.PuHuiTiX,
            fontWeight: FontWeight.w600,
          ),
        ),
        GestureDetector(
          onTap: () {
            if (callBack != null) {
              callBack!();
            }
          },
          child: Image.asset(
            ImageUtils.getImagePath(imageName!),
            width: iconW,
            height: iconW,
            fit: BoxFit.cover,
            color: AppThemes.textColor999,
          ),
        )
      ],
    );
  }
}
