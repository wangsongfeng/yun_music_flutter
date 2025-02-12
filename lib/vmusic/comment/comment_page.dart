import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:yun_music/commons/res/app_themes.dart';
import 'package:yun_music/commons/res/dimens.dart';
import 'package:yun_music/commons/values/server.dart';
import 'package:yun_music/delegate/expaned_sliver_delegate.dart';
import 'package:yun_music/vmusic/comment/comment_controller.dart';

import '../../commons/widgets/footer_loading.dart';
import '../../commons/widgets/music_loading.dart';
import '../../utils/adapt.dart';
import 'widgets/comment_appbar.dart';
import 'widgets/comment_list_item.dart';
import 'widgets/comment_title_page.dart';

class CommentPage extends StatefulWidget {
  const CommentPage({super.key});

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  final controller = GetInstance().putOrFind(() => MCommentController());

  @override
  void dispose() {
    super.dispose();
    controller.refreshController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CommentAppbar(controller: controller),
        resizeToAvoidBottomInset: false,
        body: Obx(() {
          return SmartRefresher(
              controller: controller.refreshController,
              footer: const FooterLoading(
                noMoreText: "暂无更多数据",
              ),
              onLoading: controller.onLoading,
              onRefresh: () async {
                logger.d("onRefresh");
              },
              enablePullUp: true,
              enablePullDown: false,
              child: CustomScrollView(
                slivers: [
                  //header
                  SliverToBoxAdapter(
                    child: CommentTitlePage(controller: controller),
                  ),
                  SliverToBoxAdapter(
                      child: Container(
                    color: AppThemes.bg_color,
                    height: Dimens.gap_dp8,
                  )),

                  if (controller.isLoading.value == true)
                    SliverToBoxAdapter(
                      child: Container(
                        margin: EdgeInsets.only(top: Adapt.px(100)),
                        child: MusicLoading(
                          axis: Axis.horizontal,
                        ),
                      ),
                    )
                  else
                    SliverPersistentHeader(
                        pinned: true,
                        delegate: MySliverDelegate(
                            maxHeight: Dimens.gap_dp36,
                            minHeight: Dimens.gap_dp36,
                            child: CommentHeaderPage(controller: controller))),

                  if (controller.typeLoading.value == true)
                    SliverToBoxAdapter(
                      child: Container(
                        margin: EdgeInsets.only(top: Adapt.px(100)),
                        child: MusicLoading(
                          axis: Axis.horizontal,
                        ),
                      ),
                    )
                  else if (controller.commentWarp.value != null ||
                      controller.loadMore.value == true)
                    SliverList.builder(
                      itemBuilder: (context, index) {
                        final item =
                            controller.commentWarp.value!.comments?[index];
                        return CommentListItem(
                          controller: controller,
                          item: item!,
                        );
                      },
                      itemCount: controller.commentWarp.value?.comments?.length,
                    )
                ],
              ));
        }),
      ),
    );
  }
}

class CommentHeaderPage extends StatelessWidget {
  const CommentHeaderPage({super.key, this.controller});
  final MCommentController? controller;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: Dimens.gap_dp36,
      padding: EdgeInsets.only(left: Dimens.gap_dp16, right: Dimens.gap_dp16),
      child: Obx(() {
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '评论',
              style: GoogleFonts.roboto(
                  textStyle: TextStyle(
                      fontSize: Dimens.font_sp13, fontWeight: FontWeight.w600)),
            ),
            Obx(() => Text(
                  "(${controller!.commentWarp.value!.totalCount.toString()})",
                  style: GoogleFonts.roboto(
                      textStyle: TextStyle(
                          fontSize: Dimens.font_sp13,
                          fontWeight: FontWeight.w600)),
                )),
            const Spacer(),
            GestureDetector(
              onTap: () {
                controller?.clickType(1);
              },
              child: Padding(
                  padding: EdgeInsets.only(right: Dimens.gap_dp8),
                  child: Text(
                    '推荐',
                    style: controller?.sortType.value == 1
                        ? GoogleFonts.roboto(
                            textStyle: TextStyle(
                                fontSize: Dimens.font_sp13,
                                fontWeight: FontWeight.w600))
                        : TextStyle(
                            fontSize: Dimens.font_sp13,
                            color: Colors.grey,
                            fontWeight: FontWeight.normal),
                  )),
            ),
            Container(
              color: AppThemes.bg_color,
              width: 1.0,
              height: Dimens.gap_dp10,
            ),
            GestureDetector(
              onTap: () {
                controller?.clickType(2);
              },
              child: Padding(
                  padding: EdgeInsets.only(
                      right: Dimens.gap_dp8, left: Dimens.gap_dp8),
                  child: Text(
                    '最热',
                    style: controller?.sortType.value == 2
                        ? GoogleFonts.roboto(
                            textStyle: TextStyle(
                                fontSize: Dimens.font_sp13,
                                fontWeight: FontWeight.w600))
                        : TextStyle(
                            fontSize: Dimens.font_sp13,
                            color: Colors.grey,
                            fontWeight: FontWeight.normal),
                  )),
            ),
            Container(
              color: AppThemes.bg_color,
              width: 1.0,
              height: Dimens.gap_dp10,
            ),
            GestureDetector(
              onTap: () {
                controller?.clickType(3);
              },
              child: Padding(
                  padding: EdgeInsets.only(left: Dimens.gap_dp8),
                  child: Text(
                    '最新',
                    style: controller?.sortType.value == 3
                        ? GoogleFonts.roboto(
                            textStyle: TextStyle(
                                fontSize: Dimens.font_sp13,
                                fontWeight: FontWeight.w600))
                        : TextStyle(
                            fontSize: Dimens.font_sp13,
                            color: Colors.grey,
                            fontWeight: FontWeight.normal),
                  )),
            ),
          ],
        );
      }),
    );
  }
}
