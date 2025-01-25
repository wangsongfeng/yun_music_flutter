import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:yun_music/commons/event/index.dart';
import 'package:yun_music/commons/event/play_bar_event.dart';
import 'package:yun_music/commons/res/dimens.dart';

import 'drawer_item.dart';

class DrawerPageController extends GetxController {
  late bool viewAppear = false;
  @override
  void onReady() {
    super.onReady();
    print('onReady');

    eventBus.fire(PlayBarEvent(PlayBarShowHiddenType.hidden));
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

List<DrawerItem> getListSettings(BuildContext context) {
  return [
    DrawerItem(
      icon: TablerIcons.settings,
      text: "设置",
    ),
    DrawerItem(
        icon: TablerIcons.moon_stars,
        text: "深色模式",
        trailing: SizedBox(
            height: Dimens.gap_dp30,
            width: Dimens.gap_dp66,
            child: FittedBox(
                fit: BoxFit.contain,
                child: Switch(
                    trackOutlineColor: MaterialStateProperty.resolveWith(
                      (final Set<MaterialState> states) {
                        if (states.contains(MaterialState.selected)) {
                          return null;
                        }
                        return Colors.transparent;
                      },
                    ),
                    activeTrackColor: Colors.red,
                    // 当开关关闭时的轨道颜色
                    inactiveThumbColor: Colors.white,
                    inactiveTrackColor: Colors.grey[200],
                    value: false,
                    onChanged: (value) {})))),
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
