import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yun_music/commons/res/app_themes.dart';
import 'package:yun_music/utils/image_utils.dart';

import '../../../commons/res/dimens.dart';
import 'found_appbar.dart';

class FoundTurnMore extends StatelessWidget {
  const FoundTurnMore({super.key, required this.moreDic, required this.title});

  final List<dynamic> moreDic;

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      padding: EdgeInsets.only(top: Dimens.gap_dp8, bottom: Dimens.gap_dp32),
      child: Column(
        children: [
          FoundSectionTitleView(title: title),
          for (final item in moreDic)
            Container(
              height: Dimens.gap_dp48,
              padding: EdgeInsets.only(left: Dimens.gap_dp16),
              child: Column(
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          item["title"],
                          style: TextStyle(
                              fontSize: Dimens.font_sp13,
                              fontWeight: FontWeight.bold,
                              color: context.isDarkMode
                                  ? Colors.white
                                  : Colors.black.withOpacity(0.87)),
                        ),
                        const SizedBox(width: 2),
                        Image.asset(
                          ImageUtils.getImagePath("cm4_more_icn_arrow"),
                          width: 12,
                          color: context.isDarkMode
                              ? Colors.white
                              : Colors.black.withOpacity(0.87),
                        )
                      ],
                    ),
                  ),
                  if (item["title"] == moreDic.last["title"])
                    const SizedBox.shrink()
                  else
                    Divider(
                        color: context.isDarkMode
                            ? AppThemes.dark_line_color
                            : AppThemes.line_color,
                        height: 0.5)
                ],
              ),
            )
        ],
      ),
    );
  }
}
