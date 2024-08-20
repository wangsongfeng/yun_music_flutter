// ignore_for_file: slash_for_doc_comments

import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:yun_music/commons/widgets/network_img_layer.dart';
import 'package:yun_music/utils/image_utils.dart';

/**
 * Stack常用属性
children：子视图
alignment：子视图的对齐方式
topLeft：顶部左对齐
topCenter：顶部居中对齐
topRight：顶部右对齐
centerLeft：中间左对齐
center：中间对齐
centerRight：中间右对齐
bottomLeft：底部左对齐
bottomCenter：底部居中对齐
bottomRight：底部右对齐
clipBehavior，裁剪，可能会影响性能
Clip.hardEdge: Stack默认为此选项
Clip.antiAlias: 平滑裁剪
Clip.antiAliasWithSaveLayer
Clip.none: 不需要裁剪
fit：子视图填充方式
StackFit.loose: 使用子组件的大小
StackFit.expand: 充满父视图的区域
StackFit.passthrough: 透传，使用Stack的父视图的布局方式
textDirection
TextDirection.ltr
TextDirection.rtl
 */

class BlurBackground extends StatelessWidget {
  const BlurBackground({super.key, this.musicCoverUrl});

  final String? musicCoverUrl;

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: ImageFiltered(
        imageFilter: ui.ImageFilter.blur(sigmaX: 55, sigmaY: 55),
        child: Stack(
          fit: StackFit.expand,
          children: [
            NetworkImgLayer(
              src: musicCoverUrl ?? "",
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              customplaceholder: Image.asset(
                ImageUtils.getImagePath('fm_bg', format: 'jpg'),
                fit: BoxFit.fitHeight,
              ),
            ),
            Positioned.fill(
                child: Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.black12, Colors.black26])),
            ))
          ],
        ),
      ),
    );
  }
}
