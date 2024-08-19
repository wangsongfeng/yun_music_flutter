import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:yun_music/commons/res/app_themes.dart';
import 'package:yun_music/commons/values/server.dart';
import 'package:yun_music/utils/extensions.dart';

class NetworkImgLayer extends StatelessWidget {
  const NetworkImgLayer(
      {super.key,
      this.src,
      required this.width,
      required this.height,
      this.type,
      this.fadeOutDuration,
      this.fadeInDuration,
      this.quality,
      this.origAspectRatio,
      this.color,
      this.customplaceholder,
      this.imageBuilder});

  final String? src;
  final double width;
  final double height;
  final String? type;
  final Duration? fadeOutDuration;
  final Duration? fadeInDuration;
  final int? quality;
  final double? origAspectRatio;
  final ImageWidgetBuilder? imageBuilder;
  final Color? color;
  final Widget? customplaceholder;

  @override
  Widget build(BuildContext context) {
    int? memCacheWidth, memCacheHeight;
    double aspectRatio = (width / height).toDouble();

    void setMemCacheSizes() {
      if (aspectRatio > 1) {
        memCacheHeight = height.cacheSize(context);
      } else if (aspectRatio < 1) {
        memCacheWidth = width.cacheSize(context);
      } else {
        if (origAspectRatio != null && origAspectRatio! > 1) {
          memCacheWidth = width.cacheSize(context);
        } else if (origAspectRatio != null && origAspectRatio! < 1) {
          memCacheHeight = height.cacheSize(context);
        } else {
          memCacheWidth = width.cacheSize(context);
          memCacheHeight = height.cacheSize(context);
        }
      }

    }

    setMemCacheSizes();
    if (memCacheWidth == null && memCacheHeight == null) {
      memCacheWidth = width.toInt();
    }

    return src != '' && src != null
        ? ClipRRect(
            clipBehavior: Clip.antiAlias,
            child: CachedNetworkImage(
              color: color,
              httpHeaders: CACHE_NET_IMAGE_HEADER,
              imageUrl: src!,
              width: width,
              height: height,
              memCacheWidth: memCacheWidth,
              memCacheHeight: memCacheHeight,
              fit: BoxFit.cover,
              fadeOutDuration:
                  fadeOutDuration ?? const Duration(milliseconds: 120),
              fadeInDuration:
                  fadeInDuration ?? const Duration(milliseconds: 120),
              filterQuality: FilterQuality.low,
              errorWidget: (BuildContext context, String url, Object error) {
                return placeholder(context);
              },
              placeholder: (BuildContext context, String url) =>
                  placeholder(context),
              imageBuilder: imageBuilder,
            ),
          )
        : placeholder(context);
  }

  Widget placeholder(context) {
    if (customplaceholder != null) {
      return customplaceholder!;
    } else {
      return Container(
        width: width,
        height: height,
        color: AppThemes.load_image_placeholder(),
      );
    }
  }
}
