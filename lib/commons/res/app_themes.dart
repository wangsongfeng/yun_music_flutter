// ignore_for_file: constant_identifier_names, non_constant_identifier_names, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppThemes {
  AppThemes._();
  static const Color app_main = Color.fromRGBO(203, 63, 46, 1);
  static const Color app_main_light = Color.fromARGB(255, 235, 77, 68);

  static const Color tab_color = Color.fromRGBO(236, 67, 94, 1);
  static const Color tab_grey_color = Color.fromRGBO(104, 110, 125, 1);

  static const Color tab_bg_color = Color.fromRGBO(255, 255, 255, 1);
  static const Color dark_tab_bg_color = Color.fromRGBO(29, 29, 35, 1.0);

  static const Color bg_color = Color.fromARGB(255, 245, 246, 249);
  static const Color dark_bg_color = Color.fromARGB(255, 13, 13, 12);

  static const Color search_bg_color = Color.fromARGB(255, 235, 237, 241);
  static const Color dark_search_bg_color = Color.fromARGB(255, 28, 27, 32);

  static const Color diver_color = Color.fromARGB(178, 224, 224, 224);
  static const Color dark_diver_color = Color.fromARGB(10, 255, 255, 255);

  static const Color line_color = Color.fromRGBO(45, 46, 49, 0.06);
  static const Color dark_line_color = Color.fromRGBO(45, 46, 49, 0.2);

  static const Color card_color = Color.fromARGB(255, 244, 246, 249);
  static const Color dark_card_color = Color.fromARGB(255, 13, 13, 18);

  static const Color headline4_color = Color.fromARGB(255, 39, 38, 40);
  static const Color dark_headline4_color = Color.fromARGB(255, 254, 254, 254);

  static const Color headline1_color = Color.fromARGB(255, 40, 40, 42);
  static const Color dark_headline1_color = Color.fromARGB(255, 254, 254, 254);

  static const Color body1_txt_color = Color.fromARGB(255, 49, 49, 50);
  static Color dark_body1_txt_color = Colors.white.withOpacity(0.95);

  static const Color body2_txt_color = Color.fromARGB(255, 41, 50, 70);
  static Color dark_body2_txt_color = Colors.white.withOpacity(0.95);

  static const rank_list_bg_color = Color(0xFFF4F7FA);

  static const Color subtitle_color = Color(0xFFafafaf);

  static const Color shadow_color = Color.fromRGBO(235, 237, 242, 0.5);
  static const Color shadow_color_dark = Color(0x61000000);

  static Color indicator_color = const Color.fromARGB(255, 235, 80, 72);

  static Color btn_border_color = const Color(0xFFf3928d);

  static const Color blue = Color.fromARGB(255, 90, 124, 170);
  static const Color blue_dark = Color.fromARGB(255, 77, 147, 215);

  static const Color pink = Color.fromARGB(255, 239, 210, 210);

  static const Color white = Color(0xFFFFFFFF);
  static const Color white_dark = Color(0xFFF0F0F0);

  static const Color text_label_gray = Color.fromARGB(255, 179, 179, 179);
  static const Color text_dark_label_gray = Color.fromARGB(255, 207, 207, 207);

  static const Color subtitle_text = Color.fromARGB(220, 111, 111, 111);
  static Color dark_subtitle_text = Colors.white.withOpacity(0.65);

  static const Color icon_color = Color.fromARGB(255, 39, 39, 39);
  static Color dark_icon_color = Colors.white.withOpacity(0.85);

  /// 深色背景
  static const Color back1 = Color(0xff1D1F22);

  /// 比深色背景略深一点
  static const Color back2 = Color(0xff121314);

  static const Color label_bg = Color.fromARGB(200, 239, 239, 239);
  static const Color label_bg_dark = Colors.transparent;

  static const Color btn_selectd_color = Color.fromARGB(255, 225, 53, 52);
  static const Color btn_selectd_color_dark = Color.fromARGB(255, 97, 26, 26);

  static const Color text_gray = Color.fromARGB(255, 191, 190, 191);

  static const Color color_66 = Color.fromARGB(255, 66, 66, 66);

  static const Color color_109 = Color.fromARGB(255, 109, 109, 109);

  static const Color color_245 = Color.fromARGB(255, 245, 245, 245);

  static const Color color_163 = Color.fromARGB(255, 163, 163, 163);

  static const Color color_150 = Color.fromARGB(255, 150, 150, 150);

  static const Color color_156 = Color.fromARGB(255, 156, 156, 156);

  static const Color color_173 = Color.fromARGB(255, 173, 173, 173);

  static const Color color_177 = Color.fromARGB(255, 177, 177, 177);

  static const Color color_187 = Color.fromARGB(255, 187, 187, 187);

  static const Color color_195 = Color.fromARGB(255, 195, 195, 195);

  static const Color color_189 = Color.fromARGB(255, 189, 189, 189);

  static const Color color_215 = Color.fromARGB(255, 215, 215, 215);

  static const Color color_217 = Color.fromARGB(255, 217, 217, 217);

  static const Color color_228 = Color.fromARGB(255, 228, 228, 228);

  static const Color color_242 = Color.fromARGB(255, 242, 242, 242);

  static const Color color_250 = Color.fromARGB(255, 250, 250, 250);

  static const Color color_237 = Color.fromARGB(255, 237, 237, 237);

  static const Color color_128 = Color.fromARGB(255, 128, 128, 128);

  static const Color color_114 = Color.fromARGB(255, 114, 114, 114);

  static const Color color_165 = Color.fromARGB(255, 165, 165, 165);

  static const Color color_204 = Color.fromARGB(255, 204, 204, 204);

  static const Color black_15 = Color(0x26000000);

  static const Color c_30353e = Color(0xff30353e);

  static const Color search_page_bg = Color.fromARGB(255, 248, 249, 252);

  static const Color search_bg = Color.fromARGB(255, 237, 238, 241);

  static Color load_image_placeholder() =>
      Get.isDarkMode ? white.withOpacity(0.05) : color_245;

  static const textColor999 = Color(0xFF999999);

  static const textColor333 = Color(0xFF333333);

  static const textColor666 = Color(0xFF666666);

  static const Color search_parse_color = Color.fromARGB(255, 88, 121, 167);
}
