// ignore_for_file: must_be_immutable

import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yun_music/commons/res/app_themes.dart';
import 'package:yun_music/commons/res/dimens.dart';
import 'package:yun_music/commons/widgets/custom_touch.dart';
import 'package:yun_music/commons/widgets/network_img_layer.dart';
import 'package:yun_music/pages/recommend/models/creative_model.dart';
import 'package:yun_music/utils/common_utils.dart';
import 'package:yun_music/utils/image_utils.dart';

class RecomPlistVerScroll extends StatefulWidget {
  RecomPlistVerScroll({super.key, required this.resources});

  List<Resources> resources;

  @override
  State<RecomPlistVerScroll> createState() => _RecomPlistVerScrollState();
}

class _RecomPlistVerScrollState extends State<RecomPlistVerScroll> {
  final res = Rx<Resources?>(null);
  late SwiperController swiperController;

  @override
  void initState() {
    swiperController = SwiperController();
    super.initState();
  }

  @override
  void dispose() {
    swiperController.dispose();
    super.dispose();
  }

  @override
  void deactivate() {
    swiperController.stopAutoplay();
    super.deactivate();
  }

  @override
  void activate() {
    swiperController.startAutoplay();
    super.activate();
  }

  @override
  Widget build(BuildContext context) {
    res.value = widget.resources.first;
    return BounceTouch(
      onPressed: () {},
      child: SizedBox(
        width: Dimens.gap_dp109,
        child: Column(
          children: [
            SizedBox(height: Dimens.gap_dp4),
            Stack(
              children: [
                //边框
                Container(
                  width: Dimens.gap_dp105,
                  height: Dimens.gap_dp105,
                  decoration: BoxDecoration(
                      color: Get.theme.scaffoldBackgroundColor,
                      border: Border.all(
                          color: AppThemes.color_217, width: Dimens.gap_dp1),
                      borderRadius:
                          BorderRadius.all(Radius.circular(Dimens.gap_dp10))),
                  child: const SizedBox.shrink(),
                ),
                //滑动轮播
                Positioned.fill(
                    child: Swiper(
                  index: 0,
                  itemCount: widget.resources.length,
                  itemBuilder: (context, index) {
                    final resource = widget.resources.elementAt(index);
                    return ClipRRect(
                      borderRadius:
                          BorderRadius.all(Radius.circular(Dimens.gap_dp10)),
                      child: NetworkImgLayer(
                        width: Dimens.gap_dp105, 
                        height: Dimens.gap_dp105,
                        src:  ImageUtils.getImageUrlFromSize(
                            resource.uiElement.image?.imageUrl,
                            Size(Dimens.gap_dp105, Dimens.gap_dp105)),
                      ),
                    );
                  },
                  onIndexChanged: (index) {
                    res.value = widget.resources.elementAt(index);
                  },
                  controller: swiperController,
                  scrollDirection: Axis.vertical,
                  itemHeight: Dimens.gap_dp105,
                  itemWidth: Dimens.gap_dp105,
                  autoplay: true,
                  autoplayDelay: 4000,
                  duration: 600,
                  scale: 0.8,
                )),
              ],
            ),

            //标题
            SizedBox(height: Dimens.gap_dp5),
            //标题
            Obx(() => Text(
                  res.value?.uiElement.mainTitle?.title ?? "",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: body1Style(),
                ))
          ],
        ),
      ),
    );
  }
}
