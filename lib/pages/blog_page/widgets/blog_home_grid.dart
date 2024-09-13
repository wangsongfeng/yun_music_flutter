import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:yun_music/commons/widgets/custom_touch.dart';
import 'package:yun_music/pages/blog_page/models/blog_recom_model.dart';

import '../../../commons/res/app_routes.dart';
import '../../../commons/res/app_themes.dart';
import '../../../commons/res/dimens.dart';
import '../../../utils/adapt.dart';
import '../../playlist_collection/widget/generral_cover_playcount.dart';
import 'blog_header_widget.dart';

class BlogHomeGrid extends StatelessWidget {
  const BlogHomeGrid({super.key, required this.recomModel});

  final BlogRecomModel? recomModel;

  @override
  Widget build(BuildContext context) {
    final itemW = (Adapt.screenW() - Dimens.gap_dp30 - Dimens.gap_dp20) / 3.0;
    final childAspectRatio =
        (itemW + Dimens.gap_dp4 + Dimens.gap_dp6 + Dimens.gap_dp32);
    return Container(
      padding: EdgeInsets.only(top: Dimens.gap_dp6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlogHeaderWidget(
              onPressed: () {}, personal: null, recomModel: recomModel),
          GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: Dimens.gap_dp10,
                mainAxisSpacing: Dimens.gap_dp8,
                childAspectRatio: itemW / childAspectRatio),
            itemBuilder: (context, index) {
              final item = recomModel?.radios!.elementAt(index);
              return _buildItem(item!, itemW);
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

  Widget _buildItem(BlogRadios item, double itemWidth) {
    return BounceTouch(
      onPressed: () {
        Get.toNamed(RouterPath.Blog_Detail_Page, arguments: {
          "rid": item.id,
          "coverImgUrl": item.picUrl,
          "playcount": item.subCount
        });
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          GenerralCoverPlaycount(
            imageUrl: item.picUrl ?? '',
            playCount: item.playCount ?? 0,
            coverSize: Size(itemWidth, itemWidth),
            coverRadius: Dimens.gap_dp8,
          ),
          SizedBox(height: Dimens.gap_dp6),
          SizedBox(
            width: itemWidth,
            child: Text(
              item.name ?? "",
              maxLines: 2,
              softWrap: true,
              textAlign: TextAlign.left,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: Dimens.gap_dp11, color: AppThemes.body1_txt_color),
            ),
          )
        ],
      ),
    );
  }
}
