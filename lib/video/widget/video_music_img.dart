import 'dart:math';
import 'package:flutter/material.dart';
import 'package:yun_music/commons/res/dimens.dart';
import 'package:yun_music/commons/widgets/network_img_layer.dart';
import '../../utils/image_utils.dart';
import '../controller/video_list_controller.dart';

class VideoMusicImg extends StatefulWidget {
  const VideoMusicImg(
      {super.key,
      required this.imageUrl,
      required this.roationSpeed,
      required this.controller});

  final String imageUrl;
  final double roationSpeed;
  final VPVideoController controller;

  @override
  State<VideoMusicImg> createState() => _VideoMusicImgState();
}

class _VideoMusicImgState extends State<VideoMusicImg>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  bool _isDisposed = false;

  @override
  void initState() {
    super.initState();
    // 创建 AnimationController
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat();
    // 创建 Tween 并生成动画
    _animation =
        Tween<double>(begin: 0, end: 2 * pi).animate(_animationController);

    if (widget.controller.current_isPlay.value == true) {
      _animationController.repeat();
    } else {
      _animationController.stop();
    }
    widget.controller.current_isPlay.listen((value) {
      if (_isDisposed == false) {
        if (value == false) {
          _animationController.stop();
        } else {
          _animationController.repeat();
        }
      }
    });
  }

  @override
  void dispose() {
    _isDisposed = true;
    _animationController.dispose();
    super.dispose();
  }

//music_cover
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: Dimens.gap_dp10),
      width: 46,
      height: 46,
      color: Colors.transparent,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (BuildContext context, Widget? child) {
          return Transform.rotate(
            angle: _animation.value * widget.roationSpeed,
            child: Stack(
              children: [
                ClipOval(
                  child: Image.asset(
                    ImageUtils.getImagePath('music_cover'),
                    fit: BoxFit.cover,
                  ),
                ),
                Center(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(14)),
                    child: NetworkImgLayer(
                      width: 28,
                      height: 28,
                      src: widget.imageUrl,
                      customplaceholder: Container(),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
