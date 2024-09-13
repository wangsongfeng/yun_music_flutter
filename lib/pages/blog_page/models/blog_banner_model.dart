import 'package:json_annotation/json_annotation.dart';

part 'blog_banner_model.g.dart';

@JsonSerializable()
class BlogBannerModel extends Object {
  @JsonKey(name: 'targetId')
  int? targetId;
  @JsonKey(name: 'targetType')
  int? targetType;
  @JsonKey(name: 'pic')
  String? pic;
  @JsonKey(name: 'url')
  String? url;
  @JsonKey(name: 'typeTitle')
  String? typeTitle;
  @JsonKey(name: 'exclusive')
  bool? exclusive;

  BlogBannerModel({
    this.targetId,
    this.targetType,
    this.pic,
    this.url,
    this.typeTitle,
    this.exclusive,
  });

  factory BlogBannerModel.fromJson(Map<String, dynamic> srcJson) =>
      _$BlogBannerModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$BlogBannerModelToJson(this);
}
