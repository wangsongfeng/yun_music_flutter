import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:yun_music/commons/values/constants.dart';
import 'package:yun_music/pages/blog_page/blog_home_controller.dart';
import 'package:yun_music/pages/blog_page/models/blog_home_model.dart';
import 'package:yun_music/pages/blog_page/models/blog_recom_model.dart';
import 'package:yun_music/pages/blog_page/widgets/blog_home_grid.dart';
import 'package:yun_music/utils/adapt.dart';

import '../../commons/res/dimens.dart';
import '../../commons/widgets/music_loading.dart';
import '../../commons/widgets/music_refresh.dart';
import '../../utils/common_utils.dart';
import 'widgets/blog_home_banner.dart';
import 'widgets/blog_home_personal.dart';
import 'widgets/blog_home_row.dart';

class BlogHomePage extends StatefulWidget {
  const BlogHomePage({super.key});

  @override
  State<BlogHomePage> createState() => _BlogHomePageState();
}

class _BlogHomePageState extends State<BlogHomePage> {
  final controller = GetInstance().putOrFind(() => BlogHomeController());
  final refreshController = RefreshController();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).cardColor,
      child: controller.obx(
          (state) {
            refreshController.refreshCompleted();
            return _buildListView(context, state);
          },
          onEmpty: const Text('empty'),
          onError: (err) {
            toast(err.toString());
            refreshController.refreshFailed();
            return const SizedBox.shrink();
          },
          onLoading: _buildLoading(true)),
    );
  }

  Widget _buildLoading(bool needShow) {
    if (needShow) {
      return Container(
        margin: EdgeInsets.only(top: Adapt.px(200)),
        child: MusicLoading(
          axis: Axis.horizontal,
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  //创建试图
  Widget _buildListView(BuildContext context, BlogHomeModel? state) {
    return SmartRefresher(
        controller: refreshController,
        // enablePullUp: true,
        enablePullDown: true,
        header: MusicRefresh(),
        onRefresh: () {
          controller.loadRefresh();
        },
        footer: CustomFooter(
            height: Dimens.gap_dp50 + Adapt.bottomPadding(),
            builder: (context, mode) {
              return Container();
            }),
        child: CustomScrollView(
          slivers: [
            if (state?.banner != null)
              SliverToBoxAdapter(
                child: BlogHomeBanner(
                  banners: state!.banner!,
                ),
              ),
            if (state?.personal != null)
              SliverToBoxAdapter(
                child: BlogHomePersonal(personal: state!.personal!),
              ),
            SliverList.separated(
              itemBuilder: (context, index) {
                final model = state!.data!.elementAt(index);
                return _buildContentItem(model);
              },
              separatorBuilder: (context, index) {
                return const SizedBox(height: 2);
              },
              itemCount: state != null ? state.data!.length : 0,
            ),
          ],
        ));
  }

  Widget _buildContentItem(BlogRecomModel model) {
    if (BlogUtils.gridItems.contains(model.categoryId)) {
      return BlogHomeGrid(recomModel: model);
    } else if (BlogUtils.otherItems.contains(model.categoryId)) {
      return BlogHomeRow(recomModel: model);
    }
    return const SizedBox.shrink();
  }
}
