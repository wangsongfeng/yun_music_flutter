import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:yun_music/commons/res/app_themes.dart';
import 'package:yun_music/pages/playlist_detail/playlist_detail_controller.dart';

import '../../../commons/res/dimens.dart';

class PlaylistTopOfficial extends StatelessWidget {
  const PlaylistTopOfficial({super.key, required this.controller});

  final PlaylistDetailController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CachedNetworkImage(
          height: Dimens.gap_dp32,
          fit: BoxFit.contain,
          color: AppThemes.white,
          imageUrl: controller.detail.value!.playlist.titleImageUrl!,
          imageBuilder: (context, provider) {
            return ClipRect(
              child: Align(
                alignment: Alignment.topLeft,
                widthFactor:
                    controller.detail.value!.playlist.getTitleImgFactor(),
                child: Image(image: provider),
              ),
            );
          },
        ),
        SizedBox(height: Dimens.gap_dp2),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(right: Dimens.gap_dp3),
              height: 1,
              width: 15,
              color: AppThemes.white.withOpacity(0.4),
            ),
            Text(
              controller.detail.value!.playlist.updateFrequency ?? '',
              style: TextStyle(
                color: AppThemes.white,
                fontSize: Dimens.font_sp13,
              ),
            ),
            Container(
              height: 1,
              margin: EdgeInsets.only(left: Dimens.gap_dp3),
              width: 15,
              color: AppThemes.white.withOpacity(0.4),
            ),
          ],
        ),
        SizedBox(height: Dimens.gap_dp12),
        Text(
          controller.detail.value!.playlist.description!
              .replaceAll(RegExp(r'\s+\b|\b\s|\n'), ' '),
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              fontSize: Dimens.font_sp12,
              color: AppThemes.white.withOpacity(
                0.8,
              )),
        )
      ],
    );
  }
}
