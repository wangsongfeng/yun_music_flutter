import 'package:flutter/material.dart';

class QuickerScrollPhysics extends BouncingScrollPhysics {
  const QuickerScrollPhysics({super.parent});

  @override
  QuickerScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return QuickerScrollPhysics(parent: buildParent(ancestor));
  }

  @override
  SpringDescription get spring => SpringDescription.withDampingRatio(
        mass: 0.2,
        stiffness: 300.0,
        ratio: 1.1,
      );
}
