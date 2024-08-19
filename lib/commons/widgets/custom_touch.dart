import 'package:flutter/material.dart';

class BounceTouch extends StatefulWidget {
  const BounceTouch({
    super.key,
    required this.onPressed,
    required this.child,
    this.duration = const Duration(milliseconds: 100),
    this.scaleFactor = 1.25,
  });

  final VoidCallback onPressed;
  final Widget child;
  final Duration duration;
  final double scaleFactor;

  @override
  State<BounceTouch> createState() => _BounceTouchState();
}

class _BounceTouchState extends State<BounceTouch>
    with SingleTickerProviderStateMixin {
  late double _scale;
  late AnimationController _animationController;
  VoidCallback get onPressed => widget.onPressed;
  Duration get userDuration => widget.duration;
  double get scaleFactor => widget.scaleFactor;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
      upperBound: 0.1,
    )..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 - (_animationController.value * scaleFactor);
    return GestureDetector(
      onTap: _onTap,
      behavior: HitTestBehavior.translucent,
      child: Transform.scale(
        scale: _scale,
        child: Opacity(opacity: _scale, child: widget.child),
      ),
    );
  }

  void _onTap() {
    _animationController.forward();

    Future.delayed(userDuration, () {
      _animationController.reverse();
      onPressed();
    });
  }
}
