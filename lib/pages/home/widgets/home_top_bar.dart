
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yun_music/commons/res/app_themes.dart';
import 'package:yun_music/utils/adapt.dart';
import 'package:yun_music/utils/image_utils.dart';

class HomeTopBar extends StatelessWidget implements PreferredSizeWidget{
  const HomeTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Scaffold.of(context).openDrawer(),
      child: Container(
        color: Colors.transparent,
        height: Get.theme.appBarTheme.toolbarHeight,
        width: Get.theme.appBarTheme.toolbarHeight,
        padding: EdgeInsets.only(left: Adapt.px(2),right: Adapt.px(10)),
        margin: EdgeInsets.only(top: context.mediaQueryPadding.top),
        child: Center(
          child: SizedBox(
            height: 24,
            width: 24,
            child: Image.asset(
                ImageUtils.getImagePath('home_top_bar_menus'),
                color: context.isDarkMode
                ? AppThemes.dark_body2_txt_color
                : AppThemes.body2_txt_color,
              ),
          ),
        ),
      ),
    );
  }
  
  @override
  Size get preferredSize => Size.fromHeight(Adapt.px(56));
}