// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yun_music/commons/models/song_model.dart';
import 'package:yun_music/commons/models/ui_element_model.dart';
import 'package:yun_music/commons/res/app_themes.dart';
import 'package:yun_music/commons/res/dimens.dart';
import 'package:yun_music/commons/values/function.dart';
import 'package:yun_music/commons/widgets/custom_touch.dart';
import 'package:yun_music/commons/widgets/network_img_layer.dart';
import 'package:yun_music/utils/adapt.dart';
import 'package:yun_music/utils/common_utils.dart';
import 'package:yun_music/utils/image_utils.dart';

class GeneralSongTwo extends StatelessWidget {
  const GeneralSongTwo(
      {super.key,
      required this.songInfo,
      required this.uiElementModel,
      this.onPressed});

  final Song songInfo;
  final UiElementModel uiElementModel;
  final ParamVoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return BounceTouch(
      onPressed: () {
        if (onPressed != null) {
          onPressed!.call();
        }
      },
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(
              Radius.circular(8),
            ),
            child: NetworkImgLayer(
              width: Dimens.gap_dp49,
              height: Dimens.gap_dp49,
              src: ImageUtils.getImageUrlFromSize(
                  songInfo.al.picUrl, Size(Dimens.gap_dp49, Dimens.gap_dp49)),
              imageBuilder: (context, provider) {
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    Image(image: provider),
                    Image.asset(ImageUtils.getImagePath('icon_play_small'),
                        width: Dimens.gap_dp20,
                        height: Dimens.gap_dp20,
                        color: Colors.white.withOpacity(0.8))
                  ],
                );
              },
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                child: RichText(
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                    text: uiElementModel.mainTitle?.title.toString(),
                    style: headline1Style(),
                    children: [
                      const WidgetSpan(child: SizedBox(width: 4)),
                      TextSpan(
                        text: '-',
                        style: TextStyle(
                            fontSize: Dimens.font_sp10,
                            color: const Color.fromARGB(255, 166, 166, 166)),
                      ),
                      const WidgetSpan(child: SizedBox(width: 4)),
                      TextSpan(
                        text: songInfo.arString(),
                        style: TextStyle(
                            fontSize: Dimens.font_sp10,
                            color: const Color.fromARGB(255, 166, 166, 166)),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 5),
              _buildSubTitle()
            ],
          )),
        ],
      ),
    );
  }

  Widget _buildSubTitle() {
    if (GetUtils.isNullOrBlank(uiElementModel.subTitle?.title) == true) {
      return const SizedBox.shrink();
    }
    if (uiElementModel.subTitle?.titleType == 'songRcmdTag') {
      return Container(
          height: Adapt.px(13),
          padding: EdgeInsets.only(left: Adapt.px(4), right: Adapt.px(4)),
          decoration: BoxDecoration(
              color: Get.isDarkMode
                  ? Colors.white30
                  : const Color.fromARGB(255, 253, 246, 226),
              borderRadius: BorderRadius.all(Radius.circular(Adapt.px(2)))),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Text(
                uiElementModel.subTitle?.title ?? '',
                style: TextStyle(
                    fontSize: Adapt.px(9),
                    color: Get.isDarkMode
                        ? AppThemes.white
                        : const Color.fromARGB(255, 236, 192, 100)),
              ),
            ],
          ));
    } else {
      return Row(
        children: [
          Row(
            children: getSongTags(songInfo),
          ),
          Text(uiElementModel.subTitle?.title ?? "",
              style: TextStyle(
                  fontSize: Adapt.px(11),
                  color: const Color.fromARGB(255, 166, 166, 166)))
        ],
      );
    }
  }
}
