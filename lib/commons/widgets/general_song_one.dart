// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:yun_music/commons/models/song_model.dart';
import 'package:yun_music/commons/models/ui_element_model.dart';
import 'package:yun_music/commons/res/dimens.dart';
import 'package:yun_music/commons/values/function.dart';
import 'package:yun_music/commons/widgets/custom_touch.dart';
import 'package:yun_music/commons/widgets/network_img_layer.dart';
import 'package:yun_music/utils/adapt.dart';
import 'package:yun_music/utils/common_utils.dart';
import 'package:yun_music/utils/image_utils.dart';

class GeneralSongOne extends StatelessWidget {
  final Song songInfo;
  final UiElementModel uiElementModel;

  final ParamVoidCallback? onPressed;

  const GeneralSongOne(
      {super.key,
      required this.songInfo,
      required this.uiElementModel,
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    return BounceTouch(
      onPressed: () {
        if (onPressed == null) {
        } else {
          onPressed!.call();
        }
      },
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(Dimens.gap_dp8)),
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
          SizedBox(width: Dimens.gap_dp9),
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
                        WidgetSpan(child: SizedBox(width: Dimens.gap_dp4)),
                        TextSpan(
                          text: '-',
                          style: TextStyle(
                              fontSize: Dimens.font_sp10,
                              color: const Color.fromARGB(255, 166, 166, 166)),
                        ),
                        WidgetSpan(child: SizedBox(width: Dimens.gap_dp4)),
                        TextSpan(
                          text: songInfo.arString(),
                          style: TextStyle(
                              fontSize: Dimens.font_sp10,
                              color: const Color.fromARGB(255, 166, 166, 166)),
                        ),
                      ],
                    )),
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  Row(
                    children: getSongTags(songInfo),
                  ),
                  Expanded(
                      child: Text(uiElementModel.subTitle?.title ?? "",
                          maxLines: 1,
                          style: TextStyle(
                              fontSize: Adapt.px(11),
                              color: const Color.fromARGB(255, 166, 166, 166))))
                ],
              )
            ],
          ))
        ],
      ),
    );
  }
}
