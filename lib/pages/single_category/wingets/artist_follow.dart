import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yun_music/commons/res/app_themes.dart';

import '../../../commons/res/dimens.dart';
import '../../../commons/values/function.dart';
import '../../../utils/adapt.dart';
import '../../../utils/image_utils.dart';

class ArtistFollow extends StatelessWidget {
  const ArtistFollow(Key? key,
      {required this.id,
      required this.isFollowed,
      this.isSolidWidget = false,
      this.isSinger = true,
      this.isFollowedCallback});

  final String id; //歌手ID
  final bool isFollowed; //是否已经关注
  final bool isSolidWidget; //是否是实心widget
  final bool isSinger; // 是否是歌手
  final ParamSingleCallback<bool>? isFollowedCallback;

  final bool showLoading = false;

  @override
  Widget build(BuildContext context) {
    final txtStyle = TextStyle(
      fontSize: Dimens.font_sp12,
      fontFamily: W.fonts.IconFonts,
      fontWeight: FontWeight.w600,
      color: isFollowed
          ? AppThemes.text_gray
          : isSolidWidget
              ? Colors.white
              : AppThemes.app_main_light,
    );
    return Container(
      decoration: BoxDecoration(
          gradient: isSolidWidget && !isFollowed
              ? const LinearGradient(colors: [
                  Color(0xffec6454),
                  Color(0xffeb5442),
                  Color(0xffea3d2c)
                ])
              : null,
          border: (isSolidWidget && !isFollowed)
              ? null
              : Border.all(
                  color: txtStyle.color!.withOpacity(0.5),
                  width: Dimens.gap_dp1),
          borderRadius: BorderRadius.all(Radius.circular(Adapt.screenH()))),
      child: GestureDetector(
        onTap: () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (showLoading)
              Theme(
                data: ThemeData(
                    cupertinoOverrideTheme: CupertinoThemeData(
                        brightness: isSolidWidget
                            ? Brightness.dark
                            : Get.theme.brightness)),
                child: Padding(
                  padding: EdgeInsets.only(right: Dimens.gap_dp4),
                  child: CupertinoActivityIndicator(
                    radius: Dimens.gap_dp6,
                  ),
                ),
              ),
            if (!showLoading)
              Padding(
                padding:
                    EdgeInsets.only(right: isFollowed ? 0 : Dimens.gap_dp2),
                child: Image.asset(
                  ImageUtils.getImagePath(
                      isFollowed ? 'icn_check' : 'plus_icon'),
                  color: txtStyle.color,
                  width: isFollowed ? Dimens.gap_dp15 : Dimens.gap_dp12,
                ),
              ),
            Text(
              isFollowed ? '已关注' : '关注',
              style: txtStyle.copyWith(
                  fontSize: isFollowed ? Dimens.font_sp12 : Dimens.font_sp12),
            )
          ],
        ),
      ),
    );
  }
}
