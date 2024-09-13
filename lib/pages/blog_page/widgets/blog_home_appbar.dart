import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../commons/res/app_themes.dart';
import '../../../utils/adapt.dart';
import '../../../utils/image_utils.dart';

class BlogHomeAppbar extends StatelessWidget implements PreferredSizeWidget {
  const BlogHomeAppbar({super.key});

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
                child: Container(
                  padding: const EdgeInsets.only(left: 12, right: 12),
                  height: 40,
                  margin: EdgeInsets.only(
                      left: Get.theme.appBarTheme.toolbarHeight!, right: 0),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    color: Get.isDarkMode
                        ? AppThemes.dark_search_bg_color
                        : AppThemes.search_bg_color,
                  ),
                  alignment: Alignment.center,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 20,
                        height: 20,
                        child: Image.asset(
                          ImageUtils.getImagePath('home_top_bar_search'),
                          color: Get.isDarkMode
                              ? Colors.white
                              : AppThemes.text_gray,
                        ),
                      ),
                      const SizedBox(width: 2),
                      const Text(
                        "搜索",
                        style: TextStyle(
                            color: AppThemes.text_gray,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                      const Spacer(),
                      SizedBox(
                        width: 16,
                        height: 16,
                        child: Image.asset(
                          ImageUtils.getImagePath('home_top_bar_scan'),
                          color: Get.isDarkMode
                              ? Colors.white
                              : AppThemes.text_gray,
                        ),
                      ),
                    ],
                  ),
                )),
          ),
          GestureDetector(
            child: Container(
              color: Colors.transparent,
              width: Get.theme.appBarTheme.toolbarHeight,
              height: Get.theme.appBarTheme.toolbarHeight,
              child: Center(
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  child: Container(
                    color: AppThemes.app_main,
                    child: SizedBox(
                      width: 30,
                      height: 30,
                      child: Image.asset(
                        ImageUtils.getImagePath('cm4_applewatch_add_btn'),
                        color: Colors.white,
                      ),
                    ),
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
