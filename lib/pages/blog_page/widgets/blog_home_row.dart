import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:yun_music/commons/res/dimens.dart';
import 'package:yun_music/commons/widgets/custom_touch.dart';
import 'package:yun_music/utils/common_utils.dart';

import '../../../commons/res/app_routes.dart';
import '../../../commons/widgets/network_img_layer.dart';
import '../../../utils/image_utils.dart';
import '../models/blog_recom_model.dart';
import 'blog_header_widget.dart';

class BlogHomeRow extends StatelessWidget {
  const BlogHomeRow({super.key, this.recomModel});

  final BlogRecomModel? recomModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: Dimens.gap_dp6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlogHeaderWidget(
              onPressed: () {}, personal: null, recomModel: recomModel),
          GridView.builder(
            scrollDirection: Axis.vertical,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                mainAxisExtent: Dimens.gap_dp80,
                mainAxisSpacing: Dimens.gap_dp16),
            itemBuilder: (context, index) {
              final item = recomModel?.radios!.elementAt(index);
              return _buildConendItem(item!);
            },
            itemCount: recomModel!.radios!.length,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: EdgeInsets.only(
                left: Dimens.gap_dp15,
                right: Dimens.gap_dp15,
                top: Dimens.gap_dp10,
                bottom: Dimens.gap_dp6),
          )
        ],
      ),
    );
  }

  Widget _buildConendItem(BlogRadios model) {
    return BounceTouch(
      onPressed: () {
        Get.toNamed(RouterPath.Blog_Detail_Page, arguments: {
          "rid": model.id,
          "coverImgUrl": model.picUrl,
          "playcount": model.subCount
        });
      },
      child: SizedBox(
        height: Dimens.gap_dp80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            NetworkImgLayer(
              height: Dimens.gap_dp80,
              width: Dimens.gap_dp80,
              src: model.picUrl,
              imageBuilder: (context, provider) {
                return Stack(
                  children: [
                    ClipRRect(
                      borderRadius:
                          BorderRadius.all(Radius.circular(Dimens.gap_dp8)),
                      child: Image(
                        image: provider,
                      ),
                    ),
                    Positioned(
                      bottom: Dimens.gap_dp8,
                      right: Dimens.gap_dp8,
                      child: Image.asset(
                        ImageUtils.getImagePath('cm8_home_song_rcmd'),
                        width: 20,
                        height: 20,
                      ),
                    )
                  ],
                );
              },
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 6),
                  Text(
                    model.rcmdText!,
                    maxLines: 2,
                    style: headline2Style(),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.only(left: 2, right: 2),
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(4.0)),
                        border: Border.all(color: const Color(0xFF999999))),
                    child: const Text(
                      "情感故事",
                      style: TextStyle(
                        color: Color(0xFF999999),
                        fontSize: 11,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          constraints:
                              BoxConstraints(maxWidth: Dimens.gap_dp135),
                          child: Text(
                            model.name ?? "",
                            softWrap: true,
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: const TextStyle(
                              color: Color(0xFF999999),
                              fontSize: 12,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: _buildChildIconRow(
                              model.playCount!, "cm4_list_icn_play_time"),
                        ),
                        _buildChildIconRow(
                            model.programCount!, "cm2_list_search_time")
                      ],
                    ),
                  )
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }

  Widget _buildChildIconRow(int count, String assetName) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 3),
          child: Image.asset(
            ImageUtils.getImagePath(assetName),
            width: 10,
          ),
        ),
        Text(
          getPlayCountStrFromInt(count),
          style: const TextStyle(
            color: Color(0xFF999999),
            fontSize: 10,
          ),
        )
      ],
    );
  }
}
