import 'package:get/get.dart';
import 'package:yun_music/api/music_api.dart';
import 'package:yun_music/commons/values/constants.dart';
import 'package:yun_music/pages/rank_list/models/ranklist_detail_section.dart';
import 'package:yun_music/pages/rank_list/models/ranklist_item.dart';

import '../../commons/event/index.dart';
import '../../commons/event/play_bar_event.dart';

class RanklistContrller extends GetxController {
  final items = Rx<List<RanklistItem>?>(null);

  final rankSections = Rx<List<RanklistDetailSection>?>([]);

  @override
  void onReady() {
    super.onReady();
    eventBus.fire(PlayBarEvent(PlayBarShowHiddenType.bootom));

    _request();
  }

  void _request() {
    MusicApi.getRankList().then((value) {
      items.value = value;
      final first = value.where((element) => element.tracks.isEmpty).toList();
      getOtherRankListDetail(first);
    });
  }

  void getOtherRankListDetail(List<RanklistItem> ranks) {
    List<RanklistDetailSection> sections = [];
    //精选榜单
    RanklistDetailSection chosenSection = RanklistDetailSection();
    chosenSection.title = RanklistDetailUtils.chosen;

    //曲风榜单
    RanklistDetailSection melodySection = RanklistDetailSection();
    melodySection.title = RanklistDetailUtils.melody;

    //全球榜
    RanklistDetailSection worldSection = RanklistDetailSection();
    worldSection.title = RanklistDetailUtils.world;

    //语种榜
    RanklistDetailSection languageSection = RanklistDetailSection();
    languageSection.title = RanklistDetailUtils.language;

    //特色榜单
    RanklistDetailSection featureSection = RanklistDetailSection();
    featureSection.title = RanklistDetailUtils.feature;

    //ACG榜单
    RanklistDetailSection acgSection = RanklistDetailSection();
    acgSection.title = RanklistDetailUtils.acg;

    for (RanklistItem item in ranks) {
      ///精选榜单
      if (RanklistDetailUtils.chosen_list.contains(item.name)) {
        chosenSection.items?.add(item);
      }

      ///曲风榜单
      if (RanklistDetailUtils.melody_list.contains(item.name)) {
        melodySection.items?.add(item);
      }

      ///全球榜
      if (RanklistDetailUtils.world_list.contains(item.name)) {
        worldSection.items?.add(item);
      }

      ///语种榜
      if (RanklistDetailUtils.language_list.contains(item.name)) {
        languageSection.items?.add(item);
      }

      ///ACG榜单
      if (RanklistDetailUtils.acg_list.contains(item.name)) {
        acgSection.items?.add(item);
      }

      ///特色榜单
      if (RanklistDetailUtils.feature_list.contains(item.name)) {
        featureSection.items?.add(item);
      }
    }

    ///精选榜单
    if (chosenSection.items!.isNotEmpty) {
      sections.add(chosenSection);
    }

    ///曲风榜单
    if (melodySection.items!.isNotEmpty) {
      sections.add(melodySection);
    }

    ///全球榜
    if (worldSection.items!.isNotEmpty) {
      sections.add(worldSection);
    }

    ///语种榜
    if (languageSection.items!.isNotEmpty) {
      sections.add(languageSection);
    }

    ///ACG榜单
    if (acgSection.items!.isNotEmpty) {
      sections.add(acgSection);
    }

    ///特色榜单
    if (featureSection.items!.isNotEmpty) {
      sections.add(featureSection);
    }

    rankSections.value = sections;
  }

  //推荐榜单
  List<RanklistItem> rcmdItem() {
    if (items.value == null) return [];
    //非官方榜单的更新时间列表
    final filter =
        items.value!.where((element) => element.tracks.isEmpty).toList();
    //从小到大
    filter.sort((a, b) => a.playCount.compareTo(b.playCount));
    final newFilter = filter.sublist(filter.length - 10, filter.length);
    newFilter.sort((a, b) => a.updateTime.compareTo(b.updateTime));
    //最近更新的三个
    return newFilter.sublist(newFilter.length - 3, newFilter.length);
  }
}
