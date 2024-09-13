import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yun_music/commons/widgets/network_img_layer.dart';

import '../../../commons/res/dimens.dart';
import '../../../commons/values/constants.dart';
import '../../../utils/adapt.dart';
import '../../../utils/common_utils.dart';
import '../../../utils/image_utils.dart';
import '../models/album_cover_info.dart';

class NewAlbumTopPage extends StatelessWidget {
  const NewAlbumTopPage({super.key, this.newAlbums});

  final List<AlbumCoverInfo>? newAlbums;

  @override
  Widget build(BuildContext context) {
    final url = box.read<String>(CACHE_ALBUM_POLY_DETAIL_URL);
    final itemsW =
        (Adapt.screenW() - Dimens.font_sp16 * 2 - Dimens.gap_dp10 * 2) / 3.0;
    final itemsH = (itemsW + 10 + 6 + 40);
    return Container(
      margin: EdgeInsets.only(left: Dimens.font_sp16, right: Dimens.font_sp16),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                  child: Text(
                '数字专辑',
                textAlign: TextAlign.start,
                style: headlineStyle(),
              )),
              if (GetUtils.isNullOrBlank(url) != true)
                UnconstrainedBox(
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.only(
                          left: 5, right: 5, top: 2, bottom: 2),
                      // margin: const EdgeInsets.only(right: 15),
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(12.0)),
                          border: Border.all(
                              color: const Color(0xFF999999).withOpacity(0.5))),
                      child: Text("更多热销专辑",
                          style: TextStyle(
                            color: const Color(0xFF333333),
                            fontSize: Dimens.font_sp12,
                          )),
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: Dimens.gap_dp10),
          GridView.builder(
            padding: EdgeInsets.only(bottom: Dimens.gap_dp10),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: Dimens.gap_dp10,
              mainAxisSpacing: 0,
              childAspectRatio: itemsW / itemsH,
            ),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final item = newAlbums?.elementAt(index);
              return _buidleItems(item);
            },
            itemCount: newAlbums?.length,
          ),
        ],
      ),
    );
  }

  Widget _buidleItems(AlbumCoverInfo? item) {
    return LayoutBuilder(builder: (context, contapax) {
      return GestureDetector(
        onTap: () {},
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              ImageUtils.getImagePath('cqb'),
              width: contapax.maxWidth,
              height: 10,
              fit: BoxFit.fill,
            ),
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(Dimens.gap_dp8)),
              child: NetworkImgLayer(
                width: contapax.maxWidth,
                height: contapax.maxWidth,
                src: ImageUtils.getImageUrlFromSize(
                  item?.coverUrl,
                  Size(Dimens.gap_dp140, Dimens.gap_dp140),
                ),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              item?.albumName ?? "",
              style: body1Style().copyWith(fontWeight: FontWeight.w500),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(item?.artistName ?? "",
                style: captionStyle(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis)
          ],
        ),
      );
    });
  }
}
