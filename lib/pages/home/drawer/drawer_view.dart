import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yun_music/commons/event/index.dart';
import 'package:yun_music/commons/event/play_bar_event.dart';
import 'package:yun_music/commons/res/app_themes.dart';
import 'package:yun_music/commons/res/dimens.dart';
import 'package:yun_music/commons/res/thems.dart';
import 'package:yun_music/pages/home/drawer/drawer_controller.dart';
import 'package:yun_music/services/auth_service.dart';
import 'package:yun_music/utils/adapt.dart';
import 'package:yun_music/utils/approute_observer.dart';
import 'package:yun_music/utils/common_utils.dart';
import 'package:yun_music/utils/image_utils.dart';

class DrawerPage extends StatefulWidget {
  const DrawerPage({super.key});

  @override
  State<DrawerPage> createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> with RouteAware {
  late DrawerPageController controller = Get.put(DrawerPageController());

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          SizedBox(height: Adapt.topPadding()),
          _buildUser(),
          _settingCard(),
          Expanded(child: Container()),
          if (AuthService.to.isLoggedInValue) _logout(context),
        ],
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    AppRouteObserver().routeObserver.subscribe(this, ModalRoute.of(context)!);

    WidgetsBinding.instance.addPostFrameCallback((_) {});
  }

  @override
  void dispose() {
    AppRouteObserver().routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPopNext() {
    super.didPopNext();
    print('didPopNext');
  }

  @override
  void didPush() {
    //上一个页面push 过来viewWillappear
    super.didPush();
    print('didPush');
    eventBus.fire(PlayBarEvent(PlayBarShowHiddenType.hidden));
  }

  Widget _buildUser() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        color: Colors.transparent,
        height: Dimens.gap_dp44,
        alignment: Alignment.centerLeft,
        margin: EdgeInsets.only(top: Dimens.gap_dp10),
        padding: EdgeInsets.symmetric(horizontal: Dimens.gap_dp15),
        child: Obx(
          () => RichText(
            textAlign: TextAlign.end,
            text: TextSpan(
              children: [
                WidgetSpan(
                    alignment: PlaceholderAlignment.middle,
                    child: buildUserAvatar(
                        AuthService.to.loginData.value?.profile?.avatarUrl ??
                            '',
                        Size(Dimens.gap_dp26, Dimens.gap_dp26))),
                const WidgetSpan(child: SizedBox(width: 12)),
                TextSpan(
                    text: AuthService.to.isLoggedIn.value
                        ? AuthService.to.loginData.value?.profile?.nickname
                        : '立即登陆',
                    style: headline2Style()),
                WidgetSpan(
                  child: Image.asset(
                    ImageUtils.getImagePath('icon_more'),
                    color: headline2Style().color,
                    height: Dimens.gap_dp15,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _settingCard() {
    return Container(
      margin: EdgeInsets.fromLTRB(
          Dimens.gap_dp15, Dimens.gap_dp30, Dimens.gap_dp15, 0),
      padding: EdgeInsets.symmetric(horizontal: Dimens.gap_dp16),
      width: Adapt.screenW(),
      decoration: BoxDecoration(
        color: Get.isDarkMode ? Colors.white.withOpacity(0.07) : Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(Dimens.gap_dp10)),
      ),
      child: Column(
        children: [
          _themeMode(),
          _about(),
        ],
      ),
    );
  }

  Widget _themeMode() {
    return SizedBox(
      height: Dimens.gap_dp50,
      child: Row(
        children: [
          Image.asset(
            ImageUtils.getImagePath('icn_night'),
            width: Dimens.gap_dp20,
            color: body2Style().color,
          ),
          const SizedBox(width: 12),
          Expanded(
              child: Text(
            '夜间模式',
            style: body1Style(),
          )),
          CupertinoSwitch(
              value: Get.isDarkMode,
              onChanged: (b) {
                SFThemes.changeTheme();
              })
        ],
      ),
    );
  }

  Widget _about() {
    return _normCell(
        imgName: 'icn_about',
        title: '关于',
        onTap: () {
          Get.back();
        });
  }

  Widget _normCell(
      {required String imgName,
      required String title,
      required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: Dimens.gap_dp50,
        child: Row(
          children: [
            Image.asset(
              ImageUtils.getImagePath(imgName),
              width: Dimens.gap_dp20,
              color: body2Style().color,
            ),
            const SizedBox(width: 12),
            Expanded(
                child: Text(
              title,
              style: body1Style(),
            )),
            Image.asset(
              ImageUtils.getImagePath('icon_more'),
              width: Dimens.gap_dp20,
              color: body2Style().color?.withOpacity(0.5),
            )
          ],
        ),
      ),
    );
  }

  Widget _logout(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // controller.logout();
        Get.dialog(
            CupertinoAlertDialog(
              title: const Text('FlutterMusic'),
              content: const Text('确定退出当前账号?'),
              actions: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    color: Colors.transparent,
                    height: Dimens.gap_dp50,
                    alignment: Alignment.center,
                    child: Text(
                      '取消',
                      style: body2Style().copyWith(
                          color: context.theme.highlightColor,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    color: Colors.transparent,
                    height: Dimens.gap_dp50,
                    alignment: Alignment.center,
                    child: Text(
                      '确定',
                      style: body2Style()
                          .copyWith(color: context.theme.highlightColor),
                    ),
                  ),
                )
              ],
            ),
            barrierColor: Colors.black12);
      },
      child: Container(
        height: Dimens.gap_dp48,
        decoration: BoxDecoration(
            color:
                Get.isDarkMode ? Colors.white.withOpacity(0.07) : Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(Dimens.gap_dp10))),
        margin: EdgeInsets.only(
            left: Dimens.gap_dp16,
            right: Dimens.gap_dp16,
            bottom: Dimens.gap_dp20 + Adapt.bottomPadding()),
        alignment: Alignment.center,
        child: Text(
          '退出登陆',
          style: TextStyle(
              color: AppThemes.app_main_light, fontSize: Dimens.font_sp15),
        ),
      ),
    );
  }
}
