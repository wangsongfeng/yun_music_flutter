import 'package:flutter/material.dart';
import 'package:yun_music/pages/playlist_detail/playlist_detail_controller.dart';

class SliverFabMain extends StatefulWidget {
  const SliverFabMain(
      {super.key,
      required this.slivers,
      required this.floatingWidget,
      this.expandedHeight = 256.0,
      this.topScalingEdge = 96.0,
      this.floadingPosition = const FloatingPosition(right: 16.0),
      required this.controller});

  final List<Widget> slivers;

  final PreferredSizeWidget floatingWidget;

  final PlaylistDetailController controller;

  //App Bar 展开的高度
  final double expandedHeight;
  final double topScalingEdge;

  final FloatingPosition floadingPosition;

  @override
  State<SliverFabMain> createState() => _SliverFabMainState();
}

class _SliverFabMainState extends State<SliverFabMain> {
  late ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    scrollController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Stack(
        children: [
          CustomScrollView(
            physics: const BouncingScrollPhysics(),
            controller: scrollController,
            slivers: widget.slivers,
          ),
          _buildFabPage(),
        ],
      ),
    );
  }

  Widget _buildFabPage() {
    final double defaultTopMargin = widget.expandedHeight +
        (widget.floadingPosition.top ?? 0) -
        widget.floatingWidget.preferredSize.height / 2.0;

    final double scale0edge = widget.expandedHeight - kToolbarHeight;
    final double scale1edge = defaultTopMargin - widget.topScalingEdge;

    double headerTop = 0.0;

    double top = defaultTopMargin;
    double scale = 1.0;
    if (scrollController.hasClients) {
      //_positions.isNotEmpty
      final double offset = scrollController.offset;
      top -= offset;
      headerTop = offset;
      if (offset < scale1edge) {
        scale = 1.0;
      } else if (offset > scale0edge) {
        scale = 0.0;
      } else {
        scale = (scale0edge - offset) / (scale0edge - scale1edge);
      }
    }
    widget.controller.headerBgHeight.value = headerTop <= 0
        ? widget.controller.expandedHeight - headerTop
        : widget.controller.expandedHeight;

    return Positioned(
      top: top,
      right: widget.floadingPosition.right,
      left: widget.floadingPosition.left,
      child: Transform(
        transform: Matrix4.identity()..scale(scale, scale),
        alignment: Alignment.center,
        child: Opacity(
          opacity: scale > 0.8 ? scale : 0,
          child: widget.floatingWidget,
        ),
      ),
    );
  }
}

class FloatingPosition {
  final double? top;

  final double? right;

  final double? left;

  const FloatingPosition({this.top, this.right, this.left});
}
