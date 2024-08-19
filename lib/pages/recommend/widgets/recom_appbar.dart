import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yun_music/commons/res/app_themes.dart';
import 'package:yun_music/pages/recommend/recom_controller.dart';
import 'package:yun_music/utils/adapt.dart';
import 'package:yun_music/utils/image_utils.dart';

class RecomAppbar extends StatelessWidget implements PreferredSizeWidget {
  RecomAppbar({super.key});

  final recomController = GetInstance().find<RecomController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: Adapt.topPadding()),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {},
              child: Obx(() => 
                 Container(
                  padding: const EdgeInsets.only(left: 12,right: 12),
                  height: 40,
                  margin: EdgeInsets.only(
                    left: Get.theme.appBarTheme.toolbarHeight!,
                    right: 0),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    color: Get.isDarkMode ? AppThemes.dark_search_bg_color : AppThemes.search_bg_color,
                  ),
                  alignment: Alignment.center,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 20,
                        height: 20,
                        child: Image.asset(
                          ImageUtils.getImagePath('home_top_bar_search'),
                          color: Get.isDarkMode ? Colors.white : AppThemes.text_gray,
                        ),
                      ),
                      const SizedBox(width: 2),
                      Text(
                        recomController.defuleSearch.value?.showKeyword ?? "搜索",
                        style: const TextStyle(
                          color: AppThemes.text_gray,
                          fontSize: 14,
                          fontWeight: FontWeight.w500
                        ),
                      ),

                      const Spacer(),

                      SizedBox(
                        width: 16,
                        height: 16,
                        child: Image.asset(
                          ImageUtils.getImagePath('home_top_bar_scan'),
                          color: Get.isDarkMode ? Colors.white : AppThemes.text_gray,
                        ),
                      ),
                    ],
                  ),
                 )
              ),
            ),
          ),

          GestureDetector(
            child: Container(
              color: Colors.transparent,
              width: Get.theme.appBarTheme.toolbarHeight,
              height: Get.theme.appBarTheme.toolbarHeight,
              child: Center(
                child: SizedBox(
                  width: 28,
                  height: 28,
                  child: Image.asset(
                    ImageUtils.getImagePath('home_top_bar_voice'),
                    color: Get.isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(Get.theme.appBarTheme.toolbarHeight!);
}
