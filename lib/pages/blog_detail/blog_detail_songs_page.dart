import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yun_music/pages/blog_detail/blog_detail_controller.dart';
import 'package:yun_music/utils/adapt.dart';
import 'package:yun_music/utils/common_utils.dart';

import '../../commons/res/app_themes.dart';
import '../../commons/res/dimens.dart';
import '../../commons/widgets/music_loading.dart';
import '../../commons/widgets/network_img_layer.dart';
import '../../utils/image_utils.dart';
import 'models/blog_detail_lists.dart';

class BlogDetailSongsPage extends StatelessWidget {
  BlogDetailSongsPage({super.key});

  final controller = Get.find<BlogDetailController>();

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        Obx(() {
          return controller.detailListModel.value == null
              ? SliverToBoxAdapter(
                  child: Container(
                    margin: EdgeInsets.only(top: Dimens.gap_dp60),
                    child: MusicLoading(
                      axis: Axis.horizontal,
                    ),
                  ),
                )
              : SliverFixedExtentList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return _buildItems(
                          context,
                          controller.detailListModel.value!.programs!
                              .elementAt(index));
                    },
                    childCount:
                        controller.detailListModel.value!.programs?.length ?? 0,
                  ),
                  itemExtent: 80,
                );
        })
      ],
    );
  }

  Widget _buildItems(BuildContext conetext, BlogDetailProgramItem program) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 80,
        margin: const EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 15),
        child: Row(
          children: [
            //封面
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(4)),
              child: NetworkImgLayer(
                width: 60,
                height: 60,
                src: ImageUtils.getImageUrlFromSize(
                    program.coverUrl, const Size(80, 80)),
                customplaceholder:
                    Container(color: AppThemes.load_image_placeholder()),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      program.name ?? "",
                      style: body1Style().copyWith(
                          color: conetext.isDarkMode
                              ? Colors.white.withOpacity(0.9)
                              : Colors.black.withOpacity(0.75),
                          fontFamily: W.fonts.IconFonts,
                          fontWeight: FontWeight.bold),
                      maxLines: 2,
                      softWrap: true,
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Row(
                      children: [
                        Text(
                          TimeUtils.getFormat1(time: program.createTime ?? 0),
                          style: const TextStyle(
                              fontSize: 12, color: Color(0xFF999999)),
                        ),
                        _buildRowIcon(
                            getPlayCountStrFromInt(program.listenerCount ?? 0),
                            "cm4_list_icn_play_time.png"),
                        _buildRowIcon(
                            TimeUtils.getMinuteFromMillSecond(
                                program.duration ?? 0),
                            "cm2_list_search_time.png")
                      ],
                    )
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: SizedBox(
                width: 20,
                height: 20,
                child: Image.asset(
                  ImageUtils.getImagePath('cb'),
                  color: const Color(0xFF999999),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildRowIcon(String text, String imgName) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 4),
          child: Image.asset(
            "assets/images/$imgName",
            width: 10,
            color: const Color(0xFF999999),
          ),
        ),
        Text(
          text,
          style: const TextStyle(fontSize: 12, color: Color(0xFF999999)),
        )
      ],
    );
  }
}
