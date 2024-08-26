import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:yun_music/commons/event/index.dart';
import 'package:yun_music/commons/event/play_bar_event.dart';
import 'package:yun_music/commons/models/song_model.dart';
import 'package:yun_music/commons/res/app_routes.dart';
import 'package:yun_music/commons/widgets/network_img_layer.dart';
import 'package:yun_music/utils/adapt.dart';
import 'package:yun_music/utils/image_utils.dart';

import '../commons/player/bottom_player_controller.dart';

final box = GetStorage();

/**
 * 跳转到播放页面
 */

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
  if (count < 100000) {
    return '$count';
  } else if (count >= 100000 && count <= 99999999) {
    return '${count ~/ 10000}万';
  } else {
    return '${(count / 100000000).toStringAsFixed(1)}亿';
  }
}

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
