// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yun_music/commons/res/dimens.dart';
import 'package:yun_music/pages/blog_detail/blog_detail_controller.dart';
import 'package:yun_music/pages/blog_detail/models/blog_detail_model.dart';
import 'package:yun_music/pages/playlist_collection/widget/generral_cover_playcount.dart';
import 'package:yun_music/utils/adapt.dart';
import 'package:yun_music/utils/common_utils.dart';

import '../../../commons/res/app_themes.dart';
import '../../../commons/skeleton/music_skeleton.dart';
import '../../../commons/widgets/user_avatar_page.dart';
import '../../../utils/image_utils.dart';
import '../../playlist_detail/widgets/playlist_detail_follow.dart';
import '../../playlist_detail/widgets/playlist_detail_top_normal.dart';

class BlogDetailHeader extends StatefulWidget {
  const BlogDetailHeader({super.key, required this.controller});

  final BlogDetailController controller;

  @override
  State<BlogDetailHeader> createState() => _BlogDetailHeaderState();
}

class _BlogDetailHeaderState extends State<BlogDetailHeader> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(child: Obx(() {
          return Container(
            height: widget.controller.headerHeight.value,
            color: widget.controller.headerBgColor.value != null
                ? widget.controller.headerBgColor.value?.withOpacity(1.0)
                : const Color.fromRGBO(146, 150, 160, 1.0),
          );
        })),
        Positioned.fill(
            child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: const [
                  0,
                  0.6,
                  1
                ],
                colors: [
                  Colors.transparent,
                  Colors.white.withOpacity(0),
                  Colors.white.withOpacity(0.2)
                ]),
          ),
        )),
        Container(
            height: widget.controller.headerHeight.value,
            color: Colors.transparent,
            padding: EdgeInsets.only(
                left: Dimens.gap_dp15,
                right: Dimens.gap_dp15,
                top: Dimens.gap_dp6 + Adapt.px(44),
                bottom: Dimens.gap_dp20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Obx(() {
                  if (widget.controller.detail.value == null) {
                    return Container(
                      color: Colors.transparent,
                      height: 110 + Dimens.gap_dp8,
                      child: const Skeleton(
                          child: PlaylistDetailTopPlaceholder(
                        coverSize: Size(110, 110),
                      )),
                    );
                  } else {
                    return Container(
                      color: Colors.transparent,
                      height: Dimens.gap_dp8 + 110,
                      child: BlogDetailMessagePage(
                        controller: widget.controller,
                        model: widget.controller.detail.value,
                      ),
                    );
                  }
                }),
                Obx(() {
                  if (widget.controller.detail.value != null) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Text(
                              widget.controller.detail.value?.desc ?? "",
                              style: const TextStyle(
                                  color: Color(0xFFDDDDDD), fontSize: 13),
                              maxLines: 3,
                              softWrap: true,
                              textAlign: TextAlign.left,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(bottom: 3),
                            child: Icon(
                              Icons.arrow_forward_ios,
                              color: Color(0xFFDDDDDD),
                              size: 13,
                            ),
                          )
                        ],
                      ),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                }),
                Obx(() => _buildBottomCount()),
              ],
            ))
      ],
    );
  }

  //评论，分享，收藏
  Widget _buildBottomCount() {
    final shareCount = widget.controller.detail.value?.shareCount ?? 0;
    final commentCount = widget.controller.detail.value?.commentCount ?? 0;
    final collectCount = widget.controller.detail.value?.subCount ?? 0;
    final itemW = (Adapt.screenW() - 16 * 4) / (7 / 3.0);
    return Padding(
      padding: EdgeInsets.only(
        top: Dimens.gap_dp20,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 42,
            width: itemW * (2 / 3),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(21.0))),
            // padding:
            //     const EdgeInsets.only(top: 8, bottom: 8, left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/cm8_menu_comment_share.png",
                  width: 30,
                ),
                Text(
                  shareCount == 0 ? "分享" : getPlayCountStrFromInt(shareCount),
                  style:
                      const TextStyle(fontSize: 15, color: Color(0xFF333333)),
                )
              ],
            ),
          ),
          Container(
            height: 42,
            width: itemW * (2 / 3),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(21.0))),
            // padding:
            //     const EdgeInsets.only(top: 8, bottom: 8, left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/cm8_mlog_playlist_comment.png",
                  width: 30,
                ),
                Text(
                  commentCount == 0
                      ? "评论"
                      : getPlayCountStrFromInt(commentCount),
                  style:
                      const TextStyle(fontSize: 15, color: Color(0xFF333333)),
                )
              ],
            ),
          ),
          Container(
            height: 42,
            width: itemW,
            decoration: const BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.all(Radius.circular(22.0))),
            // padding:
            //     const EdgeInsets.only(top: 8, bottom: 8, left: 18, right: 18),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/cm8_mlog_playlist_collection_normal.png",
                  width: 30,
                  color: Colors.white,
                ),
                Text(
                  "收藏(${getPlayCountStrFromInt(collectCount)})",
                  style:
                      const TextStyle(fontSize: 15, color: Color(0xFFFFFFFF)),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BlogDetailMessagePage extends StatelessWidget {
  const BlogDetailMessagePage(
      {super.key, this.model, required this.controller});

  final BlogDetailModel? model;

  final BlogDetailController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        GenerralCoverPlaycount(
          imageUrl: model?.picUrl ?? "",
          playCount: model?.playCount ?? 0,
          coverSize: const Size(110, 110),
          imageCallback: (provider) async {
            await Future.delayed(const Duration(milliseconds: 10));
            controller.coverImage.value = provider;
          },
        ),
        Expanded(
            child: Padding(
          padding: EdgeInsets.only(
              left: Dimens.gap_dp15,
              top: Dimens.gap_dp4,
              bottom: Dimens.gap_dp4),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model?.name ?? "",
                softWrap: true,
                textAlign: TextAlign.left,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: TextStyle(
                    fontSize: 16,
                    color: Get.isDarkMode
                        ? AppThemes.white.withOpacity(0.9)
                        : AppThemes.white,
                    fontWeight: FontWeight.w600),
              ),

              //creator
              Container(
                alignment: Alignment.topLeft,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                        onTap: () {},
                        child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(children: [
                              WidgetSpan(
                                alignment: PlaceholderAlignment.middle,
                                child: UserAvatarPage(
                                  avatar: ImageUtils.getImageUrlFromSize(
                                      controller.detail.value!.dj?.avatarUrl,
                                      Size(Dimens.gap_dp25, Dimens.gap_dp25)),
                                  size: Dimens.gap_dp25,
                                  identityIconUrl: null,
                                ),
                              ),
                              WidgetSpan(
                                  child: SizedBox(width: Dimens.gap_dp2)),
                              TextSpan(
                                  text: controller.detail.value!.dj?.nickname,
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: AppThemes.white.withOpacity(0.7))),
                            ]))),
                    SizedBox(width: Dimens.gap_dp2),
                    //focuse creator
                    if (controller.detail.value?.dj?.followed != null)
                      PlaylistDetailFollow(
                        followed: controller.detail.value!.dj!.followed!,
                      )
                  ],
                ),
              ),

              if (controller.indicatorList.isNotEmpty)
                _buildIndicator(context, controller.indicatorList)
            ],
          ),
        ))
      ],
    );
  }

  Widget _buildIndicator(
      BuildContext context, List<DetailIndicatorModel?> models) {
    return SizedBox(
      height: 24,
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        children: models.map((e) => _buildIndicatorItem(e!, context)).toList(),
      ),
    );
  }

  Widget _buildIndicatorItem(DetailIndicatorModel model, BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: const BorderRadius.all(Radius.circular(3.0))),
      padding: const EdgeInsets.all(4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            model.title ?? "",
            style: Get.theme.textTheme.displaySmall
                ?.copyWith(fontSize: 12, color: Colors.white),
          ),
          const Icon(
            Icons.arrow_forward_ios,
            size: 10,
            color: Colors.white,
          )
        ],
      ),
    );
  }
}
