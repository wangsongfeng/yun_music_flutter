import 'package:json_annotation/json_annotation.dart';

import '../../blog_page/models/blog_personal_model.dart';
import '../../blog_page/models/blog_recom_model.dart';

part 'blog_detail_model.g.dart';

@JsonSerializable()
class BlogDetailModel extends Object {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'picUrl')
  String? picUrl;
  @JsonKey(name: 'desc')
  String? desc;
  @JsonKey(name: 'subCount')
  int? subCount;
  @JsonKey(name: 'shareCount')
  int? shareCount;
  @JsonKey(name: 'commentCount')
  int? commentCount;
  @JsonKey(name: 'playCount')
  int? playCount;
  @JsonKey(name: 'category')
  String? category;
  @JsonKey(name: 'categoryId')
  int? categoryId;
  @JsonKey(name: 'secondCategory')
  String? secondCategory;
  @JsonKey(name: 'secondCategoryId')
  int? secondCategoryId;
  @JsonKey(name: 'dj')
  PersonalizeDJ? dj;
  @JsonKey(name: 'icon')
  BlogIcons? icon;

  BlogDetailModel({
    this.id,
    this.name,
    this.picUrl,
    this.desc,
    this.subCount,
    this.shareCount,
    this.commentCount,
    this.playCount,
    this.category,
    this.categoryId,
    this.secondCategory,
    this.secondCategoryId,
    this.dj,
    this.icon,
  });

  factory BlogDetailModel.fromJson(Map<String, dynamic> srcJson) =>
      _$BlogDetailModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$BlogDetailModelToJson(this);
}

class DetailIndicatorModel {
  DetailIndicatorModel();

  String? title;
  int? id;
}
