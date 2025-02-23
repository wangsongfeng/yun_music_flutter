// ignore_for_file: deprecated_member_use

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yun_music/commons/res/app_themes.dart';
import 'package:yun_music/commons/widgets/network_img_layer.dart';

import '../../../commons/res/dimens.dart';
import '../../../commons/values/function.dart';
import '../../../commons/widgets/playcount_widget.dart';
import '../../../utils/adapt.dart';
import '../../../utils/image_utils.dart';

class GenerralCoverPlaycount extends StatelessWidget {
  const GenerralCoverPlaycount(
      {super.key,
      required this.imageUrl,
      required this.playCount,
      required this.coverSize,
      this.coverRadius = 6.0,
      this.rightTopTagIcon,
      this.isVideoPl = false,
      this.imageCallback});

  final String imageUrl;

  final int playCount;

  final Size coverSize;

  final double coverRadius;

  final String? rightTopTagIcon;

  final bool isVideoPl;

  final ParamSingleCallback<ImageProvider>? imageCallback;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        //突出的背景
        Container(
          height: Dimens.gap_dp4,
          width: coverSize.width - Dimens.gap_dp14,
          decoration: BoxDecoration(
            color: Get.isDarkMode
                ? Colors.white.withOpacity(0.1)
                : Colors.grey.shade300.withOpacity(0.2),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Dimens.gap_dp16),
                topRight: Radius.circular(Dimens.gap_dp16)),
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.all(
            Radius.circular(Adapt.px(coverRadius)),
          ),
          child: NetworkImgLayer(
            width: coverSize.width,
            height: coverSize.height,
            src: ImageUtils.getImageUrlFromSize(imageUrl, coverSize),
            imageBuilder: _buildConver,
            customplaceholder: Container(
              color: AppThemes.load_image_placeholder(),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildConver(BuildContext context, ImageProvider provider) {
    imageCallback?.call(provider);
    return Stack(
      children: [
        Image(
          image: provider,
          fit: BoxFit.cover,
        ),
        if (rightTopTagIcon != null)
          Positioned(
            left: 0,
            top: 0,
            child: Image.asset(
              rightTopTagIcon!,
              width: Dimens.gap_dp20,
              height: Dimens.gap_dp20,
              fit: BoxFit.fill,
            ),
          ),

        if (isVideoPl) _buildExtWidget(provider),

        //播放量
        Positioned(
          right: Dimens.gap_dp4,
          top: Dimens.gap_dp4,
          child: ClipRRect(
            borderRadius: BorderRadius.all(
              Radius.circular(Dimens.gap_dp8),
            ),
            child: PlayCountWidget(playCount: playCount),
          ),
        ),
      ],
    );
  }

  Widget _buildExtWidget(ImageProvider<Object> provider) {
    return Positioned.fill(
        child: Stack(
      children: [
        //模糊背景
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(),
        ),
        Center(
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(Dimens.gap_dp5),
                child: Image(
                  image: provider,
                  width: Dimens.gap_dp95,
                  height: Dimens.gap_dp75,
                  fit: BoxFit.cover,
                ),
              ),
              Image.asset(
                ImageUtils.getImagePath('d7o'),
                width: Dimens.gap_dp95,
                height: Dimens.gap_dp75,
                fit: BoxFit.fill,
              )
            ],
          ),
        )
      ],
    ));
  }
}
