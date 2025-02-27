// ignore_for_file: constant_identifier_names, non_constant_identifier_names

import 'package:yun_music/commons/values/constants.dart';

class RouterPath {
  static const ROUTES_HOST = '$APP_ROUTER_TAG://';

  //每日推荐
  static const DaySongRecom = "/songrcmd";

  //歌单广场
  static const PlayListCollection = "/playlistCollection";

  //歌单详情
  static const PlayListDetail = "/playlist/:id";
  static PlayListDetailId(String id) => "/playlist/$id";

  //播放页面
  static const PlayingPage = "/playing";

  //排行榜页面
  static const RankListPage = "/rnpage";

  //新歌 新专辑
  static const NEW_SONG_ALBUM = '/nm/discovery/newsongalbum';

  //播客详情
  static const Blog_Detail_Page = "/blogdetail";

  //朋友圈页面
  static const Moments_Page = "/moment";

  //图片查看
  static const PreView_Page = '/preview';

  //视频列表
  static const Video_Lists = '/videolist';

  //评论
  static const Comment_Page = "/comment";

  //搜索
  static const Search_Page = "/search";

  //搜索结果
  static const Search_Result = '/searchresult';

  //歌手分类
  static const Single_Category = '/singlecategory';

  //歌手详情
  static const Artist_Detail = '/artistdetail';
}
