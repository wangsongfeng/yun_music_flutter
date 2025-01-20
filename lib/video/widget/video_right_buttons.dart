import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yun_music/commons/res/app_themes.dart';
import 'package:yun_music/utils/image_utils.dart';

import '../../commons/res/dimens.dart';
import '../../commons/widgets/network_img_layer.dart';
import '../../commons/widgets/tapped.dart';
import '../../utils/common_utils.dart';
import '../controller/video_list_controller.dart';
import '../logic.dart';
import '../state.dart';
import 'video_music_img.dart';

class VideoRightButtons extends StatelessWidget {
  final VideoState state = Get.find<VideoLogic>().videoState;

  final VPVideoController? controller;
  final Function? onFavorite;
  final Function? onComment;
  final Function? onCollection;
  final Function? onShare;

  VideoRightButtons(
      {required this.controller,
      this.onFavorite,
      this.onComment,
      this.onShare,
      this.onCollection});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      margin: EdgeInsets.only(
        bottom: Dimens.gap_dp8,
        right: Dimens.gap_dp10,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Obx(
            () => SizedBox(
              width: 48,
              height: 58,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(24)),
                        border: Border.all(width: 2.0, color: Colors.white)),
                    width: 48,
                    height: 48,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(24)),
                      child: NetworkImgLayer(
                        width: 48,
                        height: 48,
                        src: controller?.videoInfo.value?.avatar?.avatar_168x168
                                ?.url_list?.first ??
                            "",
                        customplaceholder: ClipOval(
                          child: Image.asset(
                            ImageUtils.getImagePath('img_find_default'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Obx(() => _FavoriteIcon(
                onFavorite: onFavorite,
                favoriteCount:
                    controller?.videoInfo.value!.statistics?.digg_count ?? 0,
                isFavorite: false,
              )),
          Obx(() => _IconButton(
                icon: Image.asset(
                  ImageUtils.getImagePath('icon_home_comment'),
                  fit: BoxFit.cover,
                  width: 36,
                  height: 36,
                ),
                text: getCommentStrFromInt(int.parse(controller
                        ?.videoInfo.value!.statistics?.comment_count
                        .toString() ??
                    '0')),
                onTap: onComment,
              )),
          Obx(() => _CollectionIcon(
                onCollection: onCollection,
                collectionCount:
                    controller?.videoInfo.value!.statistics?.collect_count ?? 0,
                isCollection: false,
              )),
          Obx(() => _IconButton(
                icon: Image.asset(
                  ImageUtils.getImagePath('icon_home_share_v2'),
                  fit: BoxFit.cover,
                  width: 36,
                  height: 36,
                ),
                text: getCommentStrFromInt(
                    controller?.videoInfo.value!.statistics?.share_count ?? 0),
                onTap: onShare,
              )),
          Obx(() => Center(
                child: VideoMusicImg(
                  imageUrl: controller!.videoInfo.value?.music!.cover_medium!
                          .url_list!.first ??
                      '',
                  roationSpeed: 1.0,
                  controller: controller!,
                ),
              )),
        ],
      ),
    );
  }
}

class _FavoriteIcon extends StatelessWidget {
  const _FavoriteIcon({
    Key? key,
    required this.onFavorite,
    required this.favoriteCount,
    required this.isFavorite,
  }) : super(key: key);
  final bool isFavorite;
  final Function? onFavorite;
  final int favoriteCount;

  @override
  Widget build(BuildContext context) {
    return _IconButton(
      icon: Image.asset(
        isFavorite
            ? ImageUtils.getImagePath('icon_home_like_after')
            : ImageUtils.getImagePath('icon_home_like_before'),
        fit: BoxFit.cover,
        width: 36,
        height: 36,
      ),
      text: getCommentStrFromInt(favoriteCount),
      onTap: onFavorite,
    );
  }
}

// ignore: unused_element
class _CollectionIcon extends StatelessWidget {
  const _CollectionIcon(
      {Key? key,
      required this.isCollection,
      required this.onCollection,
      required this.collectionCount})
      : super(key: key);

  final bool isCollection;
  final Function? onCollection;
  final int collectionCount;

  @override
  Widget build(BuildContext context) {
    return _IconButton(
      icon: Image.asset(
        isCollection
            ? ImageUtils.getImagePath('play_uncollect')
            : ImageUtils.getImagePath('play_uncollect'),
        fit: BoxFit.cover,
        width: 36,
        height: 36,
      ),
      text: getCommentStrFromInt(collectionCount),
      onTap: onCollection,
    );
  }
}

/// 把IconData转换为文字，使其可以使用文字样式
class IconToText extends StatelessWidget {
  final IconData? icon;
  final TextStyle? style;
  final double? size;
  final Color? color;

  const IconToText(
    this.icon, {
    Key? key,
    this.style,
    this.size,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      String.fromCharCode(icon!.codePoint),
      style: style ??
          TextStyle(
            fontFamily: 'MaterialIcons',
            fontSize: size ?? 30,
            color: color ?? AppThemes.color_204.withOpacity(0.9),
          ),
    );
  }
}

class _IconButton extends StatelessWidget {
  final Widget? icon;
  final String? text;
  final Function? onTap;

  const _IconButton({
    Key? key,
    this.icon,
    this.text,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final shadowStyle = TextStyle(
      shadows: [
        Shadow(
          color: Colors.black.withOpacity(0.15),
          offset: const Offset(0, 1),
          blurRadius: 1,
        ),
      ],
    );
    final body = Column(
      children: <Widget>[
        Tapped(
          onTap: onTap,
          child: icon ?? Container(),
        ),
        Container(height: Dimens.gap_dp2),
        Text(
          text ?? '??',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: Dimens.font_sp12,
            color: AppThemes.white,
          ),
        ),
      ],
    );
    return Container(
      padding: EdgeInsets.symmetric(vertical: Dimens.gap_dp8),
      child: DefaultTextStyle(
        style: shadowStyle,
        child: body,
      ),
    );
  }
}
