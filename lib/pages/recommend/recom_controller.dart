import 'dart:async';

import 'package:get/get.dart';
import 'package:yun_music/api/music_api.dart';
import 'package:yun_music/api/search_api.dart';
import 'package:yun_music/commons/event/index.dart';
import 'package:yun_music/commons/event/login_event.dart';
import 'package:yun_music/commons/res/dimens.dart';
import 'package:yun_music/commons/values/constants.dart';
import 'package:yun_music/pages/recommend/models/default_search_model.dart';
import 'package:yun_music/pages/recommend/models/recom_model.dart';
import 'package:yun_music/utils/adapt.dart';
import 'package:yun_music/utils/common_utils.dart';

class RecomController extends SuperController<RecomModel?> {
  final Map<String, double> itemHeightFromType = {
    SHOWTYPE_BANNER: Dimens.gap_dp140,
    SHOWTYPE_BALL: Dimens.gap_dp95,
    SHOWTYPE_HOMEPAGE_SLIDE_PLAYLIST: Dimens.gap_dp213,
    SHOWTYPE_HOMEPAGE_NEW_SONG_NEW_ALBUM: Adapt.px(238),
    HOMEPAGE_SLIDE_PODCAST_VOICE_MORE_TAB: Adapt.px(246),
    SHOWTYPE_SLIDE_SINGLE_SONG: Adapt.px(88),
    SHOWTYPE_SHUFFLE_MUSIC_CALENDAR: Adapt.px(192),
    SHOWTYPE_HOMEPAGE_SLIDE_SONGLIST_ALIGN: Adapt.px(245),
    SHOWTYPE_SHUFFLE_MLOG: Adapt.px(245),
    HOMEPAGE_SLIDE_PLAYABLE_MLOG: Adapt.px(245),
    SHOWTYPE_SLIDE_VOICELIST: Adapt.px(220),
    SHOWTYPE_SLIDE_PLAYABLE_DRAGON_BALL: Adapt.px(200),
    SLIDE_PLAYABLE_DRAGON_BALL_MORE_TAB: Adapt.px(200),
    SLIDE_RCMDLIKE_VOICELIST: Adapt.px(220),
    HOMEPAGE_BLOCK_HOT_TOPIC: 178,
    HOMEPAGE_YUNCUN_PRODUCED: Adapt.px(216),
    SLIDE_PLAYABLE_DRAGON_BALL_NEW_BROADCAST: Adapt.px(204),
  };

  final defuleSearch = Rx<DefaultSearchModel?>(null);

  //刷新过期时间
  int expirationTime = -1;
  //是否滚动
  final isScrolled = Rx<bool>(false);

  //是否成功加载完数据
  final isSucLoad = false.obs;

  //recommend data
  late final recomData = Rx<RecomModel?>(null);

  late StreamSubscription stream;

  Future<void> getFoundRecList({bool refresh = false}) async {
    final cacheData = box.read<Map<String, dynamic>>(CACHE_HOME_RECOMMEND_DATA);
    MusicApi.getRecomRec(refresh: refresh, cacheData: cacheData).then(
        (newValue) {
      if (newValue != null) {
        recomData.value = newValue;
        change(newValue, status: RxStatus.success());
        isSucLoad.value = true;
      } else {
        if (recomData.value == null) {
          change(state, status: RxStatus.error());
        } else {
          change(recomData.value, status: RxStatus.success());
        }
      }
    }, onError: (err) {
      if (recomData.value == null) {
        change(state, status: RxStatus.error(err.toString()));
      } else {
        change(recomData.value, status: RxStatus.success());
      }
    });
  }

  Future<void> getDefaultSearch() async {
    final data = await SearchApi.getDefaultSearch();
    defuleSearch.value = data;
  }

  @override
  void onReady() {
    super.onReady();
    _requestData();
    stream = eventBus.on<LoginEvent>().listen((event) {
      _requestData();
    });
  }

  @override
  void onClose() {
    stream.cancel();
    super.onClose();
  }

  void _requestData() {
    getFoundRecList();
    getDefaultSearch();
  }

  @override
  void onDetached() {}

  @override
  void onHidden() {}

  @override
  void onInactive() {}

  @override
  void onPaused() {}

  @override
  void onResumed() {}
}
