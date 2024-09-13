// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class RectangularIndicator extends Decoration {
  /// topRight radius of the indicator, default to 5.
  final double topRightRadius;

  /// topLeft radius of the indicator, default to 5.
  final double topLeftRadius;

  /// bottomRight radius of the indicator, default to 0.
  final double bottomRightRadius;

  /// bottomLeft radius of the indicator, default to 0
  final double bottomLeftRadius;

  /// Color of the indicator, default set to [Colors.black]
  final Color color;

  /// Horizontal padding of the indicator, default set to 0
  final double horizontalPadding;

  /// Vertical padding of the indicator, default set to 0
  final double verticalPadding;

  /// [PagingStyle] determines if the indicator should be fill or stroke, default to fill
  final PaintingStyle paintingStyle;

  /// StrokeWidth, used for [PaintingStyle.stroke], default set to 0
  final double strokeWidth;

  final EdgeInsetsGeometry insets;

  final double width; // 控制器的宽度
  final BorderSide borderSide;

  const RectangularIndicator({
    this.topRightRadius = 5,
    this.topLeftRadius = 5,
    this.bottomRightRadius = 0,
    this.bottomLeftRadius = 0,
    this.color = Colors.black,
    this.horizontalPadding = 0,
    this.verticalPadding = 0,
    this.paintingStyle = PaintingStyle.fill,
    this.strokeWidth = 2,
    this.insets = EdgeInsets.zero,
    this.width = 0,
    this.borderSide = const BorderSide(width: 2, color: Colors.white),
  });
  @override
  _CustomPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CustomPainter(
      this,
      onChanged,
      bottomLeftRadius: bottomLeftRadius,
      bottomRightRadius: bottomRightRadius,
      color: color,
      horizontalPadding: horizontalPadding,
      topLeftRadius: topLeftRadius,
      topRightRadius: topRightRadius,
      verticalPadding: verticalPadding,
      paintingStyle: paintingStyle,
      strokeWidth: strokeWidth,
    );
  }

  @override
  Path getClipPath(Rect rect, TextDirection textDirection) {
    return Path()..addRect(_indicatorRectFor(rect, textDirection));
  }

  Rect _indicatorRectFor(Rect rect, TextDirection textDirection) {
    final Rect indicator = insets.resolve(textDirection).deflateRect(rect);

    // 希望的宽度
    double wantWidth = width;
    // 取中间坐标
    double cw = (indicator.left + indicator.right) / 2;
    // 这里是核心代码
    if (wantWidth == 0) {
      final Rect indicator = insets.resolve(textDirection).deflateRect(rect);
      return Rect.fromLTWH(
        indicator.left - 2,
        indicator.bottom - borderSide.width,
        indicator.width + 4,
        borderSide.width,
      );
    } else {
      return Rect.fromLTWH(cw - wantWidth / 2,
          indicator.bottom - borderSide.width, wantWidth, borderSide.width);
    }
  }
}

class _CustomPainter extends BoxPainter {
  final RectangularIndicator decoration;
  final double topRightRadius;
  final double topLeftRadius;
  final double bottomRightRadius;
  final double bottomLeftRadius;
  final Color color;
  final double horizontalPadding;
  final double verticalPadding;
  final PaintingStyle paintingStyle;
  final double strokeWidth;

  _CustomPainter(
    this.decoration,
    VoidCallback? onChanged, {
    required this.topRightRadius,
    required this.topLeftRadius,
    required this.bottomRightRadius,
    required this.bottomLeftRadius,
    required this.color,
    required this.horizontalPadding,
    required this.verticalPadding,
    required this.paintingStyle,
    required this.strokeWidth,
  }) : super(onChanged);

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    assert(horizontalPadding >= 0);
    assert(horizontalPadding < configuration.size!.width / 2,
        "Padding must be less than half of the size of the tab");
    assert(verticalPadding < configuration.size!.height / 2 &&
        verticalPadding >= 0);
    assert(strokeWidth >= 0 &&
        strokeWidth < configuration.size!.width / 2 &&
        strokeWidth < configuration.size!.height / 2);

    //offset is the position from where the decoration should be drawn.
    //configuration.size tells us about the height and width of the tab.
    final Size mysize = Size(
        configuration.size!.width - (horizontalPadding * 2),
        configuration.size!.height - (2 * verticalPadding));

    print("rect-${configuration.size}--${mysize}");

    final Offset myoffset =
        Offset(offset.dx + horizontalPadding, offset.dy + verticalPadding);
    final Rect rect = myoffset & mysize;
    final Paint paint = Paint();
    paint.color = color;
    paint.style = paintingStyle;
    paint.strokeWidth = 1;
    canvas.drawRRect(
        RRect.fromRectAndCorners(
          rect,
          bottomRight: Radius.circular(bottomRightRadius),
          bottomLeft: Radius.circular(bottomLeftRadius),
          topLeft: Radius.circular(topLeftRadius),
          topRight: Radius.circular(topRightRadius),
        ),
        paint);
  }
}
