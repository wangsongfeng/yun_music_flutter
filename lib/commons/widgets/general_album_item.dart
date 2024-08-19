

import 'package:flutter/material.dart';
import 'package:yun_music/commons/models/song_model.dart';
import 'package:yun_music/commons/models/ui_element_model.dart';
import 'package:yun_music/commons/res/dimens.dart';
import 'package:yun_music/commons/widgets/custom_touch.dart';
import 'package:yun_music/commons/widgets/network_img_layer.dart';
import 'package:yun_music/utils/adapt.dart';
import 'package:yun_music/utils/common_utils.dart';
import 'package:yun_music/utils/image_utils.dart';

class GeneralAlbumItem extends StatelessWidget {
  final List<Ar> artists;
  final UiElementModel uiElementModel;
  final String action;

  const GeneralAlbumItem(
      {super.key, required this.artists,
      required this.uiElementModel,
      required this.action});

  @override
  Widget build(BuildContext context) {
    return BounceTouch(
      onPressed: () {

      },
      child: Row(
        children: [
          Column(
            children: [
              Image.asset(
                ImageUtils.getImagePath('cqb'),
                height: Adapt.px(4.5),
                fit: BoxFit.fill,
              ),
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(Dimens.gap_dp8)),
                child: NetworkImgLayer(
                  width: Dimens.gap_dp49, 
                  height: Dimens.gap_dp49,
                  src: ImageUtils.getImageUrlFromSize(
                      uiElementModel.image?.imageUrl,
                      Size(Dimens.gap_dp49, Dimens.gap_dp49)),
                ),
                  
              )
            ],
          ),
          SizedBox(width: Dimens.gap_dp9),
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
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
                        text: artists
                            .map((e) => e.name)
                            .toList()
                            .reduce((value, element) => '$value/$element')
                            .toString(),
                        style: TextStyle(
                          fontSize: Dimens.font_sp10,
                          color: const Color.fromARGB(255, 166, 166, 166),
                        ),
                      ),
                    ],
                  )),

                  const SizedBox(height: 5),
              if (uiElementModel.subTitle?.title != null)
                Text(
                  uiElementModel.subTitle!.title!,
                  style: TextStyle(
                    fontSize: Adapt.px(11),
                    color: const Color.fromARGB(255, 166, 166, 166),
                  ),
                )
            ],
          ))
        ],
      ),
    );
  }
}
