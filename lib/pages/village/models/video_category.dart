import 'package:json_annotation/json_annotation.dart';

part 'video_category.g.dart';

@JsonSerializable()
class VideoCategory extends Object {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'relatedVideoType')
  String? relatedVideoType;
  @JsonKey(name: 'selectTab')
  bool? selectTab;

  VideoCategory({
    this.id,
    this.name,
    this.relatedVideoType,
    this.selectTab,
  });

  factory VideoCategory.fromJson(Map<String, dynamic> srcJson) =>
      _$VideoCategoryFromJson(srcJson);

  Map<String, dynamic> toJson() => _$VideoCategoryToJson(this);
}
