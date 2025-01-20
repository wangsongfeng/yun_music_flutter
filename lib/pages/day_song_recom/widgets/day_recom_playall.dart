import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yun_music/commons/res/app_themes.dart';
import 'package:yun_music/pages/day_song_recom/controller.dart';
import 'package:yun_music/utils/common_utils.dart';

import '../../../commons/res/dimens.dart';
import '../../../commons/values/function.dart';
import '../../../commons/widgets/round_checkbox.dart';
import '../../../commons/widgets/text_button_icon.dart';
import '../../../delegate/expaned_sliver_delegate.dart';
import '../../../utils/image_utils.dart';

class DayRecomPlayallBtn extends GetView<DaySongRecmController> {
  final ParamVoidCallback? playAllTap;

  const DayRecomPlayallBtn({super.key, this.playAllTap});

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: MySliverDelegate(
        maxHeight: Dimens.gap_dp45,
        minHeight: Dimens.gap_dp45,
        child: Obx(
          () => (GetUtils.isNullOrBlank(controller.items()) == true)
              ? const SizedBox.shrink()
              : Container(
                  color: Get.theme.cardColor,
                  child: Row(
                    children: [
                      if (controller.showCheck.value)
                        Padding(
                          padding: EdgeInsets.only(left: Dimens.gap_dp10),
                          child: MyTextButtonWithIcon(
                              onPressed: () {
                                if (controller.selectedSong.value?.length !=
                                    controller.items().length) {
                                  //未全选中
                                  controller.selectedSong.value =
                                      List.from(controller.items());
                                } else {
                                  //已全选中
                                  controller.selectedSong.value = null;
                                }
                              },
                              gap: Dimens.gap_dp8,
                              icon: RoundCheckBox(
                                const Key('all'),
                                value: controller.selectedSong.value?.length ==
                                    controller.items().length,
                              ),
                              label: Text(
                                '全选',
                                style: headlineStyle()
                                    .copyWith(fontWeight: FontWeight.normal),
                              )),
                        )
                      else
                        Padding(
                            padding: EdgeInsets.only(left: Dimens.gap_dp8),
                            child: MyTextButtonWithIcon(
                                onPressed: playAllTap,
                                gap: Dimens.gap_dp2,
                                icon: Container(
                                  width: Dimens.gap_dp21,
                                  height: Dimens.gap_dp21,
                                  margin:
                                      EdgeInsets.only(right: Dimens.gap_dp6),
                                  padding:
                                      EdgeInsets.only(left: Dimens.gap_dp2),
                                  decoration: BoxDecoration(
                                    color: AppThemes.btn_selectd_color,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(Dimens.gap_dp12),
                                    ),
                                  ),
                                  child: Center(
                                    child: Image.asset(
                                      ImageUtils.getImagePath(
                                          'icon_play_small'),
                                      color: AppThemes.white,
                                      width: Dimens.gap_dp12,
                                      height: Dimens.gap_dp12,
                                    ),
                                  ),
                                ),
                                label: RichText(
                                    text: TextSpan(
                                        text: '播放全部',
                                        style: headlineStyle(),
                                        children: [
                                      WidgetSpan(
                                          child:
                                              SizedBox(width: Dimens.gap_dp5)),
                                      TextSpan(
                                          text:
                                              '(共${controller.items().length}首)',
                                          style: TextStyle(
                                              fontSize: Dimens.font_sp12,
                                              color: AppThemes.color_150
                                                  .withOpacity(0.8)))
                                    ])))),
                      const Expanded(child: SizedBox.shrink()),
                      MyTextButtonWithIcon(
                          onPressed: () {
                            controller.showCheck.value =
                                !controller.showCheck.value;
                          },
                          icon: controller.showCheck.value
                              ? const SizedBox.shrink()
                              : Image.asset(
                                  ImageUtils.getImagePath('icn_list_multi'),
                                  color: captionStyle().color,
                                  width: Dimens.gap_dp16,
                                ),
                          label: !controller.showCheck.value
                              ? Text(
                                  '多选',
                                  style: body1Style()
                                      .copyWith(fontSize: Dimens.font_sp15),
                                )
                              : Text(
                                  '完成',
                                  style: TextStyle(
                                      color: AppThemes.app_main_light,
                                      fontSize: Dimens.font_sp16),
                                )),
                      SizedBox(width: Dimens.gap_dp5),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
