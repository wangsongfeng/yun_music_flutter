import 'package:yun_music/commons/net/init_dio.dart';
import 'package:yun_music/pages/recommend/models/default_search_model.dart';

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
}
