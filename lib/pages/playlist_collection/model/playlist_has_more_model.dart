import 'package:yun_music/commons/models/simple_play_list_model.dart';

class PlaylistHasMoreModel {
  final int? totalCount;
  final List<SimplePlayListModel> datas;

  PlaylistHasMoreModel({this.totalCount, required this.datas});
}
