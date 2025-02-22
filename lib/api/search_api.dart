import 'dart:convert';

import 'package:yun_music/commons/net/init_dio.dart';
import 'package:yun_music/pages/recommend/models/default_search_model.dart';
import 'package:yun_music/pages/search/models/search_hot_wrap.dart';

import '../commons/values/json.dart';
import '../pages/search/models/search_recommend.dart';
import 'bujuan_api.dart';
import 'common_service.dart';

class SearchApi {
  //获取默推荐搜索
  static Future<DefaultSearchModel?> getDefaultSearch() async {
    DefaultSearchModel? data;
    final response = await httpManager.get('/search/default',
        {'timestamp': DateTime.now().millisecondsSinceEpoch});
    if (response.result) {
      data = DefaultSearchModel.fromJson(response.data['data']);
    }
    return data;
  }

  static Future<SearchRecommendResult> searchDefault() async {
    final metaData = DioMetaData(joinUri('/weapi/search/hot'),
        data: {'type': 1111},
        options: joinOptions(userAgent: UserAgent.Mobile));
    final response = await httpManager.postUri(metaData);
    return SearchRecommendResult.fromJson(jsonDecode(response.data)['result']);
  }

  //热搜榜
  static Future<SearchHotWrap?> requestSearchHotData() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return CommonService.jsonDecode(JsonStringConstants.search_hot_list)
        .then((value) {
      return SearchHotWrap.fromJson(value);
    });
  }

  //话题榜
  static Future<SearchHotTopicWrap?> requestSearchTopicData() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return CommonService.jsonDecode(JsonStringConstants.search_topic_list)
        .then((value) {
      return SearchHotTopicWrap.fromJson(value);
    });
  }
}
