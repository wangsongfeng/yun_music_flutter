import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:yun_music/commons/res/app_themes.dart';
import 'package:yun_music/commons/res/dimens.dart';
import 'package:yun_music/delegate/expaned_sliver_delegate.dart';
import 'package:yun_music/vmusic/comment/comment_controller.dart';

import '../../commons/widgets/music_loading.dart';
import '../../utils/adapt.dart';
import 'widgets/comment_appbar.dart';
import 'widgets/comment_title_page.dart';

class CommentPage extends StatefulWidget {
  const CommentPage({super.key});

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  final controller = GetInstance().putOrFind(() => MCommentController());

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CommentAppbar(controller: controller),
        resizeToAvoidBottomInset: false,
        body: CustomScrollView(
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

            Obx(() {
              if (controller.isLoading.value == true) {
                return SliverToBoxAdapter(
                  child: Container(
                    margin: EdgeInsets.only(top: Adapt.px(100)),
                    child: MusicLoading(
                      axis: Axis.horizontal,
                    ),
                  ),
                );
              } else {
                return SliverPersistentHeader(
                    pinned: true,
                    delegate: MySliverDelegate(
                        maxHeight: Dimens.gap_dp36,
                        minHeight: Dimens.gap_dp36,
                        child: CommentHeaderPage(controller: controller)));
              }
            })
          ],
        ),
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            '评论',
            style: TextStyle(fontSize: Dimens.font_sp13, color: Colors.black),
          ),
          Obx(() => Text(
                "(${controller!.commentWarp.value!.totalCount.toString()})",
                style:
                    TextStyle(fontSize: Dimens.font_sp13, color: Colors.black),
              )),
          const Spacer(),
          GestureDetector(
            onTap: () {},
            child: Padding(
                padding: EdgeInsets.only(right: Dimens.gap_dp8),
                child: Text(
                  '推荐',
                  style: TextStyle(
                      fontSize: Dimens.font_sp13,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                )),
          ),
          Container(
            color: AppThemes.bg_color,
            width: 1.0,
            height: Dimens.gap_dp10,
          ),
          GestureDetector(
            onTap: () {},
            child: Padding(
                padding: EdgeInsets.only(
                    right: Dimens.gap_dp8, left: Dimens.gap_dp8),
                child: Text(
                  '最热',
                  style: TextStyle(
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
            onTap: () {},
            child: Padding(
                padding: EdgeInsets.only(left: Dimens.gap_dp8),
                child: Text(
                  '最新',
                  style: TextStyle(
                      fontSize: Dimens.font_sp13,
                      color: Colors.grey,
                      fontWeight: FontWeight.normal),
                )),
          ),
        ],
      ),
    );
  }
}
