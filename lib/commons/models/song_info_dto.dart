import 'package:json_annotation/json_annotation.dart';
part 'song_info_dto.g.dart';

@JsonSerializable()
class SongInfoDto extends Object {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'url')
  String? url;
  @JsonKey(name: 'md5')
  String? md5;
  @JsonKey(name: 'time')
  int? time;
  @JsonKey(name: 'mp3')
  String? mp3;
  @JsonKey(name: 'level')
  String? level;
  SongInfoDto(
    this.id,
    this.url,
    this.md5,
    this.time,
    this.mp3,
    this.level,
  );

  factory SongInfoDto.fromJson(Map<String, dynamic> srcJson) =>
      _$SongInfoDtoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$SongInfoDtoToJson(this);
}

@JsonSerializable()
class SongInfoListDto extends Object {
  @JsonKey(name: 'data')
  List<SongInfoDto>? data;

  SongInfoListDto(
    this.data,
  );

  factory SongInfoListDto.fromJson(Map<String, dynamic> json) =>
      _$SongInfoListDtoFromJson(json);

  Map<String, dynamic> toJson() => _$SongInfoListDtoToJson(this);
}
