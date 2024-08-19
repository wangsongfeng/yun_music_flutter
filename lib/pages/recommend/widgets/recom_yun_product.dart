

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yun_music/commons/res/dimens.dart';
import 'package:yun_music/commons/widgets/custom_touch.dart';
import 'package:yun_music/commons/widgets/element_title_widget.dart';
import 'package:yun_music/commons/widgets/network_img_layer.dart';
import 'package:yun_music/pages/recommend/models/creative_model.dart';
import 'package:yun_music/pages/recommend/models/recom_model.dart';
import 'package:yun_music/utils/adapt.dart';
import 'package:yun_music/utils/common_utils.dart';

class RecomYunProduct extends StatelessWidget {
  const RecomYunProduct({
    super.key, 
    required this.blocks, 
    required this.itemHeight});

  final Blocks blocks;

  final double itemHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: itemHeight,
      decoration: BoxDecoration(
        color: context.theme.cardColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ElementTitleWidget(elementModel: blocks.uiElement!),
          const SizedBox(height: 6),
          Expanded(
            child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final creative = blocks.creatives!.elementAt(index);
                  return _item(creative);
                },
                separatorBuilder: (context, index) {
                  return SizedBox(width: Dimens.gap_dp10);
                },
                itemCount: blocks.creatives?.length ?? 0),
          )
        ],
      ),
    );
  }


  Widget _item(CreativeModel creative) {
    return BounceTouch(
      onPressed: () {
      },
      child: SizedBox(
          width: Adapt.px(161),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: NetworkImgLayer(
                  width: Adapt.px(161), 
                  height: Adapt.px(97),
                  src: creative.uiElement?.image?.imageUrl ?? '',
                ),
              ),
              const SizedBox(height: 10),
              Text(
                creative.uiElement?.mainTitle?.title ?? '',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: body1Style(),
              )
            ],
          )),
    );
  }
}