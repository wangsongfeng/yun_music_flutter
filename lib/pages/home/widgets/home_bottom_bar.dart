import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yun_music/pages/home/home_controller.dart';
import 'package:yun_music/utils/adapt.dart';

import '../../../commons/event/index.dart';
import '../../../commons/event/play_bar_event.dart';
import '../../../vmusic/comment/player/player_service.dart';
import '../../../commons/res/app_themes.dart';
import '../../../commons/res/dimens.dart';
import '../../../utils/image_utils.dart';

class HomeBottomBar extends StatefulWidget {
  const HomeBottomBar({super.key});

  @override
  State<HomeBottomBar> createState() => _HomeBottomBarState();
}

class _HomeBottomBarState extends State<HomeBottomBar>
    with SingleTickerProviderStateMixin {
  Widget _getBarIcon(int index, bool isActive) {
    String path;
    if (index == 0) {
      path = 'tab_recommend_prs';
    } else if (index == 1) {
      path = 'tab_discover_prs';
    } else if (index == 2) {
      path = 'tab_roam_prs';
    } else if (index == 3) {
      path = 'tab_icn_social';
    } else {
      path = 'tab_icn_user';
    }

    return ClipOval(
        child: ScaleTransition(
      scale: isActive
          ? Tween(begin: 1.0, end: 1.0).animate(animationController)
          : Tween(begin: 1.0, end: 1.36).animate(animationController),
      child: Container(
        width: 26,
        height: 26,
        padding: EdgeInsets.all(Dimens.gap_dp3),
        color: isActive ? AppThemes.tab_color : Colors.transparent,
        child: Image.asset(
          ImageUtils.getImagePath(path),
          color: isActive ? Colors.white : AppThemes.tab_grey_color,
        ),
      ),
    ));
  }

  Text _getBarText(int index) {
    if (index == 0) {
      return const Text("推荐",
          style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600));
    } else if (index == 1) {
      return const Text("发现",
          style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600));
    } else if (index == 2) {
      return const Text("漫游",
          style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600));
    } else if (index == 3) {
      return const Text("动态",
          style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600));
    } else {
      return const Text("我的",
          style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600));
    }
  }

  final controller = Get.find<HomeController>();

  late AnimationController animationController = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 240));

  @override
  void initState() {
    super.initState();
    animationController.forward();

    PlayerService.to.plarBarBottom.value = -Adapt.tabbar_padding();
    Future.delayed(const Duration(milliseconds: 1000), () {
      eventBus.fire(PlayBarEvent(PlayBarShowHiddenType.tabbar));
    });
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Obx(
          () => BottomBar(
            currentIndex: controller.currentIndex.value,
            focusColor: AppThemes.tab_color,
            height: (Dimens.gap_dp49 + Adapt.bottomPadding()),
            unFocusColor: AppThemes.tab_grey_color,
            onTap: (index) {
              controller.changePage(index);
              animationController.forward();
            },
            items: List<BottomBarItem>.generate(
              5,
              (index) => BottomBarItem(
                icon: _getBarIcon(index, false),
                title: _getBarText(index),
                activeIcon: _getBarIcon(index, true),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class BottomBar extends StatefulWidget {
  final List<BottomBarItem> items;
  final int currentIndex;
  final double height;
  final Color focusColor;
  final Color unFocusColor;
  final ValueChanged<int> onTap;
  const BottomBar(
      {super.key,
      required this.items,
      this.currentIndex = 0,
      required this.height,
      required this.focusColor,
      required this.unFocusColor,
      required this.onTap});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  Widget _createItem(int i) {
    final BottomBarItem item = widget.items[i];
    final bool selected = i == widget.currentIndex;
    return Expanded(
        child: SizedBox(
      height: widget.height,
      child: InkResponse(
        onTap: () async {
          widget.onTap(i);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 4),
            if (selected) item.activeIcon else item.icon,
            const SizedBox(height: 2),
            DefaultTextStyle.merge(
                style: TextStyle(
                    color: selected ? widget.focusColor : widget.unFocusColor),
                child: item.title)
          ],
        ),
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = <Widget>[];
    for (var i = 0; i < widget.items.length; i++) {
      children.add(_createItem(i));
    }
    return SizedBox(
      height: widget.height,
      width: Adapt.screenW(),
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  color: AppThemes.card_color,
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: children,
            ),
          ),
        ],
      ),
    );
  }
}

class BottomBarItem {
  final Widget icon;
  final Widget activeIcon;
  final Widget title;

  BottomBarItem(
      {required this.icon, required this.activeIcon, required this.title});
}
