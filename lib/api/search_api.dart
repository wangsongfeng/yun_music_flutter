import 'dart:convert';

import 'package:yun_music/commons/net/init_dio.dart';
import 'package:yun_music/commons/values/server.dart';
import 'package:yun_music/pages/recommend/models/default_search_model.dart';
import 'package:yun_music/pages/search/models/search_hot_wrap.dart';
import 'package:yun_music/pages/search/models/search_result_wrap.dart';

import '../commons/values/json.dart';
import '../pages/search/models/search_recommend.dart';
import 'bujuan_api.dart';
import 'common_service.dart';

Uri _searchUrl(bool cloudSearch) => cloudSearch
    ? joinUri('/weapi/cloudsearch/pc')
    : joinUri('/weapi/search/get');

class SearchApi {
  //获取默推荐搜索
  static Future<DefaultSearchModel?> getDefaultSearch() async {
    final metaData = DioMetaData(
        Uri.parse(
            'http://interface3.music.163.com/eapi/search/defaultkeyword/get'),
        data: {},
        options: joinOptions(
            encryptType: EncryptType.EApi,
            eApiUrl: '/api/search/defaultkeyword/get'));
    final response = await httpManager.postUri(metaData);
    return DefaultSearchModel.fromJson(response.data["data"]);
  }

  /// [type] 1018:综合
  static Future<SearchResultWrapX> searchComplex(String keyword,
      {bool cloudSearch = false, int offset = 0, int limit = 100}) async {
    var params = {'s': keyword, 'type': 1018, 'limit': limit, 'offset': offset};
    final metaData = DioMetaData(_searchUrl(cloudSearch),
        data: params, options: joinOptions());
    final response = await httpManager.postUri(metaData);
    logger.d(1);
    return SearchResultWrapX.fromJson(jsonDecode(response.data));
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
