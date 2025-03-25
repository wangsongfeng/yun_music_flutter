import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:yun_music/commons/widgets/network_img_layer.dart';
import 'package:yun_music/utils/adapt.dart';

import '../../../commons/res/app_themes.dart';
import '../../../commons/res/dimens.dart';

class FoundPickerSwiper extends StatelessWidget {
  const FoundPickerSwiper({super.key, required this.carousels});

  final List<String> carousels;

  @override
  Widget build(BuildContext context) {
    final swiperController = SwiperController();
    final double width = (Adapt.screenW() - Dimens.gap_dp30);
    final double height = 612.0 * width / 1075.0;
    return SizedBox(
      height: height + Dimens.gap_dp16,
      child: Swiper(
        controller: swiperController,
        itemCount: carousels.length,
        autoplay: carousels.length > 1,
        autoplayDelay: 6000,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {},
            child: Container(
              margin: EdgeInsets.fromLTRB(Dimens.gap_dp15, Dimens.gap_dp8,
                  Dimens.gap_dp15, Dimens.gap_dp8),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(Dimens.gap_dp6),
                child: Stack(
                  children: [
                    NetworkImgLayer(
                      fit: BoxFit.fitHeight,
                      width: width,
                      height: height,
                      src: carousels[index],
                    )
                  ],
                ),
              ),
            ),
          );
        },
        onIndexChanged: (index) async {},
        pagination: carousels.length > 1
            ? SwiperPagination(
                builder: DotSwiperPaginationBuilder(
                    color: AppThemes.white.withAlpha(80),
                    size: 5,
                    activeSize: 6,
                    space: 2,
                    activeColor: AppThemes.white))
            : null,
      ),
    );
  }
}
