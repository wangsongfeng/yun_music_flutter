// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyTextButtonWithIcon extends TextButton {
  final AxisDirection axisDirection;

  MyTextButtonWithIcon({
    super.key,
    required super.onPressed,
    super.onLongPress,
    super.focusNode,
    bool? autofocus,
    Clip? clipBehavior,
    double? gap,
    this.axisDirection = AxisDirection.left,
    required Widget icon,
    required Widget label,
  }) : super(
          style: ButtonStyle(
              padding: WidgetStateProperty.all(EdgeInsets.zero),
              overlayColor: WidgetStateProperty.all(
                  Get.theme.dividerColor.withOpacity(0.5))),
          autofocus: autofocus ?? false,
          clipBehavior: clipBehavior ?? Clip.none,
          child: _TextButtonWithIconChild(
            icon: icon,
            label: label,
            gap: gap ?? 4,
            axisDirection: axisDirection,
          ),
        );
}


class _TextButtonWithIconChild extends StatelessWidget {
  const _TextButtonWithIconChild({
    super.key, 
    required this.label, 
    required this.icon, 
    this.gap = 4, 
    required this.axisDirection});

  final Widget label;
  final Widget icon;
  final double gap;
  final AxisDirection axisDirection;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        if (axisDirection == AxisDirection.left)
          icon
        else
          Flexible(child: label),
        SizedBox(width: gap),
        if (axisDirection == AxisDirection.left)
          Flexible(child: label)
        else
          icon
      ],
    );
  }
}
