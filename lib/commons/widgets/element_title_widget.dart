import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yun_music/commons/models/ui_element_model.dart';
import 'package:yun_music/commons/res/dimens.dart';
import 'package:yun_music/commons/values/function.dart';
import 'package:yun_music/commons/widgets/element_button_widget.dart';
import 'package:yun_music/commons/widgets/network_img_layer.dart';
import 'package:yun_music/utils/adapt.dart';
import 'package:yun_music/utils/common_utils.dart';

class ElementTitleWidget extends StatelessWidget {
  const ElementTitleWidget(
      {super.key, required this.elementModel, this.onPressed});

  final UiElementModel elementModel;

  final ParamVoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: Dimens.gap_dp5),
        height: 48,
        margin: EdgeInsets.only(left: Dimens.gap_dp15, right: Dimens.gap_dp15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (!GetUtils.isNull(elementModel.subTitle))
              Expanded(
                  child: Row(
                children: [
                  if (GetUtils.isNullOrBlank(
                          elementModel.subTitle!.titleImgUrl) !=
                      true)
                    Wrap(
                      children: [
                        NetworkImgLayer(
                          width: Adapt.px(18),
                          height: Adapt.px(18),
                          color: headlineStyle().color,
                        ),
                        SizedBox(width: Dimens.gap_dp4)
                      ],
                    ),
                  SizedBox(
                    width: Adapt.px(240),
                    child: Text(
                      elementModel.subTitle!.title ?? "",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: headlineStyle(),
                    ),
                  )
                ],
              )),
            if (!GetUtils.isNull(elementModel.button))
              Expanded(
                  flex: 0,
                  child: elementButtonWidget(elementModel.button,
                      onPressed: onPressed))
          ],
        ));
  }
}
