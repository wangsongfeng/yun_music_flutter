import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:yun_music/commons/models/song_model.dart';
import 'package:yun_music/commons/values/server.dart';
import 'package:yun_music/utils/image_utils.dart';

class RotationCoverImage extends StatefulWidget {
  const RotationCoverImage({
    super.key, 
    required this.rotating, 
    this.music, 
    required this.pading});

  final bool rotating;
  final Song? music;
  final double pading;

  @override
  State<RotationCoverImage> createState() => _RotationCoverImageState();
}

class _RotationCoverImageState extends State<RotationCoverImage> with SingleTickerProviderStateMixin{
  
  //album cover rotation
  double rotation = 0;

  //album cover rotation animation
  late AnimationController controller;

  @override
  void didUpdateWidget(covariant RotationCoverImage oldWidget) {
    if (widget.rotating) {
      controller.forward(from: controller.value);
    } else {
      controller.stop();
    }
    if (widget.music != oldWidget.music) {
      controller.value = 0;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )
      ..addListener(() {
        setState(() {
          rotation = controller.value * 2 * pi;
        });
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.dismissed && widget.rotating) {
          controller.forward(from: controller.value);
        }
        if (status == AnimationStatus.completed && controller.value == 1) {
          controller.forward(from: 0);
        }
      });
    if (widget.rotating) {
      controller.forward(from: controller.value);
    }
    super.initState();
    // context.player.addListener(_playerChanged);
  }

  void _playerChanged() {
    // if (context.player.playbackState.isPlaying) {
    //   if (!controller.isAnimating) {
    //     controller.forward(from: controller.value);
    //   }
    // } else {
    //   if (controller.isAnimating) {
    //     controller.stop(canceled: false);
    //   }
    // }
  }

  @override
  void dispose() {
    controller.dispose();
    // context.player.removeListener(_playerChanged);
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned.fill(
              child: Image.asset(ImageUtils.getImagePath('play_disc'))),
          Positioned.fill(
            child: Padding(
              padding: EdgeInsets.all(widget.pading),
              child: Transform.rotate(
                angle: rotation,
                child: ClipOval(
                  child: CachedNetworkImage(
                    httpHeaders: CACHE_NET_IMAGE_HEADER,
                    imageUrl: widget.music?.al.picUrl ?? '',
                    placeholder: (context, url) => Image.asset(
                        ImageUtils.getImagePath('default_cover_play')),
                    errorWidget: (context, url, e) => Image.asset(
                        ImageUtils.getImagePath('default_cover_play')),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}