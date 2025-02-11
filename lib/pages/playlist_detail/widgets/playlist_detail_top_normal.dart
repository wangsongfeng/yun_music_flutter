import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yun_music/commons/res/app_themes.dart';
import 'package:yun_music/commons/widgets/user_avatar_page.dart';
import 'package:yun_music/pages/playlist_collection/widget/generral_cover_playcount.dart';
import 'package:yun_music/pages/playlist_detail/playlist_detail_controller.dart';

import '../../../commons/res/dimens.dart';
import '../../../utils/adapt.dart';
import '../../../utils/image_utils.dart';
import 'playlist_detail_follow.dart';

class PlaylistDetailTopNormal extends StatelessWidget {
  const PlaylistDetailTopNormal({super.key, required this.controller});

  final PlaylistDetailController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Row(
        children: [
          GenerralCoverPlaycount(
            imageUrl: controller.detail.value?.playlist.coverImgUrl ?? '',
            playCount: controller.detail.value?.playlist.playCount ?? 0,
            coverSize: const Size(122, 122),
            coverRadius: Dimens.gap_dp8,
            imageCallback: (provider) async {
              await Future.delayed(const Duration(milliseconds: 10));
              controller.coverImage.value = provider;
            },
          ),
          SizedBox(width: Dimens.gap_dp14),
          Expanded(
            child: SizedBox(
              height: 122,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //name
                  if (controller.detail.value?.playlist.name != null)
                    Text(
                      controller.detail.value?.playlist.name ?? '',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 16,
                          color: Get.isDarkMode
                              ? AppThemes.white.withOpacity(0.9)
                              : AppThemes.white,
                          fontWeight: FontWeight.w600),
                    ),
                  //creator
                  Expanded(
                      child: Container(
                    alignment: Alignment.topLeft,
                    margin: const EdgeInsets.only(top: 12),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                            onTap: () {
                              // toUserDetail(
                              //     accountId: controller
                              //         .detail.value?.playlist.creator.userId);
                            },
                            child: RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(children: [
                                  WidgetSpan(
                                    alignment: PlaceholderAlignment.middle,
                                    child: UserAvatarPage(
                                      avatar: ImageUtils.getImageUrlFromSize(
                                          controller.detail.value?.playlist
                                              .creator.avatarUrl,
                                          Size(Dimens.gap_dp25,
                                              Dimens.gap_dp25)),
                                      size: Dimens.gap_dp25,
                                      identityIconUrl: controller
                                          .detail
                                          .value
                                          ?.playlist
                                          .creator
                                          .avatarDetail
                                          ?.identityIconUrl,
                                    ),
                                  ),
                                  WidgetSpan(
                                      child: SizedBox(width: Dimens.gap_dp2)),
                                  TextSpan(
                                      text: controller.detail.value?.playlist
                                          .creator.nickname,
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: AppThemes.white
                                              .withOpacity(0.7))),
                                ]))),
                        SizedBox(width: Dimens.gap_dp2),
                        //focuse creator
                        if (controller.detail.value?.playlist.creator != null)
                          PlaylistDetailFollow(
                            followed: controller
                                .detail.value!.playlist.creator.followed!,
                          )
                      ],
                    ),
                  )),
                  //description
                  Expanded(
                    flex: 0,
                    child: Row(
                      children: [
                        ConstrainedBox(
                            constraints:
                                BoxConstraints(maxWidth: Adapt.px(160)),
                            child: Text(
                              //所有的空白和换行 换成默认空白
                              controller.detail.value?.playlist.description
                                      ?.replaceAll(
                                          RegExp(r'\s+\b|\b\s|\n'), ' ') ??
                                  '暂无简介',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 12,
                                  color: AppThemes.white.withOpacity(0.7)),
                            )),
                        Image.asset(
                          ImageUtils.getImagePath('icon_more'),
                          height: 13,
                          width: 13,
                          color: AppThemes.white.withOpacity(0.65),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      );
    });
  }
}

class PlaylistDetailTopPlaceholder extends StatelessWidget {
  const PlaylistDetailTopPlaceholder(
      {super.key, this.coverSize = const Size(122, 122)});

  final Size coverSize;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // //突出的背景
            Container(
              height: Dimens.gap_dp4,
              margin:
                  EdgeInsets.only(left: Dimens.gap_dp6, top: Dimens.gap_dp4),
              width: coverSize.width - Dimens.gap_dp12,
              decoration: BoxDecoration(
                color: Get.isDarkMode
                    ? const Color.fromRGBO(160, 164, 172, 1.0)
                    : const Color.fromRGBO(160, 164, 172, 1.0),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Adapt.px(6)),
                    topRight: Radius.circular(Adapt.px(6))),
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.all(
                Radius.circular(Adapt.px(6)),
              ),
              child: Container(
                width: coverSize.width,
                height: coverSize.height,
                color: const Color.fromRGBO(160, 164, 172, 1.0),
              ),
            )
          ],
        ),
        SizedBox(width: Dimens.gap_dp14),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(top: Dimens.gap_dp10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    height: Dimens.gap_dp16,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(160, 164, 172, 1.0),
                      borderRadius:
                          BorderRadius.all(Radius.circular(Dimens.gap_dp8)),
                    )),
                SizedBox(
                  height: Dimens.gap_dp10,
                ),
                Container(
                    margin: EdgeInsets.only(right: Dimens.gap_dp36),
                    height: Dimens.gap_dp16,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(160, 164, 172, 1.0),
                      borderRadius:
                          BorderRadius.all(Radius.circular(Dimens.gap_dp8)),
                    )),
                SizedBox(
                  height: Dimens.gap_dp10,
                ),
                Row(
                  children: [
                    Container(
                        width: Dimens.gap_dp24,
                        height: Dimens.gap_dp24,
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(160, 164, 172, 1.0),
                          borderRadius: BorderRadius.all(
                              Radius.circular(Dimens.gap_dp12)),
                        )),
                    SizedBox(
                      width: Dimens.gap_dp10,
                    ),
                    Container(
                        width: Dimens.gap_dp48,
                        height: Dimens.gap_dp16,
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(160, 164, 172, 1.0),
                          borderRadius:
                              BorderRadius.all(Radius.circular(Dimens.gap_dp8)),
                        )),
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
