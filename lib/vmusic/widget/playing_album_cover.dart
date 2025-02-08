import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../commons/player/widgets/rotation_cover_image.dart';
import '../../commons/res/dimens.dart';
import '../../commons/res/down_up_fade.dart';
import '../../commons/values/constants.dart';
import '../../utils/adapt.dart';
import '../../utils/image_utils.dart';
import '../playing_controller.dart';

class PlayingAlbumCover extends StatefulWidget {
  const PlayingAlbumCover({super.key, this.music});

  final MediaItem? music;

  @override
  State<PlayingAlbumCover> createState() => _PlayingAlbumCoverState();
}

class _PlayingAlbumCoverState extends State<PlayingAlbumCover>
    with TickerProviderStateMixin {
  final playController = Get.find<PlayingController>();

  late AnimationController _needleController;

  late Animation<double> _needleAnimation;

  AnimationController? _translateController;

  bool _needleAttachCover = false;

  bool _coverRotating = false;

  ///专辑封面X偏移量
  ///[-screenWidth/2,screenWidth/2]
  /// 0 表示当前播放音乐封面
  /// -screenWidth/2 - 0 表示向左滑动 |_coverTranslateX| 距离，即滑动显后一首歌曲的示封面
  double _coverTranslateX = 0;

  bool _beDragging = false;

  bool _previousNextDirty = true;

  ///滑动切换音乐效果上一个封面
  MediaItem? _previous;

  ///当前播放中的音乐
  MediaItem? _current;

  ///滑动切换音乐效果下一个封面
  MediaItem? _next;

  late bool isDispose = false;

  @override
  void initState() {
    super.initState();
    _needleAttachCover = playController.playing.value;
    _needleController = AnimationController(
        value: _needleAttachCover ? 1.0 : 0.0,
        vsync: this,
        duration: const Duration(milliseconds: 500));
    _needleAnimation = Tween<double>(begin: -1 / 12, end: 0)
        .chain(CurveTween(curve: Curves.easeInOut))
        .animate(_needleController);

    _current = widget.music;
    _invalidatePn();

    playController.playing.listen((play) {
      if (isDispose == false) {
        _checkNeedleAndCoverStatus();
      }
    });

    _checkNeedleAndCoverStatus();
  }

  @override
  void didUpdateWidget(covariant PlayingAlbumCover oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_current == widget.music) {
      _invalidatePn();
      return;
    }

    double offset = 0;
    if (widget.music == _previous) {
      offset = MediaQuery.of(context).size.width;
    } else if (widget.music == _next) {
      offset = -MediaQuery.of(context).size.width;
    }
    if (offset == 0) {
      return;
    }
    _animateCoverTranslateTo(offset, onCompleted: () {
      setState(() {
        _coverTranslateX = 0;
        _current = widget.music;
        _previousNextDirty = true;
        _invalidatePn();
      });
    });
  }

  Future<void> _invalidatePn() async {
    if (!_previousNextDirty) {
      return;
    }
    _previousNextDirty = false;
    _previous = (await playController.getPreviousMediaItem());
    _next = (await playController.getNextMusic());

    if (mounted) {
      setState(() {});
    }
  }

  // 更新当前needle和封面状态
  void _checkNeedleAndCoverStatus() {
    final bool attachToCover = playController.playing.value && !_beDragging;

    _rotateNeedle(attachToCover);

    final isPlaying = playController.playing.value;
    setState(() {
      _coverRotating = isPlaying && _needleAttachCover;
    });
  }

  ///是否需要抓转Needle到封面上
  void _rotateNeedle(bool attachToCover) {
    if (_needleAttachCover == attachToCover) {
      return;
    }
    _needleAttachCover = attachToCover;
    if (attachToCover) {
      _needleController.forward(from: _needleController.value);
    } else {
      _needleController.reverse(from: _needleController.value);
    }
  }

  @override
  void dispose() {
    _needleController.dispose();
    _translateController?.dispose();
    _translateController = null;
    isDispose = true;
    super.dispose();
  }

  static double kHeightSpaceAlbumTop = Adapt.px(66);

  void _animateCoverTranslateTo(double des, {void Function()? onCompleted}) {
    _translateController?.dispose();
    _translateController = null;
    _translateController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    final animation =
        Tween(begin: _coverTranslateX, end: des).animate(_translateController!);
    animation.addListener(() {
      setState(() {
        _coverTranslateX = animation.value;
      });
    });
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _translateController?.dispose();
        _translateController = null;
        if (onCompleted != null) {
          onCompleted();
        }
      }
    });
    _translateController!.forward();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      assert(constraints.maxWidth.isFinite,
          "the width of cover layout should be constrainted!");
      return ClipRect(
          child: Padding(
        padding: EdgeInsets.only(bottom: Dimens.gap_dp16, top: Dimens.gap_dp16),
        child: _build(context, constraints.maxWidth),
      ));
    });
  }

  Widget _build(BuildContext context, double layoutWidth) {
    return Stack(
      children: <Widget>[
        GestureDetector(
          onHorizontalDragStart: (detail) {
            _beDragging = true;
            _checkNeedleAndCoverStatus();
          },
          onHorizontalDragUpdate: (detail) {
            if (_beDragging) {
              setState(() {
                _coverTranslateX += detail.primaryDelta!;
              });
            }
          },
          onHorizontalDragEnd: (detail) {
            _beDragging = false;

            //左右切换封面滚动速度阈值
            final vThreshold =
                1.0 / (0.050 * MediaQuery.of(context).devicePixelRatio);

            final sameDirection =
                (_coverTranslateX > 0 && detail.primaryVelocity! > 0) ||
                    (_coverTranslateX < 0 && detail.primaryVelocity! < 0);
            if (_coverTranslateX.abs() > layoutWidth / 2 ||
                (sameDirection && detail.primaryVelocity!.abs() > vThreshold)) {
              var des = MediaQuery.of(context).size.width;
              if (_coverTranslateX < 0) {
                des = -des;
              }
              _animateCoverTranslateTo(des, onCompleted: () {
                setState(() {
                  //reset translateX to 0 when animation complete
                  _coverTranslateX = 0;
                  if (des > 0) {
                    _current = _previous;
                    playController.audioHandler.skipToPrevious();
                  } else {
                    _current = _next;
                    playController.audioHandler.skipToNext();
                  }
                  _previousNextDirty = true;
                });
              });
            } else {
              //animate [_coverTranslateX] to 0
              _animateCoverTranslateTo(0, onCompleted: () {
                _checkNeedleAndCoverStatus();
              });
            }
          },
          child: Container(
              color: Colors.transparent,
              alignment: Alignment.topCenter,
              padding: EdgeInsets.only(top: kHeightSpaceAlbumTop),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                    maxHeight: Adapt.screenW() - Dimens.gap_dp52,
                    maxWidth: Adapt.screenW() - Dimens.gap_dp52),
                child: Stack(
                  children: <Widget>[
                    Image.asset(
                      ImageUtils.getImagePath('play_disc_mask'),
                      fit: BoxFit.cover,
                    ),
                    Transform.translate(
                      offset: Offset(_coverTranslateX - layoutWidth, 0),
                      child: RotationCoverImage(
                        rotating: false,
                        music: _previous,
                        pading: Dimens.gap_dp60,
                      ),
                    ),
                    Transform.translate(
                      offset: Offset(_coverTranslateX, 0),
                      child: Hero(
                          tag: HERO_TAG_CUR_PLAY,
                          createRectTween: createRectTween,
                          child: RotationCoverImage(
                            rotating: _coverRotating && !_beDragging,
                            music: _current,
                            pading: Dimens.gap_dp60,
                          )),
                    ),
                    Transform.translate(
                      offset: Offset(_coverTranslateX + layoutWidth, 0),
                      child: RotationCoverImage(
                        rotating: false,
                        music: _next,
                        pading: Dimens.gap_dp60,
                      ),
                    ),
                  ],
                ),
              )),
        ),
        Obx(() => Visibility(
            visible: playController.showNeedle.value,
            child: ClipRect(
              child: Align(
                alignment: const Alignment(0, -1),
                child: Transform.translate(
                  offset: const Offset(30, -12),
                  child: RotationTransition(
                    turns: _needleAnimation,
                    alignment:
                        //计算旋转中心点的偏移,以保重旋转动画的中心在针尾圆形的中点
                        Alignment(-1 + Adapt.px(23) * 2 / Adapt.px(91.1),
                            -1 + Adapt.px(23) * 2 / Adapt.px(147)),
                    child: Image.asset(
                      ImageUtils.getImagePath('play_needle_play'),
                      height: kHeightSpaceAlbumTop * 2.2,
                    ),
                  ),
                ),
              ),
            )))
      ],
    );
  }
}
