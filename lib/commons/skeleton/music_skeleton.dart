// ignore_for_file: slash_for_doc_comments, deprecated_member_use

import 'package:flutter/material.dart';

class Skeleton extends StatelessWidget {
  const Skeleton({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    var shimmerGradient = LinearGradient(
      colors: [
        Colors.transparent,
        Theme.of(context).colorScheme.background.withAlpha(10),
        Theme.of(context).colorScheme.background.withAlpha(10),
        Colors.transparent
      ],
      stops: const [0.1, 0.3, 0.5, 0.7],
      begin: const Alignment(-1.0, -0.3),
      end: const Alignment(1.0, 0.9),
      tileMode: TileMode.clamp,
    );
    return Shimmer(
      linearGradient: shimmerGradient,
      child: ShimmerLoading(isLoading: true, child: child),
    );
  }
}

class Shimmer extends StatefulWidget {
  static ShimmerState? of(BuildContext context) {
    return context.findAncestorStateOfType<ShimmerState>();
  }

  const Shimmer({
    super.key,
    required this.linearGradient,
    this.child,
  });

  final LinearGradient linearGradient;
  final Widget? child;

  @override
  ShimmerState createState() => ShimmerState();
}

/**
 * initState()函数是在组件渲染之前执行的。在Flutter中，initState()是StatefulWidget的生命周期方法之一，在调用build()方法之前被调用。
 * 当创建一个StatefulWidget并将其添加到组件树中时，Flutter会实例化该组件的状态对象，并在调用initState()方法后再调用build()方法来构建UI。
 * initState()通常用于执行一些初始化操作，比如数据获取、订阅事件、启动定时器等。它只会被调用一次，在组件的整个生命周期中只执行一次。
 * 一旦initState()被调用并完成后，就会立即调用build()方法来构建UI。所以，如果你希望在UI构建之前执行某些操作，可以放在initState()中。
 * 值得注意的是，在initState()中不要执行耗时的操作或阻塞UI线程的操作，因为这可能导致应用程序卡顿。如果需要进行异步操作，可以使用Future、async/await等方式来处理。

 */

class ShimmerState extends State<Shimmer> with SingleTickerProviderStateMixin {
  late AnimationController _shimmerController;

  @override
  void initState() {
    super.initState();
    _shimmerController = AnimationController.unbounded(vsync: this)
      ..repeat(min: -0.5, max: 1.5, period: const Duration(milliseconds: 1000));
  }

  @override
  void dispose() {
    _shimmerController.dispose();
    super.dispose();
  }

  ///可以实现背景颜色渐变
  LinearGradient get gradient => LinearGradient(
        colors: widget.linearGradient.colors,
        stops: widget.linearGradient.stops,
        begin: widget.linearGradient.begin,
        end: widget.linearGradient.end,
        transform:
            _SlidingGradientTransfrom(slidePercent: _shimmerController.value),
      );
  bool get isSized =>
      (context.findRenderObject() as RenderBox?)?.hasSize ?? false;

  Size get size => (context.findRenderObject() as RenderBox).size;

  Offset getDescendantOffset({
    required RenderBox descendant,
    Offset offset = Offset.zero,
  }) {
    final shimmerBox = context.findRenderObject() as RenderBox;
    return descendant.localToGlobal(offset, ancestor: shimmerBox);
  }

  Listenable get shimmerChanges => _shimmerController;

  @override
  Widget build(BuildContext context) {
    return widget.child ?? const SizedBox();
  }
}

class _SlidingGradientTransfrom extends GradientTransform {
  const _SlidingGradientTransfrom({
    required this.slidePercent,
  });

  final double slidePercent;

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
    return Matrix4.translationValues(bounds.width * slidePercent, 0.0, 0.0);
  }
}

class ShimmerLoading extends StatefulWidget {
  const ShimmerLoading({
    super.key,
    required this.isLoading,
    required this.child,
  });

  final bool isLoading;
  final Widget child;

  @override
  State<ShimmerLoading> createState() => _ShimmerLoadingState();
}

class _ShimmerLoadingState extends State<ShimmerLoading> {
  Listenable? _shimmerChanges;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_shimmerChanges != null) {
      _shimmerChanges!.removeListener(_onShimmerChange);
    }
    _shimmerChanges = Shimmer.of(context)?.shimmerChanges;
    if (_shimmerChanges != null) {
      _shimmerChanges!.addListener(_onShimmerChange);
    }
  }

  @override
  void dispose() {
    _shimmerChanges?.removeListener(_onShimmerChange);
    super.dispose();
  }

  void _onShimmerChange() {
    if (widget.isLoading) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isLoading) {
      return widget.child;
    }
    final shimmer = Shimmer.of(context)!;
    if (!shimmer.isSized) {
      return const SizedBox();
    }
    final shimmerSize = shimmer.size;
    final gradient = shimmer.gradient;
    final offsetWithinShimmer = shimmer.getDescendantOffset(
      descendant: context.findRenderObject() as RenderBox,
    );
    return ShaderMask(
      blendMode: BlendMode.srcATop,
      shaderCallback: (bounds) {
        return gradient.createShader(Rect.fromLTWH(-offsetWithinShimmer.dx,
            -offsetWithinShimmer.dy, shimmerSize.width, shimmerSize.height));
      },
      child: widget.child,
    );
  }
}
