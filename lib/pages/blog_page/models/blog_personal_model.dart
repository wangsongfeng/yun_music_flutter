import 'package:json_annotation/json_annotation.dart';

part 'blog_personal_model.g.dart';

@JsonSerializable()
class BlogPersonalModel extends Object {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'desc')
  String? desc;
  @JsonKey(name: 'picUrl')
  String? picUrl;
  @JsonKey(name: 'subCount')
  int? subCount;
  @JsonKey(name: 'programCount')
  int? programCount;
  @JsonKey(name: 'categoryId')
  int? categoryId;
  @JsonKey(name: 'category')
  String? category;
  @JsonKey(name: 'secondCategoryId')
  int? secondCategoryId;
  @JsonKey(name: 'secondCategory')
  String? secondCategory;
  @JsonKey(name: 'dj')
  PersonalizeDJ? dj;

  BlogPersonalModel({
    this.id,
    this.name,
    this.desc,
    this.picUrl,
    this.subCount,
    this.programCount,
    this.categoryId,
    this.category,
    this.secondCategoryId,
    this.secondCategory,
    this.dj,
  });

  factory BlogPersonalModel.fromJson(Map<String, dynamic> srcJson) =>
      _$BlogPersonalModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$BlogPersonalModelToJson(this);
}

@JsonSerializable()
class PersonalizeDJ extends Object {
  @JsonKey(name: 'userId')
  int? userId;
  @JsonKey(name: 'userType')
  int? userType;
  @JsonKey(name: 'avatarUrl')
  String? avatarUrl;
  @JsonKey(name: 'nickname')
  String? nickname;
  @JsonKey(name: 'backgroundUrl')
  String? backgroundUrl;
  @JsonKey(name: 'rewardCount')
  int? rewardCount;
  @JsonKey(name: 'followed')
  bool? followed;
  @JsonKey(name: 'gender')
  int? gender;

  PersonalizeDJ({
    this.userId,
    this.userType,
    this.avatarUrl,
    this.nickname,
    this.backgroundUrl,
    this.rewardCount,
    this.followed,
    this.gender,
  });

  factory PersonalizeDJ.fromJson(Map<String, dynamic> srcJson) =>
      _$PersonalizeDJFromJson(srcJson);

  Map<String, dynamic> toJson() => _$PersonalizeDJToJson(this);
}
