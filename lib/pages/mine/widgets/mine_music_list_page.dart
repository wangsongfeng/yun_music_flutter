import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:yun_music/commons/models/mine_music_list.dart';
import 'package:yun_music/commons/res/app_themes.dart';
import 'package:yun_music/commons/widgets/network_img_layer.dart';
import 'package:yun_music/pages/mine/widgets/mine_music_controller.dart';

import '../../../commons/res/dimens.dart';
import '../../../commons/widgets/music_loading.dart';
import '../../../utils/adapt.dart';

class MineMusicListPage extends StatefulWidget {
  const MineMusicListPage({super.key});

  @override
  State<MineMusicListPage> createState() => _MineMusicListPageState();
}

class _MineMusicListPageState extends State<MineMusicListPage> {
  final controller = Get.find<MineMusicController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return controller.mineMusicList.value == null
          ? Container(
              margin: const EdgeInsets.only(top: 100),
              child: Center(child: MusicLoading()),
            )
          : CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverPadding(
                  padding: EdgeInsets.only(
                    top: 12,
                    bottom: Dimens.gap_dp49 * 2 + Adapt.bottomPadding(),
                  ),
                  sliver: SliverList.builder(
                    itemBuilder: (context, index) {
                      final model =
                          controller.mineMusicList.value?.elementAt(index);
                      return _buildItem(model!, index);
                    },
                    itemCount: controller.mineMusicList.value?.length,
                  ),
                )
              ],
            );
    });
  }

  Widget _buildItem(MineMusicList item, int index) {
    return SizedBox(
      height: 70,
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: NetworkImgLayer(
                width: 60,
                height: 60,
                src: item.coverUrl,
              ),
            ),
            const SizedBox(width: 16),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name!,
                  style: const TextStyle(
                      fontSize: 15,
                      color: AppThemes.body1_txt_color,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "歌单 * ${item.num}首 * ${item.desc}",
                      style: const TextStyle(
                          fontSize: 12,
                          color: AppThemes.color_163,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
