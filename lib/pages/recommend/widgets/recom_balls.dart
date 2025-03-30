// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yun_music/commons/res/app_themes.dart';
import 'package:yun_music/commons/res/dimens.dart';
import 'package:yun_music/commons/res/routes_utils.dart';
import 'package:yun_music/commons/widgets/network_img_layer.dart';
import 'package:yun_music/pages/recommend/models/recom_ball_model.dart';
import 'package:yun_music/utils/common_utils.dart';

import '../../../utils/adapt.dart';

class RecomBalls extends StatelessWidget {
  const RecomBalls(this.balls, {super.key, required this.itemHeight});

  final List<Ball> balls;

  final double itemHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: itemHeight,
      color: Get.theme.cardColor,
      child: ListView.separated(
          padding:
              EdgeInsets.only(left: Dimens.gap_dp15, right: Dimens.gap_dp15),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            final ball = balls[index];
            return _buildBalls(ball, context);
          },
          separatorBuilder: (context, index) {
            return SizedBox(width: Dimens.gap_dp24);
          },
          itemCount: balls.length),
    );
  }

  Widget _buildBalls(Ball ball, BuildContext context) {
    return GestureDetector(
      onTap: () {
        RoutesUtils.routeFromActionStr(ball.url);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipOval(
            child: Container(
              width: Dimens.gap_dp46,
              height: Dimens.gap_dp46,
              color: context.isDarkMode
                  ? AppThemes.app_main.withOpacity(0.1)
                  : AppThemes.app_main.withOpacity(0.05),
              child: NetworkImgLayer(
                width: Dimens.gap_dp46,
                height: Dimens.gap_dp46,
                src: ball.iconUrl,
                imageBuilder: (context, provider) {
                  return Stack(
                    children: [
                      Image(
                          image: provider,
                          color: const Color.fromARGB(255, 238, 40, 39)),
                      if (ball.id == -1)
                        Container(
                          margin: EdgeInsets.only(top: Dimens.gap_dp5),
                          child: Center(
                            child: Text(
                              DateTime.now().day.toString(),
                              style: TextStyle(
                                  color: Get.theme.cardColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: Dimens.font_sp12),
                            ),
                          ),
                        )
                    ],
                  );
                },
              ),
            ),
          ),

          //
          SizedBox(height: Dimens.gap_dp5),
          Text(
            ball.name,
            style: body1Style().copyWith(
              fontSize: Dimens.font_sp12,
              fontFamily: W.fonts.IconFonts,
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ),
    );
  }
}
