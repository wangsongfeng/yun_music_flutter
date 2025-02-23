// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yun_music/commons/res/app_themes.dart';
import 'package:yun_music/pages/playlist_detail/playlist_detail_controller.dart';

import '../../../commons/res/dimens.dart';
import '../../../commons/values/constants.dart';
import '../../../utils/adapt.dart';
import '../../../utils/image_utils.dart';
import '../models/playlist_detail_model.dart';

class PlaylistDetailAppbar extends StatefulWidget {
  const PlaylistDetailAppbar(
      {super.key, required this.appBarHeight, required this.controller});

  final double appBarHeight;
  final PlaylistDetailController controller;

  @override
  State<PlaylistDetailAppbar> createState() => _PlaylistDetailAppbarState();
}

class _PlaylistDetailAppbarState extends State<PlaylistDetailAppbar> {
  PlayListTitleStatus _titleStatus = PlayListTitleStatus.Normal;

  @override
  void initState() {
    super.initState();
    widget.controller.titleStatus.listen((p0) {
      Future.delayed(const Duration(milliseconds: 100)).whenComplete(() {
        setState(() {
          _titleStatus = p0;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Obx(() {
          return Container(
            width: Adapt.screenW(),
            height: widget.appBarHeight + Adapt.topPadding(),
            color: widget.controller.headerBgColor.value != null
                ? widget.controller.headerBgColor.value?.withOpacity(0.1)
                : const Color.fromRGBO(146, 150, 160, 0.1),
          );
        }),
        Positioned.fill(
          child: Container(
            padding: EdgeInsets.only(top: Adapt.topPadding()),
            height: widget.appBarHeight,
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                    Get.back();
                  },
                  padding: EdgeInsets.only(left: Dimens.gap_dp2),
                  icon: Image.asset(
                    ImageUtils.getImagePath('dij'),
                    color: AppThemes.white.withOpacity(0.9),
                    width: Dimens.gap_dp25,
                    height: Dimens.gap_dp25,
                  ),
                ),
                Expanded(
                    child: Center(
                  child: Obx(() => _buildTitle(
                      _titleStatus, widget.controller.detail.value)),
                )),
                IconButton(
                  onPressed: () {},
                  padding: EdgeInsets.only(left: Dimens.gap_dp2),
                  icon: Image.asset(
                    ImageUtils.getImagePath('cb'),
                    color: AppThemes.white.withOpacity(0.9),
                    width: Dimens.gap_dp25,
                    height: Dimens.gap_dp25,
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _buildTitle(
      PlayListTitleStatus value, PlaylistDetailModel? detailModel) {
    switch (value) {
      case PlayListTitleStatus.Normal:
        return RichText(
            text: TextSpan(children: [
          if (detailModel?.isOfficial() == true)
            WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: Image.asset(
                  ImageUtils.getImagePath('capture_logo'),
                  width: Dimens.gap_dp20,
                  color: Colors.white,
                )),
          TextSpan(
              text: detailModel?.isOfficial() == true
                  ? ' 官方动态歌单'
                  : detailModel?.getTypename(),
              style: TextStyle(
                  fontSize: Dimens.font_sp17,
                  fontWeight: FontWeight.w600,
                  color: AppThemes.white))
        ]));
      case PlayListTitleStatus.Title:
        return Text(
          detailModel?.playlist.name ?? "",
          style: const TextStyle(
              fontSize: 17, color: Colors.white, fontWeight: FontWeight.w600),
        );
      case PlayListTitleStatus.TitleAndBtn:
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
                child: Text(
              detailModel?.playlist.name ?? "",
              maxLines: 1,
              style: const TextStyle(
                  fontSize: 17,
                  color: Colors.white,
                  fontWeight: FontWeight.w600),
            )),
            Container(
              height: Dimens.gap_dp24,
              margin: EdgeInsets.only(left: Dimens.gap_dp15),
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: Dimens.gap_dp9),
              decoration: BoxDecoration(
                  color: AppThemes.app_main_light,
                  borderRadius: BorderRadius.circular(Dimens.gap_dp12)),
              child: Row(
                children: [
                  Icon(
                    Icons.add,
                    color: Colors.white,
                    size: Dimens.font_sp13,
                  ),
                  Text(
                    '收藏',
                    style: TextStyle(
                        color: Colors.white, fontSize: Dimens.font_sp12),
                  )
                ],
              ),
            )
          ],
        );
    }
  }
}
