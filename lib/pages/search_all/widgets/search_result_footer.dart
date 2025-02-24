// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

import '../../../commons/res/app_themes.dart';
import '../../../commons/res/dimens.dart';
import '../../../utils/adapt.dart';

const double SearchResultFooterHeight = 38;

class SearchResultFooter extends StatelessWidget {
  const SearchResultFooter({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SearchResultFooterHeight,
      padding: const EdgeInsets.only(left: 20, right: 20, top: 6),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            text,
            style: TextStyle(
              fontSize: Dimens.font_sp12,
              color: AppThemes.color_114,
              fontWeight: FontWeight.w500,
              fontFamily: W.fonts.IconFonts,
            ),
          ),
          // const Spacer(),
          Divider(
            height: 0.8,
            color: AppThemes.color_150.withOpacity(0.05),
          ),
        ],
      ),
    );
  }
}
