import 'package:flutter/material.dart';
import 'package:yun_music/commons/res/app_themes.dart';
import 'package:yun_music/utils/adapt.dart';
import 'package:yun_music/utils/image_utils.dart';

class SearchResultHeader extends StatelessWidget {
  const SearchResultHeader(
      {super.key, this.title, this.showRightBtn, this.btnTitle});

  final String? title;
  final bool? showRightBtn;
  final String? btnTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      height: 48,
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(title!,
                style: const TextStyle(
                    fontSize: 17,
                    color: Colors.black,
                    fontWeight: FontWeight.bold)),
            if (showRightBtn!)
              Container(
                height: 26,
                padding: const EdgeInsets.only(left: 6, right: 6),
                decoration: BoxDecoration(
                    color: AppThemes.color_217.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(13)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      ImageUtils.getImagePath('act_icn_play'),
                      width: 16,
                      color: Colors.black,
                    ),
                    const SizedBox(width: 3),
                    Center(
                      child: Text(btnTitle!,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.black,
                              fontFamily: W.fonts.PuHuiTiX,
                              fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }
}
