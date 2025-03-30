import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:yun_music/commons/event/index.dart';
import 'package:yun_music/commons/event/play_bar_event.dart';
import 'package:yun_music/commons/res/dimens.dart';

import '../../../commons/res/thems.dart';
import '../../../utils/strorage.dart';
import 'drawer_item.dart';

class DrawerPageController extends GetxController {
  Box setting = GStrorage.setting;
  Rx<ThemeType> themeType = ThemeType.system.obs;

  late bool viewAppear = false;

  @override
  void onInit() {
    super.onInit();

    themeType.value = ThemeType.values[setting.get(SettingBoxKey.themeMode,
        defaultValue: ThemeType.system.code)];
  }

  @override
  void onReady() {
    super.onReady();
    eventBus.fire(PlayBarEvent(PlayBarShowHiddenType.hidden));
  }

  onChangeTheme() {
    Brightness currentBrightness =
        MediaQuery.of(Get.context!).platformBrightness;
    ThemeType currentTheme = themeType.value;
    switch (currentTheme) {
      case ThemeType.dark:
        setting.put(SettingBoxKey.themeMode, ThemeType.light.code);
        themeType.value = ThemeType.light;
        break;
      case ThemeType.light:
        setting.put(SettingBoxKey.themeMode, ThemeType.dark.code);
        themeType.value = ThemeType.dark;
        break;
      case ThemeType.system:
        // 判断当前的颜色模式
        if (currentBrightness == Brightness.light) {
          setting.put(SettingBoxKey.themeMode, ThemeType.dark.code);
          themeType.value = ThemeType.dark;
        } else {
          setting.put(SettingBoxKey.themeMode, ThemeType.light.code);
          themeType.value = ThemeType.light;
        }
        break;
    }
    Get.forceAppUpdate();
  }
}

List<DrawerItem> getTopItem(BuildContext context, {int? messageCount}) {
  return [
    DrawerItem(
        icon: TablerIcons.mail,
        text: "我的消息",
        badge: (messageCount ?? 0).toString(),
        onTap: () {},
        subTitle: ''),
    DrawerItem(
      icon: TablerIcons.currency_ethereum,
      text: "云贝中心",
      subTitle: '免费兑换黑胶VIP',
    ),
    DrawerItem(
      icon: TablerIcons.shirt,
      text: "装扮中心",
      subTitle: '小刘鸭联名套装',
    ),
    DrawerItem(icon: TablerIcons.rosette, text: "徽章中心", subTitle: "解锁新徽章啦"),
    DrawerItem(icon: TablerIcons.bulb, text: "创作者中心", subTitle: ""),
  ];
}

List<DrawerItem> getListMusicService(BuildContext context) {
  return [
    DrawerItem(
      icon: TablerIcons.sparkles,
      text: "音乐服务",
    ),
    DrawerItem(
      icon: TablerIcons.sparkles,
      text: "趣测",
    ),
    DrawerItem(
      icon: TablerIcons.ticket,
      text: "云村有票",
    ),
    DrawerItem(
      icon: TablerIcons.brand_shopee,
      text: "商城",
    ),
    DrawerItem(
      icon: TablerIcons.microphone_2,
      text: "歌房",
    ),
    DrawerItem(
      icon: TablerIcons.flame,
      text: "云推歌",
    ),
    DrawerItem(
      icon: TablerIcons.brand_tiktok,
      text: "彩铃专区",
    ),
    DrawerItem(
      icon: TablerIcons.building_broadcast_tower,
      text: "免流量听歌",
    ),
  ];
}

List<DrawerItem> getListSettings(BuildContext context, bool isDark) {
  return [
    DrawerItem(
      icon: TablerIcons.settings,
      text: "设置",
    ),
    DrawerItem(
        icon: TablerIcons.moon_stars,
        text: "深色模式",
        trailing: SizedBox(
            height: Dimens.gap_dp16,
            width: Dimens.gap_dp16,
            child: FittedBox(
                fit: BoxFit.contain,
                child: Icon(
                  isDark ? CupertinoIcons.sun_max : CupertinoIcons.moon,
                )))),
    DrawerItem(
      icon: TablerIcons.stopwatch,
      text: "定时关闭",
    ),
    DrawerItem(
      icon: TablerIcons.headphones,
      text: "边听边存",
    ),
    DrawerItem(
      icon: TablerIcons.gavel,
      text: "音乐收藏家",
    ),
    DrawerItem(
      icon: TablerIcons.shield,
      text: "青少年模式",
    ),
    DrawerItem(
      icon: TablerIcons.alarm,
      text: "音乐闹钟",
    ),
    DrawerItem(
        icon: TablerIcons.file_invoice, text: "个人信息收集与使用清单", onTap: () {}),
    DrawerItem(
      icon: TablerIcons.notes,
      text: "个人信息收集与第三方共享清单",
    ),
    DrawerItem(icon: TablerIcons.shield_check, text: "个人信息与隐私保护"),
    DrawerItem(icon: TablerIcons.info_circle, text: "关于", onTap: () {}),
  ];
}

List<DrawerItem> getListBottomInfo(BuildContext context) {
  return [
    DrawerItem(icon: TablerIcons.switch_horizontal, text: "切换账号", onTap: () {}),
    DrawerItem(
        icon: TablerIcons.logout,
        text: "退出登录",
        color: Colors.red,
        onTap: () {}),
  ];
}
