import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:just_audio/just_audio.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:yun_music/commons/net/init_dio.dart';
import 'package:yun_music/commons/player/player_service.dart';
import 'package:yun_music/commons/res/app_themes.dart';
import 'package:yun_music/commons/res/thems.dart';
import 'package:yun_music/services/auth_service.dart';
import 'package:yun_music/utils/adapt.dart';
import 'package:yun_music/utils/approute_observer.dart';
import 'package:yun_music/vmusic/handle/music_handle.dart';
import 'package:yun_music/vmusic/playing_controller.dart';

import 'commons/res/app_pages.dart';

Future<void> main() async {
  await _initializeApp();
  await GetStorage.init();

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

Future<void> _initializeApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _initGetService(GetIt.instance);
}

Future<void> _initGetService(GetIt getIt) async {
  //创建一个优雅配置的AudioPlayer
  final audioPlayer = AudioPlayer(
    audioLoadConfiguration: const AudioLoadConfiguration(
      // Optimize buffer management
      androidLoadControl: AndroidLoadControl(
        // Reduce minimum buffer to prevent backup
        minBufferDuration: Duration(seconds: 3),
        // Set reasonable maximum to balance memory usage
        maxBufferDuration: Duration(seconds: 8),
        // Increase initial playback buffer for smoother start
        bufferForPlaybackDuration: Duration(milliseconds: 500),
        // Add some safety margin after rebuffering
        bufferForPlaybackAfterRebufferDuration: Duration(seconds: 1),
        // Set target buffer size to reduce memory pressure
        targetBufferBytes: 2 * 1024 * 1024,
      ),
    ),
  );

  getIt.registerSingleton<AudioPlayer>(audioPlayer);

  await Hive.initFlutter('music');
  getIt.registerSingleton<Box>(await Hive.openBox('cache'));

  await HttpManager.init(debug: false);

  final musicHandler = await AudioService.init<MusicHandle>(
    builder: () => MusicHandle(),
    config: const AudioServiceConfig(
      // Android 通知栏配置
      androidNotificationChannelId: 'com.example.yun_music',
      androidNotificationChannelName: '网易云音乐',
      androidNotificationChannelDescription: '音乐播放控制',
      androidNotificationIcon: 'mipmap/ic_launcher',
      androidShowNotificationBadge: true,
      androidNotificationOngoing: true,
      androidStopForegroundOnPause: true,

      // 通知栏显示选项
      notificationColor: Color(0xFFe72d2c),
      artDownscaleWidth: 300,
      artDownscaleHeight: 300,

      // 快速启动配置
      fastForwardInterval: Duration(seconds: 10),
      rewindInterval: Duration(seconds: 10),
    ),
  );

  getIt.registerSingleton<MusicHandle>(musicHandler);
}

class MainAppPage extends StatelessWidget {
  const MainAppPage({super.key});
  @override
  Widget build(BuildContext context) {
    return RefreshConfiguration(
      headerBuilder: () => const MaterialClassicHeader(
        color: AppThemes.app_main,
        backgroundColor: Colors.white,
      ),
      footerBuilder: () => const ClassicFooter(),
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
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
          Get.put(PlayingController());
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


