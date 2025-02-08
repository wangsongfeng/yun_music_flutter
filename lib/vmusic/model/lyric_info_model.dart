import 'package:json_annotation/json_annotation.dart';
part 'lyric_info_model.g.dart';

@JsonSerializable()
class Lyrics2 extends Object {
  @JsonKey(name: 'lyric')
  String? lyric;
  @JsonKey(name: 'version')
  int? version;

  Lyrics2(
    this.lyric,
    this.version,
  );

  factory Lyrics2.fromJson(Map<String, dynamic> srcJson) =>
      _$Lyrics2FromJson(srcJson);

  Map<String, dynamic> toJson() => _$Lyrics2ToJson(this);
}

@JsonSerializable()
class SongLyricWrap extends Object {
  @JsonKey(name: 'sgc')
  bool? sgc;
  @JsonKey(name: 'sfy')
  bool? sfy;
  @JsonKey(name: 'qfy')
  bool? qfy;
  @JsonKey(name: 'lrc')
  late Lyrics2 lrc;
  @JsonKey(name: 'klyric')
  late Lyrics2 klyric;
  @JsonKey(name: 'tlyric')
  late Lyrics2 tlyric;

  SongLyricWrap(
    this.sgc,
    this.sfy,
    this.qfy,
    this.lrc,
    this.klyric,
    this.tlyric,
  );

  factory SongLyricWrap.fromJson(Map<String, dynamic> srcJson) =>
      _$SongLyricWrapFromJson(srcJson);

  Map<String, dynamic> toJson() => _$SongLyricWrapToJson(this);
}
