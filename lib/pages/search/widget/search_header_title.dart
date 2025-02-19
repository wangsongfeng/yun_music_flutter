import 'package:flutter/material.dart';
import 'package:yun_music/commons/res/app_themes.dart';
import 'package:yun_music/utils/adapt.dart';
import 'package:yun_music/utils/image_utils.dart';

class SearchHeaderTitle extends StatelessWidget {
  const SearchHeaderTitle(
      {super.key, this.text, this.imageName, this.callBack});

  final String? text;
  final String? imageName;
  final Function? callBack;

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
            color: Colors.black.withOpacity(0.8),
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
            width: 18,
            height: 18,
            fit: BoxFit.cover,
            color: AppThemes.textColor999,
          ),
        )
      ],
    );
  }
}
