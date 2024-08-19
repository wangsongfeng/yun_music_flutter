import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:yun_music/commons/player/player_service.dart';
import 'package:yun_music/commons/res/app_themes.dart';
import 'package:yun_music/commons/res/thems.dart';
import 'package:yun_music/services/auth_service.dart';
import 'package:yun_music/utils/approute_observer.dart';

import 'commons/res/app_pages.dart';

Future<void> main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();

  /// 自定义报错页面
  ErrorWidget.builder = (FlutterErrorDetails flutterErrorDetails) {
    debugPrint(flutterErrorDetails.toString());
    return const Material(
      child: Center(
          child: Text(
        "发生了没有处理的错误\n请通知开发者",
        textAlign: TextAlign.center,
      )),
    );
  };

  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((_) async {
    runApp(const MainAppPage());
    /**
         *  SystemUiMode.edgeToEdge: 显示状态栏
         *  SystemUiMode.immersiveSticky: 不显示状态栏
         */
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    if (GetPlatform.isAndroid) {
      const SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarDividerColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
      );
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    }
    if (GetPlatform.isIOS) {
      const SystemUiOverlayStyle dark = SystemUiOverlayStyle(
        systemNavigationBarColor: Color(0xFF000000),
        systemNavigationBarIconBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      );
      SystemChrome.setSystemUIOverlayStyle(dark);
    }
  });
}

class MainAppPage extends StatelessWidget {
  const MainAppPage({super.key});

  @override

  @override
  Widget build(BuildContext context) {
    return RefreshConfiguration(
      headerBuilder: () => const MaterialClassicHeader(
        color: AppThemes.app_main,
        backgroundColor: Colors.white,
      ),
      footerBuilder: () => const ClassicFooter(),
      child: GetMaterialApp(
        navigatorObservers: [AppRouteObserver().routeObserver],
        title: '网易云Flutter',
        theme: SFThemes.lightTheme,
        darkTheme: SFThemes.darkTheme,
        themeMode: SFThemes.themeMode(),
        color: Colors.white,
        unknownRoute: Routes.unknownRoute,
        initialBinding: BindingsBuilder(() {
          Get.put(AuthService());
          Get.put(PlayerService());
        }),
        getPages: Routes.getPages,
        initialRoute: '/splash',
        builder: (context, child) {
          return Stack(
            children: [
              child!,
              if (context.isDarkMode)
                IgnorePointer(
                  child: Container(
                    color: Colors.black12,
                  ),
                )
            ],
          );
        },
      ),
    );
  }
}
