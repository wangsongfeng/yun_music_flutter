import 'package:json_annotation/json_annotation.dart';
import 'package:yun_music/commons/models/user_info_model.dart';
import 'package:yun_music/pages/dynamic_page/models/bu_new_song.dart';
part 'artist_detail_wrap.g.dart';

@JsonSerializable()
class ArtistDetailData extends Object {
  int? videoCount;

  ArtistDetailIdentify? identify;

  Artists? artist;

  bool? blacklist;

  int? preferShow;

  bool? showPriMsg;

  UserInfo? user;

  List<ArtistDetailSecondIdentiy>? secondaryExpertIdentiy;

  ArtistDetailData();

  factory ArtistDetailData.fromJson(Map<String, dynamic> srcJson) =>
      _$ArtistDetailDataFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ArtistDetailDataToJson(this);
}

@JsonSerializable()
class ArtistDetailIdentify extends Object {
  String? imageUrl;
  String? imageDesc;
  String? actionUrl;
  ArtistDetailIdentify();

  factory ArtistDetailIdentify.fromJson(Map<String, dynamic> srcJson) =>
      _$ArtistDetailIdentifyFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ArtistDetailIdentifyToJson(this);
}

@JsonSerializable()
class ArtistDetailSecondIdentiy extends Object {
  int? expertIdentiyId;
  String? expertIdentiyName;
  int? expertIdentiyCount;

  ArtistDetailSecondIdentiy();

  factory ArtistDetailSecondIdentiy.fromJson(Map<String, dynamic> srcJson) =>
      _$ArtistDetailSecondIdentiyFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ArtistDetailSecondIdentiyToJson(this);
}
