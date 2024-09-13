import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:yun_music/commons/res/app_themes.dart';
import 'package:yun_music/pages/new_song_album/new_song/new_song_list_controller.dart';
import 'package:yun_music/pages/new_song_album/new_song_album_controller.dart';

import '../../../commons/res/dimens.dart';
import '../../../commons/widgets/round_checkbox.dart';
import '../../../commons/widgets/text_button_icon.dart';
import '../../../utils/common_utils.dart';
import '../../../utils/image_utils.dart';

class NewSongPlayAll extends StatelessWidget {
  const NewSongPlayAll(
      {super.key,
      required this.newSongAlbumController,
      required this.controller});

  final NewSongAlbumController newSongAlbumController;

  final NewSongListController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: Dimens.gap_dp50,
        decoration: BoxDecoration(
            color: Get.isDarkMode ? AppThemes.dark_bg_color : AppThemes.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Dimens.gap_dp16),
                topRight: Radius.circular(Dimens.gap_dp16))),
        child: Obx(() {
          return Row(
            children: [
              if (newSongAlbumController.showCheck.value)
                Padding(
                  padding: EdgeInsets.only(left: Dimens.gap_dp10),
                  child: MyTextButtonWithIcon(
                      onPressed: () {
                        if (newSongAlbumController.selectedSong.value?.length !=
                            controller.items.value?.length) {
                          //未全选中
                          newSongAlbumController.selectedSong.value =
                              List.from(controller.items.value!);
                        } else {
                          //已全选中
                          newSongAlbumController.selectedSong.value = null;
                        }
                      },
                      gap: Dimens.gap_dp8,
                      icon: RoundCheckBox(
                        const Key('all'),
                        value:
                            newSongAlbumController.selectedSong.value?.length ==
                                controller.items.value?.length,
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
                        onPressed: () {},
                        gap: Dimens.gap_dp6,
                        icon: Image.asset(
                          ImageUtils.getImagePath('cm2_list_icn_play'),
                          color: headlineStyle().color,
                          width: Dimens.gap_dp20,
                          height: Dimens.gap_dp20,
                        ),
                        label: RichText(
                            text: TextSpan(
                                text: '播放全部',
                                style: headlineStyle(),
                                children: [
                              WidgetSpan(
                                  child: SizedBox(width: Dimens.gap_dp5)),
                              TextSpan(
                                  text:
                                      '(共${controller.items.value?.length ?? 0}首)',
                                  style: TextStyle(
                                      fontSize: Dimens.font_sp12,
                                      color:
                                          AppThemes.color_150.withOpacity(0.8)))
                            ])))),
              Expanded(child: Container()),
              MyTextButtonWithIcon(
                  onPressed: () {
                    newSongAlbumController.showCheck.value =
                        !newSongAlbumController.showCheck.value;
                  },
                  icon: newSongAlbumController.showCheck.value
                      ? Container()
                      : Image.asset(
                          ImageUtils.getImagePath('icn_list_multi'),
                          color: captionStyle().color,
                          width: Dimens.gap_dp16,
                        ),
                  label: !newSongAlbumController.showCheck.value
                      ? Text(
                          '多选',
                          style:
                              body1Style().copyWith(fontSize: Dimens.font_sp13),
                        )
                      : Text(
                          '完成',
                          style: TextStyle(
                              color: AppThemes.app_main_light,
                              fontSize: Dimens.font_sp16),
                        )),
              SizedBox(width: Dimens.gap_dp5)
            ],
          );
        }));
  }
}
