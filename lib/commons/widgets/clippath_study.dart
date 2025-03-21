import 'package:flutter/material.dart';
import 'dart:math' as math;

class ClippathStudy extends StatelessWidget {
  const ClippathStudy({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: ClipPath(
      clipper: MyClipper(),
      child: Container(
        width: 200,
        height: 30,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
              Color(0xFFFFD5D5),
              Color(0xFFFFECE6),
            ])),
      ),
    ));
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    path.moveTo(0, 0);
    final center = Offset(size.height / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2;
    path.arcTo(Rect.fromCircle(center: center, radius: radius), math.pi / 2,
        math.pi, true);
    path.close();
    path.moveTo(size.height / 2, size.height);
    path.lineTo(size.width - 30, size.height);
    path.lineTo(size.width, 0);
    path.lineTo(size.height / 2, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}


/**
 * 1、moveTo  就把绘制的七点移动到指定的位置
 * 2、lineTo  就是从起点绘制一条直线到 lineTo 里面指定的一个点
 * 3、quadraticBezierTo  是绘制二阶贝塞尔曲线的 
 * path.quadraticBezierTo(size.width / 2, size.height, size.width, size.height / 2);
 * 需要三个点，一个起点，一个控制点，一个终点
 * 
 * 4、cubicTo 绘制三阶贝塞尔曲线的 需要两个控制点
 * 
 * 5、arcTo  方法是绘制弧线的，
 * arcTo(Rect rect, double startAngle, double sweepAngle, bool forceMoveTo)
 * rect: 圆弧所在矩形
 * startAngle : 开始弧度
 * sweepAngle : 需要绘制的弧度大小
 * forceMoveTo  : 如果“forceMoveTo”参数为false，则添加一条直线段和一条弧段。
 * 如果“forceMoveTo”参数为true，则启动一个新的子路径，其中包含一个弧段。
 * 
 * 6、addRect 绘制矩形。
 * 7、addOval 绘制椭圆。
 */