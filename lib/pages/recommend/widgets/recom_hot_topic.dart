// ignore_for_file: slash_for_doc_comments

// ignore: dangling_library_doc_comments
/**
 * 热门话题
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yun_music/commons/res/dimens.dart';
import 'package:yun_music/commons/widgets/element_title_widget.dart';
import 'package:yun_music/commons/widgets/network_img_layer.dart';
import 'package:yun_music/pages/recommend/models/creative_model.dart';
import 'package:yun_music/pages/recommend/models/recom_model.dart';
import 'package:yun_music/utils/common_utils.dart';
import 'package:yun_music/utils/image_utils.dart';

import '../../../utils/adapt.dart';

class RecomHotTopic extends StatelessWidget {
  const RecomHotTopic(
      {super.key, required this.blocks, required this.itemHeight});

  final Blocks blocks;

  final double itemHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: itemHeight,
      decoration: BoxDecoration(
        color: context.theme.cardColor,
        borderRadius: BorderRadius.all(Radius.circular(Dimens.gap_dp10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ElementTitleWidget(elementModel: blocks.uiElement!),
          const SizedBox(height: 6),
          Expanded(
            child: Align(
              alignment: Alignment.topLeft,
              child: PageView.builder(
                controller: PageController(viewportFraction: 0.93),
                itemBuilder: (context, index) {
                  return Column(
                    children: _buildPageItems(
                        blocks.creatives!.elementAt(index).resources!),
                  );
                },
                itemCount: blocks.creatives?.length ?? 0,
              ),
            ),
          )
        ],
      ),
    );
  }

  List<Widget> _buildPageItems(List<Resources> list) {
    final widgets = <Widget>[];
    for (final element in list) {
      widgets.add(
        GestureDetector(
          onTap: () {},
          child: Row(
            children: [
              const SizedBox(width: 2),
              NetworkImgLayer(
                width: Dimens.gap_dp14,
                height: Dimens.gap_dp14,
                src: element.uiElement.mainTitle?.titleImgUrl ?? '',
                customplaceholder: Image.asset(
                  ImageUtils.getImagePath('cm7_mlog_detail_topic'),
                  width: Dimens.gap_dp14,
                ),
                imageBuilder: (context, provder) {
                  return Image.asset(
                    ImageUtils.getImagePath('cm7_mlog_detail_topic'),
                    width: Dimens.gap_dp14,
                  );
                },
              ),
              const SizedBox(width: 5),
              Expanded(
                child: Text.rich(
                  TextSpan(children: [
                    TextSpan(
                        text: element.uiElement.mainTitle?.title,
                        style: headline2Style().copyWith(
                          fontFamily: W.fonts.IconFonts,
                          fontWeight: FontWeight.w500,
                        )),
                    if (GetUtils.isNullOrBlank(element.uiElement.labelUrls)! !=
                        true)
                      WidgetSpan(
                          child: Padding(
                        padding: EdgeInsets.only(left: Dimens.gap_dp5),
                        child: NetworkImgLayer(
                          width: Dimens.gap_dp14,
                          height: Dimens.gap_dp14,
                          src: element.uiElement.labelUrls!.elementAt(0),
                        ),
                      ))
                  ]),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 20),
              Text(
                element.uiElement.subTitle?.title ?? '',
                style: captionStyle(),
              ),
              const SizedBox(width: 12),
            ],
          ),
        ),
      );
      widgets.add(const SizedBox(height: 20));
    }
    return widgets;
  }
}
