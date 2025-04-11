// ignore_for_file: use_super_parameters, deprecated_member_use, must_be_immutable

import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:yun_music/commons/event/index.dart';
import 'package:yun_music/commons/event/play_bar_event.dart';
import 'package:yun_music/commons/widgets/keep_alive_wrapper.dart';
import 'package:yun_music/pages/home/drawer/drawer_view.dart';
import 'package:yun_music/pages/home/home_controller.dart';
import 'package:yun_music/pages/home/widgets/home_top_bar.dart';
import 'package:yun_music/utils/adapt.dart';
import 'package:yun_music/utils/approute_observer.dart';
import 'package:yun_music/utils/common_utils.dart';
import 'package:yun_music/vmusic/playing_binding.dart';
import 'package:yun_music/vmusic/playing_controller.dart';

import '../../vmusic/comment/player/player_service.dart';
import '../../vmusic/comment/player/widgets/bottom_player_widget.dart';
import '../../vmusic/comment/player/widgets/music_playbar_overlay.dart';
import '../dynamic_page/dynamic_page.dart';
import '../found/found_view.dart';
import '../mine/mine_page.dart';
import '../recommend/recom_view.dart';
import '../village/village_page.dart';
import 'widgets/home_bottom_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with RouteAware, AutomaticKeepAliveClientMixin {
  final HomeController controller = Get.put<HomeController>(HomeController());

  Future<bool> _dialogExitApp(BuildContext context) async {
    if (GetPlatform.isAndroid) {
      const intent = AndroidIntent(
        action: 'android.intent.action.MAIN',
        category: "android.intent.category.HOME",
      );
      await intent.launch();
    }
    return Future.value(false);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (controller.player_bar_add == true) return;
    AppRouteObserver().routeObserver.subscribe(this, ModalRoute.of(context)!);
    // var widgetsBinding = WidgetsBinding.instance;
    WidgetsBinding.instance.addPostFrameCallback((callback) {
      MusicPlaybarOverlay.instance.show(
          context,
          ConstrainedBox(
              constraints: BoxConstraints(maxHeight: Adapt.tabbar_padding()),
              child: const BottomPlayerBar()));
    });
    controller.player_bar_add = true;
  }

  @override
  void initState() {
    super.initState();
    controller.homeMenuStream.add(true);
    eventBus.on<PlayBarEvent>().listen((event) {
      if (event.type == PlayBarShowHiddenType.hidden) {
        PlayerService.to.plarBarBottom.value = -Adapt.tabbar_padding();
        PlayerService.to.playBarHeight.value = 0;
      } else if (event.type == PlayBarShowHiddenType.tabbar) {
        if (PlayingController.to.mediaItems.isNotEmpty) {
          PlayerService.to.plarBarBottom.value = Adapt.tabbar_padding();
          PlayerService.to.playBarHeight.value = Adapt.tabbar_height();
        }
      } else if (event.type == PlayBarShowHiddenType.bootom) {
        if (PlayingController.to.mediaItems.isNotEmpty) {
          PlayerService.to.plarBarBottom.value = 0;
          PlayerService.to.playBarHeight.value = Adapt.tabbar_padding();
        }
      }
    });

    PlayingBinding().dependencies();
  }

  @override
  void dispose() {
    AppRouteObserver().routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPopNext() {
    super.didPopNext();
    eventBus.fire(PlayBarEvent(PlayBarShowHiddenType.tabbar));
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (controller.is_initContext == false) {
      Adapt.initContext(context);
      controller.is_initContext = true;
    }
    return WillPopScope(
      onWillPop: () async {
        return _dialogExitApp(context);
      },
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: context.isDarkMode
            ? getSystemUiOverlayStyle(isDark: false)
            : getSystemUiOverlayStyle(isDark: true),
        child: Scaffold(
          backgroundColor: Theme.of(context).hoverColor,
          extendBodyBehindAppBar: true,
          resizeToAvoidBottomInset: false,
          extendBody: true,
          drawer: Drawer(
            shape:
                const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
            width: Adapt.screenW() * 0.85,
            child: const DrawerPage(
              key: Key('home drawer'),
            ),
          ),
          onDrawerChanged: (isOpend) {
            if (isOpend == true) {
              eventBus.fire(PlayBarEvent(PlayBarShowHiddenType.hidden));
            } else {
              eventBus.fire(PlayBarEvent(PlayBarShowHiddenType.tabbar));
            }
          },
          drawerEnableOpenDragGesture: true,
          body: Stack(
            children: [
              Positioned.fill(
                child: PageView(
                  physics: const NeverScrollableScrollPhysics(),
                  onPageChanged: controller.changePage,
                  controller: controller.pageController,
                  children: const [
                    RecomPage(),
                    KeepAliveWrapper(child: FoundPage()),
                    VillagePage(),
                    KeepAliveWrapper(child: DynamicPage()),
                    MinePage(),
                  ],
                ),
              ),
              Positioned(
                top: 0,
                child: HomeTopBar(controller: controller),
              ),
            ],
          ),
          bottomNavigationBar: const HomeBottomBar(),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
