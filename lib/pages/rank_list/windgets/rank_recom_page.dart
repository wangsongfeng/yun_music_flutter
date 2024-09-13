import 'package:flutter/material.dart';
import 'package:yun_music/commons/res/dimens.dart';
import 'package:yun_music/commons/widgets/network_img_layer.dart';
import 'package:yun_music/pages/rank_list/models/ranklist_item.dart';
import 'package:yun_music/pages/rank_list/ranklist_contrller.dart';
import 'package:yun_music/utils/common_utils.dart';

import '../../../utils/adapt.dart';
import '../../../utils/image_utils.dart';

class RankRecomPage extends StatelessWidget {
  const RankRecomPage({super.key, required this.contrller});

  final RanklistContrller contrller;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          left: Dimens.gap_dp16, right: Dimens.gap_dp16, top: Dimens.gap_dp10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '榜单推荐',
            style: headlineStyle(),
          ),
          SizedBox(height: Dimens.gap_dp10),
          GridView.builder(
              padding: EdgeInsets.only(bottom: Dimens.gap_dp10),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: Dimens.gap_dp12,
                mainAxisSpacing: 0,
              ),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: contrller.rcmdItem().length,
              itemBuilder: (context, index) {
                final model = contrller.rcmdItem().elementAt(index);
                return _buildItems(model);
              })
        ],
      ),
    );
  }

  Widget _buildItems(RanklistItem item) {
    return Stack(
      children: [
        LayoutBuilder(builder: (context, contarints) {
          return NetworkImgLayer(
            height: contarints.maxWidth,
            width: contarints.maxWidth,
            src: ImageUtils.getImageUrlFromSize(
                item.coverImgUrl, Size(Adapt.px(100), Adapt.px(100))),
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
                    left: Dimens.gap_dp6,
                    right: Dimens.gap_dp6,
                    bottom: Dimens.gap_dp30,
                    child: Center(
                      child: Text(
                        item.updateFrequency,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontSize: Dimens.font_sp10,
                        ),
                      ),
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
          );
        }),
      ],
    );
  }
}
