import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:yun_music/utils/adapt.dart';

class GeneralBlurImage extends StatelessWidget {
  const GeneralBlurImage(
      {super.key,
      required this.image,
      required this.height,
      required this.sigma});

  final ImageProvider image;

  final double height;
  final double sigma;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Image(
          image: image,
          width: Adapt.screenW(),
          fit: BoxFit.cover,
        ),
        ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: sigma, sigmaY: sigma),
            child: Container(
              color: Colors.black38,
              width: Adapt.screenW(),
              height: height,
            ),
          ),
        )
      ],
    );
  }
}
