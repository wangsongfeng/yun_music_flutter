import 'package:json_annotation/json_annotation.dart';
part 'search_hot_wrap.g.dart';

@JsonSerializable()
class SearchHotWrap extends Object {
  @JsonKey(name: 'data')
  List<SearchHotDataItem>? data;
  @JsonKey(name: 'code')
  int? code;

  SearchHotWrap(this.data, this.code);

  factory SearchHotWrap.fromJson(Map<String, dynamic> srcJson) =>
      _$SearchHotWrapFromJson(srcJson);

  Map<String, dynamic> toJson() => _$SearchHotWrapToJson(this);
}

@JsonSerializable()
class SearchHotDataItem extends Object {
  @JsonKey(name: 'searchWord')
  String? searchWord;
  @JsonKey(name: 'content')
  String? content;
  @JsonKey(name: 'score')
  int? score;
  @JsonKey(name: 'iconUrl')
  String? iconUrl;
  @JsonKey(name: 'source')
  int? source;
  @JsonKey(name: 'iconType')
  int? iconType;
  @JsonKey(name: 'url')
  String? url;
  @JsonKey(name: 'alg')
  String? alg;

  SearchHotDataItem(
    this.searchWord,
    this.content,
    this.score,
    this.iconUrl,
    this.source,
    this.iconType,
    this.url,
    this.alg,
  );

  factory SearchHotDataItem.fromJson(Map<String, dynamic> srcJson) =>
      _$SearchHotDataItemFromJson(srcJson);

  Map<String, dynamic> toJson() => _$SearchHotDataItemToJson(this);
}

@JsonSerializable()
class SearchHotTopicWrap extends Object {
  int? code;
  List<SearchHotTopicItem>? hot;
  SearchHotTopicWrap(
    this.code,
    this.hot,
  );
  factory SearchHotTopicWrap.fromJson(Map<String, dynamic> srcJson) =>
      _$SearchHotTopicWrapFromJson(srcJson);

  Map<String, dynamic> toJson() => _$SearchHotTopicWrapToJson(this);
}

@JsonSerializable()
class SearchHotTopicItem {
  String? title;
  List<String>? text;
  int? actId;
  int? participateCount;
  String? sharePicUrl;
  SearchHotTopicItem(
    this.title,
    this.text,
    this.actId,
    this.participateCount,
    this.sharePicUrl,
  );

  factory SearchHotTopicItem.fromJson(Map<String, dynamic> srcJson) =>
      _$SearchHotTopicItemFromJson(srcJson);

  Map<String, dynamic> toJson() => _$SearchHotTopicItemToJson(this);
}
