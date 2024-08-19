import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:yun_music/commons/res/app_routes.dart';
import 'package:yun_music/pages/day_song_recom/bindings.dart';
import 'package:yun_music/pages/day_song_recom/view.dart';
import 'package:yun_music/pages/home/home_binding.dart';
import 'package:yun_music/pages/home/home_view.dart';
import 'package:yun_music/pages/not_found/not_found_binding.dart';
import 'package:yun_music/pages/not_found/not_found_view.dart';
import 'package:yun_music/pages/playlist_collection/playlist_collection.dart';
import 'package:yun_music/pages/playlist_collection/playlist_collection_binding.dart';
import 'package:yun_music/pages/splash/splash_binding.dart';
import 'package:yun_music/pages/splash/splash_view.dart';

class Routes {
  static final List<GetPage<dynamic>> getPages = [
    //Splash
    CustomGetPage(
        name: '/splash',
        page: () => const SplashPage(),
        binding: SplashBinding()),
    //home
    CustomGetPage(
        name: '/home',
        page: () => const HomePage(),
        binding: HomeBinding(),
        transition: Transition.fadeIn),
    //每日推荐
    CustomGetPage(
        name: RouterPath.DaySongRecom,
        page: () => const RecomSongDayPage(),
        binding: RcmdSongDayBinding()),
    //歌单广场
    CustomGetPage(
        name: RouterPath.PlayListCollection,
        page: () => PlaylistCollectionPage(),
        binding: PlaylistCollectionBinding()),
  ];

  static final unknownRoute = CustomGetPage(
      name: '/not_found',
      page: () => const NotFoundPage(),
      binding: NotFoundBinding());
}

// ignore: must_be_immutable
class CustomGetPage extends GetPage<dynamic> {
  bool? fullscreen = false;
  CustomGetPage(
      {required super.name,
      required super.page,
      super.binding,
      this.fullscreen,
      super.transitionDuration,
      super.transition = Transition.native})
      : super(
          curve: Curves.linear,
          showCupertinoParallax: false,
          popGesture: false,
          fullscreenDialog: fullscreen != null && fullscreen,
        );
}
