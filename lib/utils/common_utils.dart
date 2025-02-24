import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:yun_music/commons/event/index.dart';
import 'package:yun_music/commons/event/play_bar_event.dart';
import 'package:yun_music/commons/models/song_model.dart';
import 'package:yun_music/commons/res/app_routes.dart';
import 'package:yun_music/commons/widgets/network_img_layer.dart';
import 'package:yun_music/utils/adapt.dart';
import 'package:yun_music/utils/image_utils.dart';

import '../commons/player/bottom_player_controller.dart';

final box = GetStorage();

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

/// 跳转到播放页面

Future<void> toPlayingPage() async {
  eventBus.fire(PlayBarEvent(PlayBarShowHiddenType.hidden));
  final controller = Get.find<PlayerController>();
  controller.animationController.forward();
  HapticFeedback.lightImpact();
  Get.toNamed(RouterPath.PlayingPage);
}

Future toast(dynamic message) async {
  Fluttertoast.cancel();
  Fluttertoast.showToast(
      msg: message,
      gravity: ToastGravity.CENTER,
      toastLength: Toast.LENGTH_LONG);
}

TextStyle headlineStyle() {
  return Get.theme.textTheme.titleMedium ?? const TextStyle();
}

TextStyle headline1Style() {
  return Get.theme.textTheme.displayLarge ?? const TextStyle();
}

TextStyle headline2Style() {
  return Get.theme.textTheme.displayMedium ?? const TextStyle();
}

TextStyle body1Style() {
  return Get.theme.textTheme.bodyLarge ?? const TextStyle();
}

TextStyle body2Style() {
  return Get.theme.textTheme.bodyMedium ?? const TextStyle();
}

TextStyle captionStyle() {
  return Get.theme.textTheme.bodySmall ?? const TextStyle();
}

String getPlayCountStrFromInt(int count) {
  if (count < 10000) {
    return '$count';
  } else if (count >= 10000 && count <= 99999999) {
    return '${count ~/ 10000}万';
  } else {
    return '${(count / 100000000).toStringAsFixed(1)}亿';
  }
}

//万为单位

String getCommentStrFromInt(int count) {
  if (count < 1000) {
    return count.toString();
  } else if (1000 <= count && count < 10000) {
    return '999+';
  } else if (10000 <= count && count < 100000) {
    return '1w+';
  } else {
    return '10w+';
  }
}

List<Widget> getSongTags(Song song,
    {bool needOriginType = true,
    bool needNewType = true,
    bool needCopyright = true}) {
  final List<Widget> tags = List.empty(growable: true);
  final List<String> res = List.empty(growable: true);

  if (song.fee == 1) {
    res.add(ImageUtils.getImagePath('d2d'));
    if (song.privilege?.fee == 0) {
      res.add(ImageUtils.getImagePath('dx1'));
    }
  }
  if (song.copyright == 1 && needCopyright) {
    res.add(ImageUtils.getImagePath('dwg'));
  }
  if (song.originCoverType == 1 && needOriginType) {
    res.add(ImageUtils.getImagePath('dwr'));
  }
  if (song.v <= 3 && needNewType) {
    res.add(ImageUtils.getImagePath('dwp'));
  }
  if (song.privilege?.preSell == true) {
    res.add(ImageUtils.getImagePath('dwv'));
  }
  if (song.privilege?.payed == 1) {
    res.add(ImageUtils.getImagePath('dw7'));
  }
  if (song.privilege?.getMaxPlayBr() == 999000) {
    res.add(ImageUtils.getImagePath('dwz'));
  }
  if (song.privilege?.freeTrialPrivilege?.resConsumable == true ||
      song.privilege?.freeTrialPrivilege?.userConsumable == true) {
    res.add(ImageUtils.getImagePath('ck4'));
  }
  // Get.log('ressize ${res.length}');
  for (final element in res) {
    tags.add(Image.asset(
      element,
      width: Adapt.px(19.0),
      height: Adapt.px(10.0),
      fit: BoxFit.contain,
    ));
  }

  return tags;
}

//用户头像
Widget buildUserAvatar(String? url, Size size) {
  return SizedBox.fromSize(
    size: size,
    child: CircleAvatar(
      radius: size.height / 2,
      backgroundColor: Colors.transparent,
      child: NetworkImgLayer(
        width: size.width,
        height: size.height,
        src: url ?? "",
        customplaceholder: _buildAvaterHolder(size),
        imageBuilder: (context, provider) {
          return ClipOval(
            child: Image(image: provider),
          );
        },
      ),
    ),
  );
}

Widget _buildAvaterHolder(Size size) {
  return Stack(
    children: [
      Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
            color: Get.theme.cardColor,
            borderRadius: BorderRadius.all(Radius.circular(size.height / 2))),
      ),
      SizedBox(
        width: size.width,
        height: size.height,
        child: Image.asset(
          ImageUtils.getImagePath('ce2'),
          fit: BoxFit.cover,
          color: const Color(0xfff8bfbd),
        ),
      )
    ],
  );
}

///验证中文
bool isChinese(String value) {
  return RegExp(r"[\u4e00-\u9fa5]").hasMatch(value);
}

class TimeUtils {
  static const String _format1 = "yyyy-MM";
  static const String _format2 = "yyyy-MM-dd";

  static String getFormat1({int? time}) {
    return DateFormat(_format1).format(time == null
        ? DateTime.now()
        : DateTime.fromMillisecondsSinceEpoch(time));
  }

  static String getFormat2({int? time}) {
    return DateFormat(_format2).format(time == null
        ? DateTime.now()
        : DateTime.fromMillisecondsSinceEpoch(time));
  }

  ///秒转换分钟
  static String getMinuteFromMillSecond(int millSecond) {
    double second = (millSecond / 1000);
    int minute = second % 3600 ~/ 60;
    int seconds = (second % 60).toInt();
    return '${TimeUtils.formatSecondTime(minute)}:${TimeUtils.formatSecondTime(seconds)}';
  }

  ///分钟转换毫秒
  static int getMillSecondFromMinute(String minute) {
    String chart = ":";
    if (minute.contains(chart)) {
      List<String> list = minute.split(chart);
      int mi = _getminute(list.first) * 60 * 1000;
      int se = (double.parse(list.last) * 1000.0).toInt();
      return mi + se;
    }
    return 0;
  }

  static String formatSecondTime(int s) {
    return s < 10 ? "0$s" : s.toString();
  }

  static String timeByString(int? mill) {
    if (mill == null) return "未知";
    if (isToday(mill)) return "今天";
    if (isYesterday(mill)) return "昨天";
    if (isTomorrow(mill)) return "明天";
    return "其他";
  }

  static int getApartSeconds() {
    DateTime now = DateTime.now();
    return now.millisecondsSinceEpoch ~/ 1000;
  }

  static bool isToday(int? mill) {
    if (mill == null) return false;
    return isTodayByDateTime(DateTime.fromMillisecondsSinceEpoch(mill));
  }

  static bool isYesterday(int? mill) {
    if (mill == null) return false;
    return isYesterdayDate(DateTime.fromMillisecondsSinceEpoch(mill));
  }

  static bool isTomorrow(int? mill) {
    if (mill == null) return false;
    return isTomorrowDate(DateTime.fromMillisecondsSinceEpoch(mill));
  }

  static bool isSameDay(int mill1, int mill2) {
    return DateUtils.isSameDay(DateTime.fromMillisecondsSinceEpoch(mill1),
        DateTime.fromMillisecondsSinceEpoch(mill2));
  }

  static bool isTodayByDateTime(DateTime date) {
    return DateUtils.isSameDay(DateTime.now(), date);
  }

  static bool isYesterdayDate(DateTime time) {
    DateTime now = DateTime.now();
    DateTime yesterday = DateTime(now.year, now.month, now.day - 1);
    return yesterday.year == time.year &&
        yesterday.month == time.month &&
        yesterday.day == time.day;
  }

  static bool isTomorrowDate(DateTime time) {
    DateTime now = DateTime.now();
    DateTime tomorrow = DateTime(now.year, now.month, now.day + 1);
    return tomorrow.year == time.year &&
        tomorrow.month == time.month &&
        tomorrow.day == time.day;
  }

  static DateTime getDaysAgo(int days) {
    return DateTime.now().subtract(Duration(days: days));
  }

  static DateTime formatExpiresTime(String str) {
    var expiresTime =
        RegExp("Expires[^;]*;").stringMatch(str)!.split("=")[1].split(" ");
    var year = expiresTime[3];
    var day = expiresTime[1];
    var mounth = _getMounthByStr(expiresTime[2]);
    return DateTime(int.parse(year), mounth, int.parse(day));
  }

  static int _getMounthByStr(String str) {
    int output = 1;
    switch (str) {
      case "Jan":
        output = 1;
        break;
      case "Feb":
        output = 2;
        break;
      case "Mar":
        output = 3;
        break;
      case "Apr":
        output = 4;
        break;
      case "May":
        output = 5;
        break;
      case "Jun":
        output = 6;
        break;
      case "Jul":
        output = 7;
        break;
      case "Aug":
        output = 8;
        break;
      case "Sep":
        output = 9;
        break;
      case "Oct":
        output = 10;
        break;
      case "Nov":
        output = 11;
        break;
      case "Dec":
        output = 12;
        break;
    }
    return output;
  }

  static int _getminute(String str) {
    int output = 0;
    switch (str) {
      case "01":
        output = 1;
        break;
      case "02":
        output = 2;
        break;
      case "03":
        output = 3;
        break;
      case "04":
        output = 4;
        break;
      case "05":
        output = 5;
        break;
      case "06":
        output = 6;
        break;
      case "07":
        output = 7;
        break;
      case "08":
        output = 8;
        break;
      case "09":
        output = 9;
        break;
    }
    return output;
  }
}

///状态栏颜色设置，此方法抽出来了，全项目可以直接调用
getSystemUiOverlayStyle({bool isDark = true}) {
  SystemUiOverlayStyle value;
  if (Platform.isAndroid) {
    value = SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,

      /// 安卓系统状态栏存在底色，所以需要加这个
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness:
          isDark ? Brightness.dark : Brightness.light,
      statusBarIconBrightness: isDark ? Brightness.dark : Brightness.light,

      /// 状态栏字体颜色
      statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
    );
  } else {
    value = isDark ? SystemUiOverlayStyle.dark : SystemUiOverlayStyle.light;
  }
  return value;
}
