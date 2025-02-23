import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:yun_music/api/artist_api.dart';
import 'package:yun_music/pages/single_category/models/single_list_wrap.dart';
import '../../commons/event/index.dart';
import '../../commons/event/play_bar_event.dart';

class SingleCategoryController extends GetxController {
  final RxDouble headerH = 78.0.obs;
  late List<Map<String, String>> typeList = [];
  late List<Map<String, String>> areaList = [];

  final RxMap<String, String> currentType = {"type": "-1", "name": ""}.obs;
  final RxMap<String, String> currentArea = {"area": "-1", "name": ""}.obs;

  final refreshController = RefreshController();

  late RxDouble headerAlpha = 1.0.obs;
  late RxDouble sortAlpha = 0.0.obs;

  int offset = 0;

  late RxList<Singles?> artistsList = <Singles?>[].obs;

  @override
  void onReady() {
    super.onReady();
    eventBus.fire(PlayBarEvent(PlayBarShowHiddenType.bootom));
    _eventTypeListData();
    headerH.value = 78.0;
    currentType.value = {"type": "-1", "name": ""};
    currentArea.value = {"area": "-1", "name": ""};
    headerAlpha.value = 1.0;
    sortAlpha.value = 0.0;
    refreshController.loadComplete();

    requestDataList();
  }

  void _eventTypeListData() {
    typeList = [
      {"type": "1", "name": "男"},
      {"type": "2", "name": "女"},
      {"type": "3", "name": "乐队/组合"}
    ];

    areaList = [
      {"area": "7", "name": "华语"},
      {"area": "96", "name": "欧美"},
      {"area": "8", "name": "日本"},
      {"area": "16", "name": "韩国"},
      {"area": "0", "name": "其他"}
    ];
  }

  Future<void> requestDataList() async {
    SingleListWrap wrap = await ArtistApi.artistList(
        area: int.parse(currentArea["area"]!),
        type: int.parse(currentType["type"]!),
        offset: offset);
    final artists = wrap.artists!;
    artistsList.addAll(artists);

    refreshController.loadComplete();
    if (artists.length < 30) {
      refreshController.loadNoData();
    }
  }

  Future<void> loadMore() async {
    offset += 1;
    requestDataList();
  }

  Future<void> setCurrentArea(Map<String, String> area) async {
    offset = 0;
    currentArea.value = area;
    if (currentType["type"] == "-1") {
      final type = typeList.first;
      currentType.value = type;
    }
    artistsList.value = [];
    requestDataList();
  }

  Future<void> setCurrenttype(Map<String, String> type) async {
    offset = 0;
    currentType.value = type;
    if (currentArea["area"] == "-1") {
      final area = areaList.first;
      currentArea.value = area;
    }
    artistsList.value = [];
    requestDataList();
  }

  @override
  void dispose() {
    super.dispose();
    refreshController.dispose();
  }
}
