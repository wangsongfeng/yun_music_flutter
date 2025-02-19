// ignore_for_file: constant_identifier_names, slash_for_doc_comments

/* 首页推荐类型常量 --------- start ----------- */

///展示类型  每个类型对应一个weight组件
const SHOWTYPE_BALL = "BALL";
const SHOWTYPE_BANNER = "BANNER";
const SHOWTYPE_HOMEPAGE_SLIDE_PLAYLIST = "HOMEPAGE_SLIDE_PLAYLIST";
const SHOWTYPE_HOMEPAGE_NEW_SONG_NEW_ALBUM = "HOMEPAGE_NEW_SONG_NEW_ALBUM";
const SHOWTYPE_SLIDE_SINGLE_SONG = "SLIDE_SINGLE_SONG";
const SHOWTYPE_SHUFFLE_MUSIC_CALENDAR = "SHUFFLE_MUSIC_CALENDAR";
const SHOWTYPE_HOMEPAGE_SLIDE_SONGLIST_ALIGN = "HOMEPAGE_SLIDE_SONGLIST_ALIGN";
const SHOWTYPE_SHUFFLE_MLOG = "SHUFFLE_MLOG";
const SHOWTYPE_SLIDE_VOICELIST = "SLIDE_VOICELIST";
const HOMEPAGE_SLIDE_PLAYABLE_MLOG = 'HOMEPAGE_SLIDE_PLAYABLE_MLOG';
const SHOWTYPE_SLIDE_PLAYABLE_DRAGON_BALL = "SLIDE_PLAYABLE_DRAGON_BALL";
const SLIDE_PLAYABLE_DRAGON_BALL_MORE_TAB =
    "SLIDE_PLAYABLE_DRAGON_BALL_MORE_TAB";
const SLIDE_RCMDLIKE_VOICELIST = 'SLIDE_RCMDLIKE_VOICELIST'; //热门播客
const HOMEPAGE_BLOCK_HOT_TOPIC = 'HOT_TOPIC'; //热门话题
const HOMEPAGE_SLIDE_PODCAST_VOICE_MORE_TAB = 'SLIDE_PODCAST_VOICE_MORE_TAB';
const HOMEPAGE_YUNCUN_PRODUCED = 'YUNCUN_PRODUCED'; //云村出品
const SLIDE_PLAYABLE_DRAGON_BALL_NEW_BROADCAST =
    'SLIDE_PLAYABLE_DRAGON_BALL_NEW_BROADCAST'; //广播

/* 首页推荐类型常量 --------- end ----------- */

//官方歌单标识
const ALG_OP = 'ALG_OP';

//app内部跳转标识
const APP_ROUTER_TAG = 'orpheus';

const HERO_TAG_CUR_PLAY = 'currentPlay';

const SINGLE_SEARCH = 'single_search';

// ignore: dangling_library_doc_comments
/**cache key */

const CACHE_LOGIN_DATA = 'cache_login_data';
const CACHE_ALBUM_POLY_DETAIL_URL = 'cache_album_poly_detail_url'; //数字专辑Url
const CACHE_HOME_RECOMMEND_DATA = 'home_recommend_data';
const CACHE_SEARCH_HISTORY_DATA = 'cache_search_history';

//全局播放列表缓存
const kCommonPlayingList = 'kCommonPlayingList';
const kCurrentPlayingSong = 'kCurrentPlayingSong';

enum PlayListTitleStatus { Normal, Title, TitleAndBtn }

///排行榜
class RankListDetailType {
  ///榜单推荐，编辑推荐榜
  static const String top_compile = "编辑推荐榜VOL.11流行天后碧昂丝回归";

  ///榜单推荐，说唱榜
  static const String top_rap = "云音乐说唱榜";

  ///榜单推荐，民谣榜
  static const String top_ballad = "云音乐民谣榜";

  ///官方榜单，飙升榜
  static const String official_soar = "飙升榜";

  ///官方榜单，新歌榜
  static const String official_new = "新歌榜";

  ///官方榜单，热歌榜
  static const String official_hot = "热歌榜";

  ///官方榜单，原创榜
  static const String official_original = "原创榜";

  ///精选榜单，说唱巅峰榜
  static const String chosen_rap = "说唱巅峰榜";

  ///精选榜单，BEAT排行榜
  static const String chosen_beat = "BEAT排行榜";

  ///精选榜单，网络热歌榜
  static const String chosen_hot = "网络热歌榜";

  ///精选榜单，黑胶VIP爱听榜
  static const String chosen_vip = "黑胶VIP爱听榜";

  ///曲风榜单，云音乐古典榜
  static const String melody_classical = "云音乐古典榜";

  ///曲风榜单，云音乐电音榜
  static const String melody_electronic = "云音乐电音榜";

  ///曲风榜单，云音乐ACG榜
  static const String melody_acg = "云音乐ACG榜";

  ///曲风榜单，云音乐国电榜
  static const String melody_power = "云音乐国电榜";

  ///曲风榜单，云音乐摇滚榜
  static const String melody_rap = "云音乐摇滚榜";

  ///曲风榜单，云音乐古风榜
  static const String melody_antiquity = "云音乐古风榜";

  ///曲风榜单，中文DJ榜
  static const String melody_chinese_dj = "中文DJ榜";

  ///全球榜单，俄罗斯top hit流行音乐榜
  static const String world_russia = "俄罗斯top hit流行音乐榜";

  ///全球榜单，法国 NRJ Vos Hits 周榜
  static const String world_france = "法国 NRJ Vos Hits 周榜";

  ///全球榜单，日本Oricon榜
  static const String world_japan = "日本Oricon榜";

  ///全球榜单，Beatport全球电子舞曲榜
  static const String world_dj = "Beatport全球电子舞曲榜";

  ///全球榜单，美国Billboard榜
  static const String world_us = "美国Billboard榜";

  ///全球榜单，UK排行榜周榜
  static const String world_uk = "UK排行榜周榜";

  ///语种榜单，Korean榜
  static const String language_korean = "云音乐韩语榜";

  ///语种榜单，云音乐欧美热歌榜
  static const String language_us_hot = "云音乐欧美热歌榜";

  ///语种榜单，云音乐欧美新歌榜
  static const String language_us_new = "云音乐欧美新歌榜";

  ///语种榜单，云音乐日语榜
  static const String language_japan = "云音乐日语榜";

  ///语种榜单，俄语榜
  static const String language_russia = "俄语榜";

  ///语种榜单，越南语榜
  static const String language_vietnam = "越南语榜";

  ///语种榜单，泰语榜
  static const String language_thai = "泰语榜";

  ///国语榜
  static const String language_china = "云音乐国风榜";

  ///特色榜单，听歌识曲榜
  static const String feature_listen = "听歌识曲榜";

  ///特色榜单，潜力爆款榜
  static const String feature_hot = "潜力爆款榜";

  ///特色榜单，中国新乡村音乐排行榜
  static const String feature_rural = "中国新乡村音乐排行榜";

  ///特色榜单，KTV唛榜
  static const String feature_ktv = "KTV唛榜";

  ///ACG榜单，云音乐ACG VOCALOID榜
  static const String acg_vocaloid = "云音乐ACG VOCALOID榜";

  ///ACG榜单，云音乐ACG游戏榜
  static const String acg_game = "云音乐ACG游戏榜";

  ///ACG榜单，云音乐ACG动画榜
  static const String acg_animation = "云音乐ACG动画榜";
}

class RanklistDetailUtils {
  static const String top = "榜单推荐";

  static const String official = "官方榜";

  static const String chosen = "精选榜";

  static const String melody = "曲风榜";

  static const String world = "全球榜";

  static const String language = "语种榜";

//  static const String mv = "MV榜";

  static const String feature = "特色榜";

  static const String acg = "ACG榜";

  static const String vol = "星云榜VOL.22 A diamond shining in the rough";

  static const String look_live = "LOOK直播歌曲榜";

  ///榜单推荐
  static List<String> top_list = [
    RankListDetailType.top_compile,
    RankListDetailType.top_rap,
    RankListDetailType.top_ballad
  ];

  ///官方榜单
  static List<String> official_list = [
    RankListDetailType.official_soar,
    RankListDetailType.official_new,
    RankListDetailType.official_hot,
    RankListDetailType.official_original
  ];

  ///精选榜单
  static List<String> chosen_list = [
    RankListDetailType.chosen_vip,
    RankListDetailType.chosen_rap,
    RankListDetailType.chosen_hot,
    RankListDetailType.chosen_beat
  ];

  ///曲风榜单
  static List<String> melody_list = [
    RankListDetailType.melody_electronic,
    RankListDetailType.melody_acg,
    RankListDetailType.melody_rap,
    RankListDetailType.melody_power,
    RankListDetailType.melody_classical,
    RankListDetailType.melody_antiquity,
    RankListDetailType.melody_chinese_dj,
  ];

  ///全球榜
  static List<String> world_list = [
    RankListDetailType.world_us,
    RankListDetailType.world_uk,
    RankListDetailType.world_japan,
    RankListDetailType.world_france,
    RankListDetailType.world_dj,
    RankListDetailType.world_russia
  ];

  ///语种榜
  static List<String> language_list = [
    RankListDetailType.language_us_hot,
    RankListDetailType.language_us_new,
    RankListDetailType.language_japan,
    RankListDetailType.language_korean,
    RankListDetailType.language_russia,
    RankListDetailType.language_thai,
    RankListDetailType.language_vietnam,
  ];

  ///特色榜单
  static List<String> feature_list = [
    RankListDetailType.feature_listen,
    RankListDetailType.feature_hot,
    RankListDetailType.feature_rural,
    RankListDetailType.feature_ktv
  ];

  ///ACG榜单
  static List<String> acg_list = [
    RankListDetailType.acg_vocaloid,
    RankListDetailType.acg_game,
    RankListDetailType.acg_animation,
  ];
}

class BlogUtils {
  ///banner
  static const int dj_banner = 990;

  ///每日优选
  static const int dj_perfered = 991;

  ///情感
  static const int dj_emotion_category = 3;

  ///音乐推荐
  static const int dj_music_category = 2;

  ///二次元
  static const int dj_dimensional_category = 3001;

  ///有声书
  static const int dj_book_category = 10001;

  ///脱口秀
  static const int dj_show_category = 8;

  ///侃侃而谈
  static const int dj_talk_category = 5;

  ///创作翻唱
  static const int dj_cover_category = 2001;

  ///电音
  static const int dj_electronic_category = 10002;

  ///生活
  static const int dj_life_category = 6;

  ///明星专区
  static const int dj_star_category = 14;

  ///亲子
  static const int dj_child_category = 13;

  ///知识
  static const int dj_knowledge_category = 11;

  static const List<int> otherItems = [
    BlogUtils.dj_cover_category,
    BlogUtils.dj_life_category,
    BlogUtils.dj_emotion_category,
  ];

  static const List<int> gridItems = [
    BlogUtils.dj_show_category,
    BlogUtils.dj_music_category,
    BlogUtils.dj_dimensional_category,
    BlogUtils.dj_electronic_category,
    BlogUtils.dj_child_category,
    BlogUtils.dj_knowledge_category,
    BlogUtils.dj_book_category,
    BlogUtils.dj_star_category,
    BlogUtils.dj_talk_category,
  ];
}
