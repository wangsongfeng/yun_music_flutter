// ignore_for_file: deprecated_member_use

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keframe/keframe.dart';
import 'package:yun_music/commons/models/ui_element_model.dart';
import 'package:yun_music/commons/res/app_themes.dart';
import 'package:yun_music/commons/res/dimens.dart';
import 'package:yun_music/commons/res/routes_utils.dart';
import 'package:yun_music/commons/widgets/custom_touch.dart';
import 'package:yun_music/commons/widgets/element_title_widget.dart';
import 'package:yun_music/commons/widgets/network_img_layer.dart';
import 'package:yun_music/commons/widgets/playcount_widget.dart';
import 'package:yun_music/pages/recommend/models/creative_model.dart';
import 'package:yun_music/pages/recommend/widgets/recom_playlist_ver.dart';
import 'package:yun_music/utils/adapt.dart';
import 'package:yun_music/utils/common_utils.dart';
import 'package:yun_music/utils/image_utils.dart';

class RecomPlaylistCell extends StatelessWidget {
  const RecomPlaylistCell(
      {super.key,
      required this.uiElementModel,
      required this.creatives,
      required this.curIndex,
      required this.itemHeight});

  final UiElementModel uiElementModel;
  final List<CreativeModel> creatives;
  final int curIndex;
  final double itemHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Get.theme.cardColor,
          borderRadius: BorderRadius.only(
              //第三个item 上边的圆角保留
              topLeft: curIndex == 2
                  ? const Radius.circular(0)
                  : Radius.circular(Dimens.gap_dp10),
              topRight: curIndex == 2
                  ? const Radius.circular(0)
                  : Radius.circular(Dimens.gap_dp10),
              bottomLeft: Radius.circular(Dimens.gap_dp10),
              bottomRight: Radius.circular(Dimens.gap_dp10))),
      child: SizedBox(
        height: itemHeight,
        child: Column(
          children: [
            Expanded(
              flex: 0,
              child: ElementTitleWidget(
                elementModel: uiElementModel,
                onPressed: () {
                  RoutesUtils.routeFromActionStr(uiElementModel.button?.action);
                },
              ),
            ),
            Flexible(
              child: ListView.separated(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.only(
                    left: Dimens.gap_dp15, right: Dimens.gap_dp15),
                itemBuilder: (context, index) {
                  final model = creatives[index];
                  return FrameSeparateWidget(
                    index: index,
                    placeHolder: SizedBox(
                      width: Dimens.gap_dp109,
                      height: Dimens.gap_dp109,
                    ),
                    child: BounceTouch(
                      onPressed: () {
                        RoutesUtils.routeFromActionStr(model.action);
                      },
                      child: _buildItem(model, Get.theme),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(width: Dimens.gap_dp9);
                },
                itemCount: creatives.length,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItem(CreativeModel model, ThemeData thme) {
    if (GetUtils.isNullOrBlank(model.resources) == true) {
      return const SizedBox.shrink();
    }
    if (model.creativeType == 'scroll_playlist') {
      //垂直滚动的歌单卡片
      return RecomPlistVerScroll(
        resources: model.resources!,
      );
    } else {
      final resource = model.resources![0];
      final extInfo = ResourceExtInfoModel.fromJson(resource.resourceExtInfo);
      return SizedBox(
        width: Dimens.gap_dp109,
        child: Column(
          children: [
            //突出的背景
            Container(
              height: Dimens.gap_dp4,
              margin: EdgeInsets.only(
                  left: Dimens.gap_dp12, right: Dimens.gap_dp12),
              decoration: BoxDecoration(
                color: Colors.grey.shade300.withOpacity(0.4),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimens.gap_dp12),
                    topRight: Radius.circular(Dimens.gap_dp12)),
              ),
            ),
            //图片
            ClipRRect(
              borderRadius: BorderRadius.circular(Dimens.gap_dp10),
              child: NetworkImgLayer(
                width: Dimens.gap_dp105,
                height: Dimens.gap_dp105,
                src: ImageUtils.getImageUrlFromSize(
                    resource.uiElement.image?.imageUrl,
                    Size(Dimens.gap_dp105, Dimens.gap_dp105)),
                imageBuilder: (context, provider) {
                  return Stack(
                    children: [
                      Image(
                        image: provider,
                        fit: BoxFit.cover,
                      ),
                      //额外的样式 播放量等
                      _buildExtWidget(extInfo, provider),
                    ],
                  );
                },
              ),
            ),

            SizedBox(height: Dimens.gap_dp5),
            //标题
            Text(
              resource.uiElement.mainTitle?.title ?? "",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: body1Style().copyWith(
                fontFamily: W.fonts.IconFonts,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
      );
    }
  }

  Widget _buildExtWidget(ResourceExtInfoModel extInfo, ImageProvider provider) {
    switch (extInfo.specialType) {
      case 200:
        // 视频封面渐变
        return Positioned.fill(
            child: Stack(
          children: [
            //模糊背景
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(),
            ),

            //播放量 不需要背景
            _buildPlaycountWidget(extInfo.playCount, provider, needBg: false),

            Center(
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(Dimens.gap_dp5),
                    child: Image(
                      image: provider,
                      width: Adapt.px(90),
                      height: Adapt.px(64),
                      fit: BoxFit.cover,
                    ),
                  ),
                  Image.asset(
                    ImageUtils.getImagePath('d7o'),
                    width: Adapt.px(90),
                    height: Adapt.px(64),
                    fit: BoxFit.fill,
                  )
                ],
              ),
            )
          ],
        ));
      case 300:
        if (GetUtils.isNullOrBlank(extInfo.users) == false) {
          final userInfo = extInfo.users![0];
          return Positioned.fill(
            child: Stack(
              children: [
                _buildPlaycountWidget(extInfo.playCount, provider),
                Positioned(
                  right: Dimens.gap_dp3,
                  bottom: Dimens.gap_dp3,
                  child: _buildUser(userInfo),
                )
              ],
            ),
          );
        }
    }
    //只有播放量
    return _buildPlaycountWidget(extInfo.playCount, provider);
  }

  Widget _buildUser(userInfo) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
              color: AppThemes.white.withOpacity(0.2),
              borderRadius: BorderRadius.all(Radius.circular(Dimens.gap_dp8))),
          width: Dimens.gap_dp15,
          height: Dimens.gap_dp15,
        ),
        Container(
          margin: EdgeInsets.only(left: Dimens.gap_dp3),
          decoration: BoxDecoration(
              color: AppThemes.white.withOpacity(0.6),
              borderRadius: BorderRadius.all(Radius.circular(Dimens.gap_dp8))),
          width: Dimens.gap_dp15,
          height: Dimens.gap_dp15,
        ),
        LayoutBuilder(builder: (context, contrains) {
          return NetworkImgLayer(
            width: Dimens.gap_dp105,
            height: Dimens.gap_dp105,
            src: userInfo.avatarUrl,
            imageBuilder: (context, provider) {
              return ClipOval(
                child: Container(
                  margin: EdgeInsets.only(left: Dimens.gap_dp6),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: AppThemes.white, width: Dimens.gap_dp1)),
                  child: Image(
                    image: provider,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          );
        })
      ],
    );
  }

  Widget _buildPlaycountWidget(int count, ImageProvider<Object> provider,
      {bool needBg = true}) {
    if (needBg) {
      return Positioned(
          right: Dimens.gap_dp4,
          top: Dimens.gap_dp4,
          child: ClipRRect(
            borderRadius: BorderRadius.all(
              Radius.circular(Dimens.gap_dp8),
            ),
            child: PlayCountWidget(
              playCount: count,
              needBg: needBg,
            ),
          ));
    } else {
      return Positioned(
          right: Dimens.gap_dp4,
          top: Dimens.gap_dp4,
          child: Container(
            padding:
                EdgeInsets.only(left: Dimens.gap_dp7, right: Dimens.gap_dp7),
            height: Dimens.gap_dp16,
            child: PlayCountWidget(
              playCount: count,
              needBg: needBg,
            ),
          ));
    }
  }
}
