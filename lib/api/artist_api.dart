import 'dart:convert';

import 'package:yun_music/pages/single_category/models/single_list_wrap.dart';

import '../commons/net/init_dio.dart';
import 'bujuan_api.dart';

class ArtistApi {
  //获取歌手列表
  static Future<SingleListWrap> artistList(
      {int offset = 0,
      int limit = 30,
      bool total = true,
      int type = 1,
      int area = -1}) async {
    var params = {
      'type': type,
      'area': area,
      'total': total,
      'limit': limit,
      'offset': offset
    };
    final metaData = DioMetaData(joinUri('/api/v1/artist/list'),
        data: params, options: joinOptions());
    final response = await httpManager.postUri(metaData);
    return SingleListWrap.fromJson(jsonDecode(response.data));
  }
}
