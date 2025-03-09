// ignore_for_file: must_be_immutable, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:yun_music/commons/res/app_themes.dart';

import '../../utils/adapt.dart';
import '../../utils/image_utils.dart';
import '../res/dimens.dart';

class RoundCheckBox extends StatefulWidget {
  bool value = false;

  double size;

  // final ParamSingleCallback<bool> onChanged;

  RoundCheckBox(Key? key, {required this.value, this.size = 18})
      : super(key: key);

  @override
  _RoundCheckBoxState createState() => _RoundCheckBoxState();
}

class _RoundCheckBoxState extends State<RoundCheckBox> {
  @override
  Widget build(BuildContext context) {
    final size = Adapt.px(widget.size);
    return Center(
      child: widget.value
          ? ClipOval(
              child: Container(
                width: size,
                height: size,
                color: AppThemes.app_main_light,
                child: Image.asset(
                  ImageUtils.getImagePath('icn_check'),
                  width: Dimens.gap_dp12,
                  color: AppThemes.white,
                ),
              ),
            )
          : Image.asset(
              ImageUtils.getImagePath('icn_checkbox'),
              width: size,
              height: size,
              color: AppThemes.text_gray,
            ),
      // ),
    );
  }
}
