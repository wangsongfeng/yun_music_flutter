import 'package:get/get.dart';
import 'package:yun_music/commons/res/app_routes.dart';
import 'package:yun_music/commons/values/server.dart';

class RoutesUtils {
  static Future<void> routeFromActionStr(String? action, {dynamic data}) async {
    if (action == null) return;
    print(action);
    if (action.startsWith(RouterPath.ROUTES_HOST)) {
      //应用内跳转
      final path =
          action.substring(RouterPath.ROUTES_HOST.length, action.length);
      logger.d(path);
      Get.toNamed('/$path');
      return;
    }
  }
}
