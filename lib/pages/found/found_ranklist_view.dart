import 'package:flutter/material.dart';
import 'package:yun_music/pages/rank_list/ranklist_contrller.dart';

import '../rank_list/windgets/rank_global_page.dart';
import '../rank_list/windgets/rank_official_page.dart';
import '../rank_list/windgets/rank_recom_page.dart';

class FoundRanklistView extends StatelessWidget {
  const FoundRanklistView({super.key, required this.controller});

  final RanklistContrller controller;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      // physics: const ClampingScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: Container(),
        ),
        SliverToBoxAdapter(
          child: RankRecomPage(contrller: controller),
        ),
        SliverToBoxAdapter(
          child: RankOfficialPage(
              contrller: controller,
              items: controller.items.value!
                  .where((element) => element.tracks.isNotEmpty)
                  .toList()),
        ),
        SliverToBoxAdapter(
          child: Column(
            children: ranksection(),
          ),
        )
      ],
    );
  }

  List<Widget> ranksection() {
    final list = <Widget>[];

    for (var i = 0; i < controller.rankSections.value!.length; i++) {
      final model = controller.rankSections.value!.elementAt(i);
      list.add(RankGlobalPage(
        contrller: controller,
        section: model,
        key: Key(model.title ?? ""),
      ));
    }

    return list;
  }
}
