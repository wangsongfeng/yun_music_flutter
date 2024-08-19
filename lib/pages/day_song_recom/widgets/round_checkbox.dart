// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:yun_music/commons/res/app_themes.dart';
import 'package:yun_music/commons/res/dimens.dart';
import 'package:yun_music/utils/image_utils.dart';

class RoundCheckbox extends StatefulWidget {
  RoundCheckbox({
    super.key,
    this.size = 22,
    required this.value,
  });

  bool value = false;

  double size;

  @override
  State<RoundCheckbox> createState() => _RoundCheckboxState();
}

class _RoundCheckboxState extends State<RoundCheckbox> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: widget.value
            ? ClipOval(
                child: Container(
                  width: widget.size,
                  height: widget.size,
                  color: AppThemes.app_main_light,
                  child: Image.asset(
                    ImageUtils.getImagePath('icn_check'),
                    width: Dimens.gap_dp14,
                    color: AppThemes.white,
                  ),
                ),
              )
            : Image.asset(
                ImageUtils.getImagePath('icn_checkbox'),
                width: widget.size,
                height: widget.size,
                color: AppThemes.text_gray,
              ));
  }
}
