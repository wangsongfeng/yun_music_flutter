// ignore_for_file: deprecated_member_use, avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yun_music/commons/res/app_themes.dart';

import '../../utils/common_utils.dart';

class SFThemes {
  static final lightTheme = ThemeData.light().copyWith(
    scaffoldBackgroundColor: AppThemes.card_color,
    dividerColor: AppThemes.diver_color,
    shadowColor: AppThemes.shadow_color,
    iconTheme: const IconThemeData(color: AppThemes.icon_color, size: 15),
    highlightColor: AppThemes.blue,
    hintColor: Colors.grey.shade300,
    cardColor: AppThemes.card_color,
    appBarTheme: const AppBarTheme(
      toolbarHeight: kToolbarHeight,
      backgroundColor: AppThemes.card_color,
      surfaceTintColor: Colors.transparent,
      titleTextStyle: TextStyle(
          color: AppThemes.body2_txt_color,
          fontSize: 17.0,
          fontWeight: FontWeight.w600),
      elevation: 0,
    ),
    dialogTheme: const DialogThemeData(
        backgroundColor: Colors.black87,
        elevation: 24.0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(14.0)))),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        color: AppThemes.headline1_color,
        fontSize: 13,
        fontWeight: FontWeight.w500,
      ),
      displayMedium: TextStyle(
        color: AppThemes.headline1_color,
        fontSize: 15,
        fontWeight: FontWeight.w500,
      ),
      titleMedium: TextStyle(
        color: AppThemes.headline4_color,
        fontSize: 17,
        fontWeight: FontWeight.w600,
      ),
      bodyLarge: TextStyle(
        color: AppThemes.body1_txt_color,
        fontSize: 13,
        fontWeight: FontWeight.normal,
      ),
      bodyMedium: TextStyle(
        color: AppThemes.body2_txt_color,
        fontSize: 16,
        fontWeight: FontWeight.normal,
      ),
      bodySmall: TextStyle(
        color: AppThemes.subtitle_text,
        fontSize: 12,
      ),
    ),
  );

  static final darkTheme = ThemeData.dark().copyWith(
      scaffoldBackgroundColor: AppThemes.dark_bg_color,
      dividerColor: AppThemes.dark_diver_color,
      shadowColor: AppThemes.shadow_color,
      iconTheme: IconThemeData(color: AppThemes.dark_icon_color),
      highlightColor: AppThemes.blue_dark,
      hintColor: Colors.grey.shade300.withOpacity(0.5),
      cardColor: AppThemes.dark_card_color,
      appBarTheme: AppBarTheme(
        toolbarHeight: kToolbarHeight,
        backgroundColor: AppThemes.dark_card_color,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: TextStyle(
            color: AppThemes.dark_body2_txt_color,
            fontSize: 17.0,
            fontWeight: FontWeight.w600),
        elevation: 0,
      ),
      dialogTheme: const DialogThemeData(
          backgroundColor: Colors.black,
          elevation: 24.0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(14.0)))),
      textTheme: TextTheme(
          displayLarge: const TextStyle(
            color: AppThemes.dark_headline1_color,
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
          displayMedium: const TextStyle(
            color: AppThemes.dark_headline1_color,
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
          titleMedium: const TextStyle(
            color: AppThemes.dark_headline4_color,
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
          bodyLarge: TextStyle(
            color: AppThemes.dark_body1_txt_color,
            fontSize: 13,
            fontWeight: FontWeight.normal,
          ),
          bodyMedium: TextStyle(
            color: AppThemes.dark_body2_txt_color,
            fontSize: 16,
            fontWeight: FontWeight.normal,
          ),
          bodySmall: TextStyle(
            color: AppThemes.dark_subtitle_text,
            fontSize: 12,
          )));

  static Future<void> setThemeModeIsLight(ThemeMode mode) async {
    await box.write('isLight', mode == ThemeMode.light);
  }

  static ThemeMode themeMode() {
    final isLight = box.read<bool>('isLight');
    return isLight == null
        ? ThemeMode.system
        : isLight
            ? ThemeMode.light
            : ThemeMode.dark;
  }

  static Future<void> changeTheme() async {
    print(Get.isDarkMode);
    final mode = Get.isDarkMode ? ThemeMode.light : ThemeMode.dark;
    print(mode);
    await setThemeModeIsLight(mode);
    Get.changeThemeMode(mode);
  }
}

enum ThemeType {
  light,
  dark,
  system,
}

extension ThemeTypeDesc on ThemeType {
  String get description => ['浅色', '深色', '跟随系统'][index];
}

extension ThemeTypeCode on ThemeType {
  int get code => [0, 1, 2][index];
}
