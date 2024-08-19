
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yun_music/commons/models/ui_element_model.dart';
import 'package:yun_music/commons/res/dimens.dart';
import 'package:yun_music/commons/values/constants.dart';
import 'package:yun_music/commons/values/function.dart';
import 'package:yun_music/utils/image_utils.dart';

Widget elementButtonWidget(ElementButton? elementButton,
    {ParamVoidCallback? onPressed}) {
  if (elementButton == null) return const SizedBox.shrink();
  final theme = Get.theme;
  return MaterialButton(
    onPressed: () {
      if (onPressed == null) {
        // RouteUtils.routeFromActionStr(elementButton.action);
      } else {
        onPressed.call();
      }
    },
    height: Dimens.gap_dp24,
    color: Colors.transparent,
    highlightColor: theme.hintColor,
    elevation: 0,
    padding: const EdgeInsets.all(0),
    minWidth: Dimens.gap_dp40,
    focusElevation: 0,
    highlightElevation: 0,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Dimens.gap_dp12),
        side: BorderSide(
          color: theme.hintColor,
        )),
    child: Row(children: [
      SizedBox(width: Dimens.gap_dp12),
      if (elementButton.actionType == "client_customized")
        Image.asset(ImageUtils.getImagePath('icon_play_small'),
            color: theme.iconTheme.color,
            width: Dimens.gap_dp12,
            height: Dimens.gap_dp12),
      Text(
        elementButton.text.toString(),
        style:
            TextStyle(fontSize: Dimens.font_sp12, color: theme.iconTheme.color),
      ),
      if (elementButton.actionType == APP_ROUTER_TAG)
        Image.asset(ImageUtils.getImagePath('icon_more'),
            color: theme.iconTheme.color,
            width: Dimens.gap_dp12,
            height: Dimens.gap_dp12),
      SizedBox(width: Dimens.gap_dp10),
    ]),
  );
}
