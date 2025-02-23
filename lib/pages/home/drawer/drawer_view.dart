// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:yun_music/commons/event/index.dart';
import 'package:yun_music/commons/event/play_bar_event.dart';
import 'package:yun_music/commons/res/dimens.dart';
import 'package:yun_music/commons/widgets/network_img_layer.dart';
import 'package:yun_music/pages/home/drawer/drawer_controller.dart';
import 'package:yun_music/pages/home/drawer/drawer_item.dart';
import 'package:yun_music/utils/adapt.dart';
import 'package:yun_music/utils/approute_observer.dart';

class DrawerPage extends StatefulWidget {
  const DrawerPage({super.key});

  @override
  State<DrawerPage> createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> with RouteAware {
  late DrawerPageController controller = Get.put(DrawerPageController());

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.zero,
      ),
      child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              _buildUser(),
              _buildContent(),
            ],
          )),
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
  void didPush() {
    //上一个页面push 过来viewWillappear
    super.didPush();
    eventBus.fire(PlayBarEvent(PlayBarShowHiddenType.hidden));
  }

  Widget _buildUser() {
    return GestureDetector(
        onTap: () {},
        child: Padding(
          padding: EdgeInsets.only(
              top: Dimens.gap_dp2,
              left: Dimens.gap_dp16,
              right: Dimens.gap_dp16,
              bottom: Dimens.gap_dp12),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {},
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimens.gap_dp14),
                          border: Border.all(
                            color: Colors.white,
                            width: Dimens.gap_dp1,
                          )),
                      child: ClipOval(
                        child: NetworkImgLayer(
                          width: Dimens.gap_dp28,
                          height: Dimens.gap_dp28,
                          src:
                              'https://q1.itc.cn/q_70/images03/20240807/4802bc995acb4420bcc4b49035244907.jpeg',
                        ),
                      ),
                    ),
                    SizedBox(width: Dimens.gap_dp8),
                    Text(
                      "那个人，那个梦",
                      style: TextStyle(
                        fontSize: Dimens.font_sp13,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Icon(
                      TablerIcons.chevron_right,
                      size: Dimens.gap_dp16,
                      color: Colors.black54,
                    )
                  ],
                ),
              ),
              const Spacer(),
              GestureDetector(
                child: Icon(
                  TablerIcons.scan,
                  color: Colors.black54,
                  size: Dimens.gap_dp20,
                ),
              ),
            ],
          ),
        ));
  }

  Widget _buildContent() {
    return Expanded(
        child: CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: _buildVipContent(),
        ),
        _buildCardContent(
          list: getTopItem(
            context,
            messageCount: 9,
          ),
        ),
        _buildCardContent(list: getListMusicService(context)),
        _buildCardContent(list: getListSettings(context)),
        _buildCardContent(list: getListBottomInfo(context)),
        SliverToBoxAdapter(
          child: SizedBox(
            height: Adapt.bottomPadding(),
          ),
        )
      ],
    ));
  }

  ///会员信息黑View
  Widget _buildVipContent() {
    return Container(
      margin: EdgeInsets.only(left: Dimens.gap_dp16, right: Dimens.gap_dp16),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.70),
        borderRadius: BorderRadius.circular(Dimens.gap_dp12),
      ),
      child: Padding(
        padding: EdgeInsets.only(
            left: Dimens.gap_dp12,
            right: Dimens.gap_dp12,
            top: Dimens.gap_dp10,
            bottom: Dimens.gap_dp12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  '会员已过期',
                  style: TextStyle(
                      fontSize: Dimens.font_sp14,
                      fontFamily: "Poppins-Bold",
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                const Spacer(),
                Container(
                  padding: EdgeInsets.only(
                      left: Dimens.gap_dp8, right: Dimens.gap_dp8),
                  height: Dimens.gap_dp24,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(Dimens.gap_dp12),
                  ),
                  child: Center(
                    child: Text(
                      '¥3续费',
                      style: TextStyle(
                          color: Colors.red.shade300,
                          fontSize: Dimens.font_sp10,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: Dimens.gap_dp2,
            ),
            Row(
              children: [
                Text(
                  '会员任务',
                  style: TextStyle(
                      fontSize: Dimens.font_sp10,
                      color: Colors.grey,
                      fontWeight: FontWeight.w600),
                ),
                Container(
                  margin: EdgeInsets.only(
                      left: Dimens.gap_dp6, right: Dimens.gap_dp6),
                  width: 1,
                  height: Dimens.gap_dp10,
                  color: Colors.grey,
                ),
                Text(
                  '每日打卡一键升级',
                  style: TextStyle(
                      fontSize: Dimens.font_sp10,
                      color: Colors.grey,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(
                  top: Dimens.gap_dp10, bottom: Dimens.gap_dp12),
              color: Colors.grey.withOpacity(0.4),
              height: 0.3,
            ),
            Text(
              'VIP5.6折！专属加赠送不停',
              style: TextStyle(
                  fontSize: Dimens.font_sp10,
                  color: Colors.grey,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListItem(
    BuildContext context, {
    required IconData icon,
    required String text,
    Widget? trailing,
    String? badge,
    Color? color,
    String? subTitle,
    VoidCallback? onTap,
  }) {
    final itemColor = color ?? Colors.black;

    return InkWell(
      onTap: onTap ?? () {},
      child: Padding(
        padding: EdgeInsets.only(top: Dimens.gap_dp16, bottom: Dimens.gap_dp16),
        child: Row(
          children: [
            Icon(icon, color: itemColor, size: Dimens.gap_dp16),
            SizedBox(width: Dimens.gap_dp12),
            Text(
              text,
              style: TextStyle(
                fontSize: Dimens.font_sp13,
                color: itemColor,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            if (trailing != null) ...[
              trailing,
              SizedBox(width: Dimens.gap_dp4),
            ] else if (badge?.isNotEmpty ?? false) ...[
              _buildBadge(badge!),
              SizedBox(width: Dimens.gap_dp4),
              Icon(
                Icons.chevron_right,
                color: Colors.grey[300],
                size: Dimens.gap_dp16,
              ),
            ] else if (subTitle?.isNotEmpty ?? false) ...[
              _buildSubTitle(subTitle!),
              Icon(
                Icons.chevron_right,
                color: Colors.grey[300],
                size: Dimens.gap_dp16,
              ),
            ] else
              Icon(
                Icons.chevron_right,
                color: Colors.grey[300],
                size: Dimens.gap_dp16,
              ),
            SizedBox(width: Dimens.gap_dp4),
          ],
        ),
      ),
    );
  }

  Widget _buildBadge(String text) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: Dimens.gap_dp6, vertical: Dimens.gap_dp2),
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(Dimens.gap_dp10),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: Dimens.font_sp9,
        ),
      ),
    );
  }

  Widget _buildSubTitle(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: Dimens.gap_dp2),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.grey,
          fontSize: Dimens.font_sp10,
        ),
      ),
    );
  }

  Widget _buildCardContent({required List<DrawerItem> list}) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.only(
          left: Dimens.gap_dp16,
          right: Dimens.gap_dp16,
          top: Dimens.gap_dp16,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onSecondary,
            borderRadius: BorderRadius.circular(Dimens.gap_dp12),
          ),
          child: Padding(
            padding: EdgeInsets.only(left: Dimens.gap_dp16),
            child: Column(
              children: [
                for (var i = 0; i < list.length; i++) ...[
                  _buildListItem(context,
                      icon: list[i].icon,
                      text: list[i].text,
                      color: list[i].color,
                      trailing: list[i].trailing,
                      badge: list[i].badge,
                      onTap: list[i].onTap,
                      subTitle: list[i].subTitle),
                  if (i < list.length - 1) _buildDivider(),
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(
      height: 1,
      color: Theme.of(context).brightness == Brightness.dark
          ? Colors.grey[800]
          : Colors.grey[100],
    );
  }
}
