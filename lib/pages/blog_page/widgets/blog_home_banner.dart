import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

import '../../../commons/res/app_themes.dart';
import '../../../commons/res/dimens.dart';
import '../../../commons/widgets/network_img_layer.dart';
import '../../../utils/adapt.dart';
import '../../../utils/image_utils.dart';
import '../models/blog_banner_model.dart';

class BlogHomeBanner extends StatelessWidget {
  const BlogHomeBanner({super.key, required this.banners});

  final List<BlogBannerModel?> banners;

  @override
  Widget build(BuildContext context) {
    final swiperController = SwiperController();

    return SizedBox(
      height: Dimens.gap_dp140,
      child: Stack(
        children: [
          Swiper(
              controller: swiperController,
              index: 0,
              autoplay: banners.length > 1,
              autoplayDelay: 6000,
              itemBuilder: (context, index) {
                return _buildItem(index);
              },
              onIndexChanged: (index) async {},
              pagination: banners.length > 1
                  ? SwiperPagination(
                      builder: DotSwiperPaginationBuilder(
                          color: AppThemes.white.withAlpha(80),
                          size: 5,
                          activeSize: 6,
                          space: 2,
                          activeColor: AppThemes.white))
                  : null,
              itemCount: banners.length)
        ],
      ),
    );
  }

  Widget _buildItem(int index) {
    final banner = banners[index];
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.fromLTRB(
            Dimens.gap_dp15, Dimens.gap_dp5, Dimens.gap_dp15, 0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(Dimens.gap_dp12),
          child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
            return NetworkImgLayer(
              width: constraints.maxWidth,
              height: constraints.maxHeight,
              src: ImageUtils.getImageUrlFromSize(banner?.pic,
                  Size(Adapt.screenW() - Adapt.px(30), Adapt.px(135))),
              imageBuilder: (context, provider) {
                return Stack(
                  children: [
                    Positioned.fill(
                      child: Image(
                        image: provider,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: Container(
                          height: 60,
                          decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: <Color>[
                                    Colors.transparent,
                                    Colors.black26
                                  ],
                                  tileMode: TileMode.mirror)),
                        )),
                  ],
                );
              },
            );
          }),
        ),
      ),
    );
  }
}
