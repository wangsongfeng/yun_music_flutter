import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:yun_music/commons/res/app_routes.dart';
import 'package:yun_music/commons/widgets/photo_view/photo_preview.dart';
import 'package:yun_music/pages/blog_detail/blog_detail_page.dart';
import 'package:yun_music/pages/day_song_recom/bindings.dart';
import 'package:yun_music/pages/day_song_recom/view.dart';
import 'package:yun_music/pages/home/home_binding.dart';
import 'package:yun_music/pages/home/home_view.dart';
import 'package:yun_music/pages/moments/moments_page.dart';
import 'package:yun_music/pages/new_song_album/new_song_album_page.dart';
import 'package:yun_music/pages/not_found/not_found_binding.dart';
import 'package:yun_music/pages/not_found/not_found_view.dart';
import 'package:yun_music/vmusic/comment/comment_page.dart';
import 'package:yun_music/vmusic/playing_binding.dart';
import 'package:yun_music/vmusic/playing_page.dart';
import 'package:yun_music/pages/playlist_collection/playlist_collection.dart';
import 'package:yun_music/pages/playlist_collection/playlist_collection_binding.dart';
import 'package:yun_music/pages/playlist_detail/playlist_detail_page.dart';
import 'package:yun_music/pages/rank_list/ranklist_view.dart';
import 'package:yun_music/pages/splash/splash_binding.dart';
import 'package:yun_music/pages/splash/splash_view.dart';
import 'package:yun_music/video/binding.dart';
import 'package:yun_music/video/view.dart';

import 'down_up_fade.dart';

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
        page: () => const PlaylistCollectionPage(),
        binding: PlaylistCollectionBinding()),
    //歌单详情
    CustomGetPage(
        name: RouterPath.PlayListDetail,
        page: () => const PlaylistDetailPage()),
    //播放页面
    CustomGetPage(
        name: RouterPath.PlayingPage,
        page: () => const PlayingPage(),
        binding: PlayingBinding(),
        customTransition: SlideDownWithFadeTransition(),
        transitionDuration: const Duration(milliseconds: 200),
        preventDuplicates: true //按钮防抖
        ),

    //排行榜页面
    CustomGetPage(
        name: RouterPath.RankListPage, page: () => const RanklistView()),

    ///新歌，新碟
    CustomGetPage(
        name: RouterPath.NEW_SONG_ALBUM, page: () => const NewSongAlbumPage()),

    //播客详情
    CustomGetPage(
        name: RouterPath.Blog_Detail_Page, page: () => const BlogDetailPage()),

    //朋友圈
    CustomGetPage(
        name: RouterPath.Moments_Page, page: () => const MomentsPage()),

    //图片查看
    CustomGetPage(
        name: RouterPath.PreView_Page,
        page: () => const PhotoPreview(),
        customTransition: FadePushTransition(),
        transitionDuration: const Duration(milliseconds: 240)),

    //视频列表
    CustomGetPage(
        name: RouterPath.Video_Lists,
        page: () => const VideoPage(),
        binding: VideoBinding()),

    //评论
    CustomGetPage(
        name: RouterPath.Comment_Page, page: () => const CommentPage())
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
      super.customTransition,
      super.preventDuplicates,
      super.transition = Transition.native})
      : super(
          curve: Curves.linear,
          showCupertinoParallax: false,
          popGesture: false,
          fullscreenDialog: fullscreen != null && fullscreen,
        );
}
