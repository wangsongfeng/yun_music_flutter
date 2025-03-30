import 'dart:io';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

class GStrorage {
  static late final Box<dynamic> userInfo;
  static late final Box<dynamic> setting;

  static Future<void> init() async {
    final Directory dir = await getApplicationSupportDirectory();
    final String path = dir.path;
    await Hive.initFlutter('$path/hive');
    regAdapter();

    //设置
    setting = await Hive.openBox('setting');
  }

  static void regAdapter() {}

  static Future<void> close() async {
    setting.compact();
    setting.close();
  }
}

class SettingBoxKey {
  ///外观
  static const String themeMode = 'themeMode',
      customColor = 'customColor'; // 自定义主题色
}
