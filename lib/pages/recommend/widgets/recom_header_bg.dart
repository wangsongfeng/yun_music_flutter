import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yun_music/commons/event/index.dart';
import 'package:yun_music/commons/res/dimens.dart';
import 'package:yun_music/pages/recommend/recom_controller.dart';
import 'package:yun_music/utils/adapt.dart';

class RecomHeaderBgColors extends StatefulWidget {
  const RecomHeaderBgColors({super.key});

  @override
  State<RecomHeaderBgColors> createState() => _RecomHeaderBgColorsState();
}

class _RecomHeaderBgColorsState extends State<RecomHeaderBgColors>with SingleTickerProviderStateMixin {
  final controller = GetInstance().find<RecomController>();

  late StreamSubscription stream;

  late AnimationController _animationController;
  late Animation<Color?> _colors;
  Color curColor = Colors.transparent;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 800));
    _colors = ColorTween(begin: curColor, end: Colors.transparent)
        .animate(_animationController);
    super.initState();
    stream = eventBus.on<Color>().listen((event) {
      _colors =
          ColorTween(begin: curColor, end: event).animate(_animationController);
      setState(() {
        _animationController.reset();
        _animationController.forward();
      });
      curColor = event;
    });
  }

  @override
  void dispose() {
    stream.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SizedBox(
        width: Adapt.screenW(),
        height: controller.isScrolled.value
            ? context.theme.appBarTheme.toolbarHeight! + Adapt.topPadding()
            : context.theme.appBarTheme.toolbarHeight! +
                Adapt.topPadding() +
                Dimens.gap_dp150,
        child: controller.isScrolled.value
            ? Container(
                color: context.theme.cardColor,
                height: context.theme.appBarTheme.toolbarHeight! +
                    Adapt.topPadding(),
                width: Adapt.screenW(),
              )
            : Stack(
                children: [
                  Positioned.fill(
                    child: AnimatedBuilder(
                      animation: _colors,
                      builder: (context, child) {
                        return Container(
                          color: _colors.value,
                        );
                      },
                    ),
                  ),
                  Positioned.fill(
                    child: Obx(() => controller.isSucLoad.value
                        ? Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Get.theme.cardColor.withOpacity(0.8),
                                  Get.theme.cardColor,
                                  Get.theme.cardColor
                                ],
                              ),
                            ),
                          )
                        : const SizedBox.shrink()),
                  )
                ],
              ),
      ),
    );
  }
}
