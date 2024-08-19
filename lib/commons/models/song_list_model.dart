

import 'package:json_annotation/json_annotation.dart';
import 'package:yun_music/commons/models/privilege_model.dart';
import 'package:yun_music/commons/models/song_model.dart';

part 'song_list_model.g.dart';

@JsonSerializable()
class SongListModel extends Object {
  @JsonKey(name: 'songs')
  List<Song> songs;

  @JsonKey(name: 'privileges')
  List<PrivilegeModel> privileges;

  SongListModel(
    this.songs,
    this.privileges,
  );

  factory SongListModel.fromJson(Map<String, dynamic> srcJson) =>
      _$SongListModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$SongListModelToJson(this);
}