import 'package:json_annotation/json_annotation.dart';
part 'search_recommend.g.dart';

@JsonSerializable()
class SearchRecommendResult extends Object {
  @JsonKey(name: 'hots')
  List<SearchRecommendHotItem>? hots;

  SearchRecommendResult(this.hots);

  factory SearchRecommendResult.fromJson(Map<String, dynamic> srcJson) =>
      _$SearchRecommendResultFromJson(srcJson);

  Map<String, dynamic> toJson() => _$SearchRecommendResultToJson(this);
}

@JsonSerializable()
class SearchRecommendHotItem extends Object {
  @JsonKey(name: 'first')
  String? first;
  @JsonKey(name: 'second')
  int? second;
  @JsonKey(name: 'iconType')
  int? iconType;

  SearchRecommendHotItem(
    this.first,
    this.second,
    this.iconType,
  );
  factory SearchRecommendHotItem.fromJson(Map<String, dynamic> srcJson) =>
      _$SearchRecommendHotItemFromJson(srcJson);

  Map<String, dynamic> toJson() => _$SearchRecommendHotItemToJson(this);
}
