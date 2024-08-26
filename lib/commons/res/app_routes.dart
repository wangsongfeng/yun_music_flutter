// ignore_for_file: constant_identifier_names

import 'package:yun_music/commons/values/constants.dart';

class RouterPath {
  static const ROUTES_HOST = '$APP_ROUTER_TAG://';

  //每日推荐
  static const DaySongRecom = "/songrcmd";

  //歌单广场
  static const PlayListCollection = "/playlistCollection";

  //歌单详情
  static const PlayListDetail = "/playlistdetail/:id";
  static PlayListDetailId(String id) => "/playlistdetail/$id";

  //播放页面
  static const PlayingPage = "/playing";

  //排行榜页面
  static const RankListPage = "/rnpage";
}
