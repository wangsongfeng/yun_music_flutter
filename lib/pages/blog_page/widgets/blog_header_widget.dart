import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yun_music/commons/res/dimens.dart';
import 'package:yun_music/pages/blog_page/models/blog_personal_model.dart';
import 'package:yun_music/utils/image_utils.dart';

import '../../../commons/values/function.dart';
import '../../../utils/common_utils.dart';
import '../models/blog_recom_model.dart';

class BlogHeaderWidget extends StatelessWidget {
  const BlogHeaderWidget(
      {super.key, this.personal, this.recomModel, this.onPressed});

  final BlogPersonalModel? personal;

  final BlogRecomModel? recomModel;

  final ParamVoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    if (personal == null && recomModel == null) {
      return const SizedBox.shrink();
    }
    return Container(
      padding: EdgeInsets.only(left: Dimens.gap_dp15, right: Dimens.gap_dp15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildLeftWidget(),
          _buildRightWidget(),
        ],
      ),
    );
  }

  Widget _buildLeftWidget() {
    if (personal != null) {
      return Row(
        children: [
          Image.asset(ImageUtils.getImagePath('cm8_refresh_new_items')),
          Padding(
            padding: EdgeInsets.only(left: Dimens.gap_dp3),
            child: Text(
              '猜你喜欢',
              style: headlineStyle(),
            ),
          )
        ],
      );
    }
    return Text(
      recomModel?.categoryName ?? "",
      style: headlineStyle(),
    );
  }

  Widget _buildRightWidget() {
    String str = personal != null ? "兴趣定制" : "更多";
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.only(
            left: Dimens.gap_dp8,
            right: Dimens.gap_dp8,
            top: Dimens.gap_dp2,
            bottom: Dimens.gap_dp3),
        decoration: BoxDecoration(
            border: Border.all(color: Get.theme.hintColor),
            borderRadius: BorderRadius.all(Radius.circular(Dimens.gap_dp15))),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              str,
              style: TextStyle(
                  fontSize: Dimens.font_sp11, color: Get.theme.iconTheme.color),
            ),
            Image.asset(
              ImageUtils.getImagePath('icon_more'),
              width: Dimens.gap_dp13,
              color: Get.theme.iconTheme.color,
            ),
          ],
        ),
      ),
    );
  }
}
