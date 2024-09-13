import 'package:flutter/material.dart';
import 'package:yun_music/pages/moments/moments_controller.dart';

import '../../../commons/res/app_themes.dart';
import '../../../commons/res/dimens.dart';
import '../../../commons/skeleton/custom_underline_indicator.dart';

class MomentStickyBar extends StatelessWidget {
  const MomentStickyBar({super.key, required this.controller});

  final MomentsController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TabBar(
          controller: controller.tabController,
          tabs: const [
            Tab(text: '声音'),
            Tab(text: '推荐'),
          ],
          padding: EdgeInsets.only(top: Dimens.gap_dp6),
          labelPadding:
              EdgeInsets.only(left: Dimens.gap_dp16, right: Dimens.gap_dp12),
          isScrollable: true,
          labelStyle: TextStyle(
              fontSize: Dimens.font_sp14, fontWeight: FontWeight.w600),
          dividerColor: Colors.transparent,
          indicatorColor: AppThemes.indicator_color,
          unselectedLabelColor: const Color.fromARGB(255, 114, 114, 114),
          labelColor: const Color.fromARGB(255, 51, 51, 51),
          indicator: CustomUnderlineTabIndicator(
              width: 0.0,
              borderSide: BorderSide(
                width: 6,
                color: AppThemes.indicator_color,
              ),
              strokeCap: StrokeCap.round),
          indicatorPadding:
              EdgeInsets.only(bottom: Dimens.gap_dp9, top: Dimens.gap_dp21),
          indicatorSize: TabBarIndicatorSize.label,
          enableFeedback: true,
          splashBorderRadius: BorderRadius.circular(10),
          tabAlignment: TabAlignment.center,
          onTap: (value) {},
        ),
      ],
    );
  }
}
