import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:yun_music/commons/res/app_themes.dart';
import 'package:yun_music/pages/playlist_detail/playlist_detail_controller.dart';

import '../../../commons/res/dimens.dart';
import '../../../commons/widgets/round_checkbox.dart';
import '../../../commons/widgets/text_button_icon.dart';
import '../../../utils/common_utils.dart';
import '../../../utils/image_utils.dart';

class PlaylistDetailPlayall extends StatelessWidget
    implements PreferredSizeWidget {
  const PlaylistDetailPlayall({super.key, required this.controller});
  final PlaylistDetailController controller;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.theme.cardColor,
      child: Row(
        children: [Expanded(child: _buildPlayAll(context)), _buildActions()],
      ),
    );
  }

  Widget _buildPlayAll(BuildContext context) {
    return Container(
        height: preferredSize.height,
        padding: EdgeInsets.only(left: Dimens.gap_dp10),
        child: Obx(
          () => Row(
            children: [
              if (controller.showCheck.value)
                //选中时候，全选按钮
                MyTextButtonWithIcon(
                    onPressed: () {
                      if (controller.selectedSong.value?.length !=
                          controller.songs.value?.length) {
                        //未全选中
                        controller.selectedSong.value =
                            List.from(controller.songs.value!);
                      } else {
                        //已全选中
                        controller.selectedSong.value = null;
                      }
                    },
                    gap: Dimens.gap_dp8,
                    icon: RoundCheckBox(
                      const Key('all'),
                      value: controller.selectedSong.value?.length ==
                          controller.songs.value?.length,
                    ),
                    label: Text(
                      '全选',
                      style: headlineStyle()
                          .copyWith(fontWeight: FontWeight.normal),
                    ))
              else
                Row(
                  children: [
                    Container(
                      width: Dimens.gap_dp21,
                      height:
                          controller.detail.value?.playlist.specialType != 200
                              ? Dimens.gap_dp21
                              : Dimens.gap_dp18,
                      padding: EdgeInsets.only(left: Dimens.gap_dp2),
                      decoration: BoxDecoration(
                        color: AppThemes.btn_selectd_color,
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                              controller.detail.value?.playlist.specialType !=
                                      200
                                  ? Dimens.gap_dp12
                                  : Dimens.gap_dp7),
                        ),
                      ),
                      child: Center(
                        child: Image.asset(
                          ImageUtils.getImagePath('icon_play_small'),
                          color: AppThemes.white,
                          width: Dimens.gap_dp12,
                          height: Dimens.gap_dp12,
                        ),
                      ),
                    ),
                    SizedBox(width: Dimens.gap_dp8),
                    RichText(
                      text: TextSpan(
                        text: '播放全部',
                        style: headlineStyle(),
                        children: [
                          WidgetSpan(child: SizedBox(width: Dimens.gap_dp5)),
                          TextSpan(
                              text: '(${controller.itemSize.value ?? 0})',
                              style: TextStyle(
                                  fontSize: Dimens.font_sp12,
                                  color: AppThemes.color_150.withOpacity(0.8)))
                        ],
                      ),
                    ),
                  ],
                ),
              //多选按钮
              Expanded(child: Container()),
              MyTextButtonWithIcon(
                  onPressed: () {
                    controller.showCheck.value = !controller.showCheck.value;
                  },
                  icon: controller.showCheck.value
                      ? Container()
                      : Image.asset(
                          ImageUtils.getImagePath('icn_list_multi'),
                          color: captionStyle().color,
                          width: Dimens.gap_dp16,
                        ),
                  label: !controller.showCheck.value
                      ? Text(
                          '多选',
                          style:
                              body1Style().copyWith(fontSize: Dimens.font_sp15),
                        )
                      : Text(
                          '完成',
                          style: TextStyle(
                              color: AppThemes.app_main_light,
                              fontSize: Dimens.font_sp16),
                        )),
              SizedBox(width: Dimens.gap_dp5)
            ],
          ),
        ));
  }

  Widget _buildActions() {
    return Container();
  }

  @override
  Size get preferredSize => Size.fromHeight(Dimens.gap_dp50);
}
