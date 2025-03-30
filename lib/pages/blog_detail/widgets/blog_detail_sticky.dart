import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yun_music/pages/blog_detail/blog_detail_controller.dart';
import 'package:yun_music/utils/image_utils.dart';

import '../../../commons/res/app_themes.dart';
import '../../../commons/res/dimens.dart';
import '../../../commons/skeleton/custom_underline_indicator.dart';
import '../../../commons/widgets/round_checkbox.dart';
import '../../../commons/widgets/text_button_icon.dart';
import '../../../utils/common_utils.dart';

class BlogDetailSticky extends StatelessWidget {
  const BlogDetailSticky({super.key, required this.controller});

  final BlogDetailController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Get.theme.cardColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (controller.showCheck.value)
            //选中时候，全选按钮
            MyTextButtonWithIcon(
                onPressed: () {},
                gap: Dimens.gap_dp8,
                icon: RoundCheckBox(
                  const Key('all'),
                  value: controller.selectedItem.value?.length ==
                      controller.detailListModel.value!.programs?.length,
                ),
                label: Text(
                  '全选',
                  style:
                      headlineStyle().copyWith(fontWeight: FontWeight.normal),
                ))
          else
            TabBar(
              controller: controller.tabController,
              tabs: controller.myTabs,
              padding: EdgeInsets.only(top: Dimens.gap_dp6),
              labelPadding: EdgeInsets.only(
                  left: Dimens.gap_dp16, right: Dimens.gap_dp12),
              isScrollable: true,
              labelStyle: TextStyle(
                  fontSize: Dimens.font_sp14, fontWeight: FontWeight.w600),
              dividerColor: Colors.transparent,
              indicatorColor: AppThemes.indicator_color,
              unselectedLabelColor: context.isDarkMode
                  ? const Color.fromARGB(255, 188, 188, 189)
                  : const Color.fromARGB(255, 114, 114, 114),
              labelColor: context.isDarkMode
                  ? const Color.fromARGB(255, 236, 236, 237)
                  : const Color.fromARGB(255, 51, 51, 51),
              indicator: CustomUnderlineTabIndicator(
                  width: 0.0,
                  borderSide: BorderSide(
                    width: 6,
                    color: AppThemes.indicator_color,
                  ),
                  strokeCap: StrokeCap.round),
              indicatorPadding:
                  EdgeInsets.only(bottom: Dimens.gap_dp9, top: Dimens.gap_dp21),
              indicatorSize: TabBarIndicatorSize.label,
              overlayColor: WidgetStateProperty.all(Colors.transparent),
              enableFeedback: true,
              splashBorderRadius: BorderRadius.circular(10),
              tabAlignment: TabAlignment.center,
              onTap: (value) {
                controller.pageController.animateToPage(value,
                    duration: const Duration(milliseconds: 100),
                    curve: Curves.easeIn);
              },
            ),

          const Expanded(child: SizedBox.shrink()),

          if (controller.showCheck.value)
            TextButton(
                onPressed: () {},
                child: Text(
                  '完成',
                  style: TextStyle(
                      color: AppThemes.app_main_light,
                      fontSize: Dimens.font_sp16),
                ))
          else
            IconButton(
                onPressed: () {},
                icon: Image.asset(
                  ImageUtils.getImagePath('cm8_voicelist_icon_sort_desc'),
                  width: 20,
                  color: context.isDarkMode ? Colors.white : Colors.black,
                )),

          IconButton(
              onPressed: () {},
              icon: Image.asset(
                ImageUtils.getImagePath('cm8_mlog_playlist_multi'),
                width: 20,
                color: context.isDarkMode ? Colors.white : Colors.black,
              )),

          // "cm8_mlog_playlist_multi
          //cm8_voicelist_icon_sort_desc
        ],
      ),
    );
  }
}
