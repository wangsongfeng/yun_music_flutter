// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yun_music/commons/res/app_themes.dart';
import 'package:yun_music/commons/res/dimens.dart';
import 'package:yun_music/commons/widgets/custom_touch.dart';
import 'package:yun_music/commons/widgets/element_title_widget.dart';
import 'package:yun_music/commons/widgets/network_img_layer.dart';
import 'package:yun_music/pages/recommend/models/creative_model.dart';
import 'package:yun_music/pages/recommend/models/recom_cale_model.dart';
import 'package:yun_music/pages/recommend/models/recom_model.dart';
import 'package:yun_music/utils/adapt.dart';
import 'package:yun_music/utils/common_utils.dart';
import 'package:yun_music/utils/image_utils.dart';

class RecomMusicCalendar extends StatelessWidget {
  const RecomMusicCalendar(
      {super.key, required this.blocks, required this.itemHeight});

  final Blocks blocks;

  final double itemHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: itemHeight,
      decoration: BoxDecoration(
        color: Get.theme.cardColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Column(
        children: [
          ElementTitleWidget(elementModel: blocks.uiElement!),
          const Divider(
            height: 1,
            color: AppThemes.bg_color,
          ),
          _createItem(blocks.creatives, 0),
          _createItem(blocks.creatives, 1),
        ],
      ),
    );
  }

  Widget _createItem(List<CreativeModel>? creatives, int index) {
    if (GetUtils.isNullOrBlank(creatives) == true) {
      return const SizedBox.shrink();
    }
    if (index <= creatives!.length - 1) {
      return BounceTouch(
          child: Container(
            padding:
                EdgeInsets.only(left: Dimens.gap_dp15, right: Dimens.gap_dp15),
            child: Column(
              children: [
                if (index > 0)
                  const Divider(
                    height: 1,
                    color: AppThemes.bg_color,
                  ),
                _buildItem(creatives.elementAt(index).resources!.elementAt(0))
              ],
            ),
          ),
          onPressed: () {});
    }
    return const SizedBox.shrink();
  }

  Widget _buildItem(Resources resource) {
    final calendar = RecomCaleModel.fromJson(resource.resourceExtInfo);
    return SizedBox(
      height: Adapt.px(66),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RichText(
                  text: TextSpan(
                      text: DateUtils.isSameDay(
                              DateTime.now(),
                              DateTime.fromMillisecondsSinceEpoch(
                                  calendar.startTime))
                          ? '今天'
                          : '明天',
                      style: TextStyle(
                          fontSize: Dimens.font_sp12,
                          color: const Color.fromARGB(255, 166, 166, 166)),
                      children: _buildTags(calendar.tags)),
                ),
                const SizedBox(height: 6),
                Text(
                  resource.uiElement.mainTitle?.title ?? "",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: headline1Style(),
                )
              ],
            ),
          ),
          SizedBox(
            width: Adapt.px(54),
            child: Visibility(
              visible: calendar.canSubscribe,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: Dimens.gap_dp25,
                    height: Dimens.gap_dp25,
                    padding: EdgeInsets.all(Adapt.px(1)),
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.all(Radius.circular(Adapt.px(13))),
                        // color: Colours.app_main,
                        border: Border.all(color: AppThemes.diver_color)),
                    child: Image.asset(
                      ImageUtils.getImagePath('bell'),
                      color: Get.isDarkMode
                          ? AppThemes.card_color.withOpacity(0.7)
                          : AppThemes.dark_card_color.withOpacity(0.7),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '订阅',
                    style: TextStyle(
                        fontSize: Dimens.font_sp10,
                        color: const Color.fromARGB(255, 166, 166, 166)),
                  )
                ],
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (resource.resourceType == 'ALBUM')
                Image.asset(
                  ImageUtils.getImagePath('cqb'),
                  height: Adapt.px(4.5),
                  fit: BoxFit.fill,
                ),
              LayoutBuilder(builder: (context, contarints) {
                return NetworkImgLayer(
                  height: Dimens.gap_dp49,
                  width: Dimens.gap_dp49,
                  src: ImageUtils.getImageUrlFromSize(
                      resource.uiElement.image?.imageUrl,
                      Size(Adapt.px(49), Adapt.px(49))),
                  imageBuilder: (context, provider) {
                    return ClipRRect(
                      borderRadius:
                          BorderRadius.all(Radius.circular(Dimens.gap_dp8)),
                      child: Image(
                        image: provider,
                      ),
                    );
                  },
                );
              })
            ],
          )
        ],
      ),
    );
  }

  List<InlineSpan>? _buildTags(List<String>? tags) {
    if (tags == null) return null;
    final List<InlineSpan> spans = List.empty(growable: true);

    for (final element in tags) {
      spans.add(const WidgetSpan(child: SizedBox(width: 4)));
      spans.add(WidgetSpan(
          child: Container(
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
                    element,
                    style: TextStyle(
                        fontSize: Adapt.px(9),
                        color: Get.isDarkMode
                            ? AppThemes.white
                            : const Color.fromARGB(255, 236, 192, 100)),
                  ),
                ],
              ))));
    }

    return spans;
  }
}
