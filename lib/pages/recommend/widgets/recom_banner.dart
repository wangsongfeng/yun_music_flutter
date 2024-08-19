// ignore_for_file: use_super_parameters

import 'dart:collection';

import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:yun_music/commons/event/index.dart';
import 'package:yun_music/commons/models/banner_model.dart';
import 'package:yun_music/commons/res/app_themes.dart';
import 'package:yun_music/commons/res/dimens.dart';
import 'package:yun_music/commons/widgets/network_img_layer.dart';
import 'package:yun_music/pages/recommend/recom_controller.dart';
import 'package:yun_music/utils/adapt.dart';
import 'package:yun_music/utils/image_utils.dart';

class RecomBanner extends StatefulWidget {
  const RecomBanner(
      {Key? key, required this.bannerModel, required this.itemHeight})
      : super(key: key);

  final BannerModel bannerModel;
  final double itemHeight;

  @override
  State<RecomBanner> createState() => _RecomBannerState();
}

class _RecomBannerState extends State<RecomBanner>
    with AutomaticKeepAliveClientMixin {
  final imageMap = HashMap<String?, ImageProvider>();
  late SwiperController swiperController;

  final recomController = GetInstance().find<RecomController>();

  Future<void> _updatePaletteGenerator(String? bannerId) async {
    if (!imageMap.containsKey(bannerId)) return;
    await Future.delayed(const Duration(milliseconds: 300));
    final paletteGenerator = await PaletteGenerator.fromImageProvider(
      imageMap[bannerId]!,
    );
    final dominColor =
        paletteGenerator.dominantColor?.color ?? Colors.transparent;
    eventBus.fire(dominColor);
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
  void initState() {
    super.initState();
    swiperController = SwiperController();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SizedBox(
      height: widget.itemHeight,
      child: Stack(
        children: [
          Positioned.fill(
              child: Obx(() => Container(
                    color: recomController.isScrolled.value
                        ? Get.theme.cardColor
                        : Colors.transparent,
                  ))),
          Swiper(
              controller: swiperController,
              index: 0,
              autoplay: widget.bannerModel.banner.length > 1,
              autoplayDelay: 6000,
              itemBuilder: (context, index) {
                return _buildItem(index);
              },
              onIndexChanged: (index) async {
                _updatePaletteGenerator(
                    widget.bannerModel.banner[index].bannerId);
              },
              pagination: widget.bannerModel.banner.length > 1
                  ? SwiperPagination(
                      builder: DotSwiperPaginationBuilder(
                          color: AppThemes.white.withAlpha(80),
                          size: 5,
                          activeSize: 6,
                          space: 2,
                          activeColor: AppThemes.white))
                  : null,
              itemCount: widget.bannerModel.banner.length)
        ],
      ),
    );
  }

  Widget _buildItem(int index) {
    final banner = widget.bannerModel.banner[index];
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
              src: ImageUtils.getImageUrlFromSize(banner.pic,
                  Size(Adapt.screenW() - Adapt.px(30), Adapt.px(135))),
              imageBuilder: (context, provider) {
                if (!imageMap.containsKey(banner.bannerId)) {
                  imageMap[banner.bannerId] = provider;
                  _updatePaletteGenerator(banner.bannerId);
                }
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
                    if (!banner.showAdTag)
                      const SizedBox.shrink()
                    else
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: Container(
                            height: Dimens.gap_dp17,
                            decoration: BoxDecoration(
                                color: banner.titleColor == "red"
                                    ? AppThemes.app_main
                                    : context.theme.highlightColor,
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(12))),
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: Center(
                              child: Text(
                                banner.typeTitle!,
                                style: TextStyle(
                                    color: AppThemes.white,
                                    fontSize: Dimens.font_sp12),
                              ),
                            )),
                      )
                  ],
                );
              },
            );
          }),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
