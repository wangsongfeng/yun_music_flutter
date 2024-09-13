import 'package:json_annotation/json_annotation.dart';
import 'package:yun_music/pages/blog_page/models/blog_recom_model.dart';

import '../../blog_page/models/blog_personal_model.dart';

part 'blog_detail_lists.g.dart';

@JsonSerializable()
class BlogDetailListsModel extends Object {
  @JsonKey(name: 'count')
  int? count;
  @JsonKey(name: 'code')
  int? code;
  @JsonKey(name: 'programs')
  List<BlogDetailProgramItem>? programs;

  BlogDetailListsModel({this.count, this.code, this.programs});

  factory BlogDetailListsModel.fromJson(Map<String, dynamic> srcJson) =>
      _$BlogDetailListsModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$BlogDetailListsModelToJson(this);
}

@JsonSerializable()
class BlogDetailProgramItem extends Object {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'coverUrl')
  String? coverUrl;
  @JsonKey(name: 'description')
  String? description;
  @JsonKey(name: 'likedCount')
  int? likedCount;
  @JsonKey(name: 'shareCount')
  int? shareCount;
  @JsonKey(name: 'commentCount')
  int? commentCount;
  @JsonKey(name: 'listenerCount')
  int? listenerCount;
  @JsonKey(name: 'createTime')
  int? createTime;
  @JsonKey(name: 'categoryId')
  int? categoryId;
  @JsonKey(name: 'duration')
  int? duration;
  @JsonKey(name: 'secondCategoryId')
  int? secondCategoryId;
  @JsonKey(name: 'radio')
  BlogRadios? radio;
  @JsonKey(name: 'scheduledPublishTime')
  int? scheduledPublishTime;
  @JsonKey(name: 'dj')
  PersonalizeDJ? dj;

  BlogDetailProgramItem({
    this.id,
    this.name,
    this.coverUrl,
    this.description,
    this.likedCount,
    this.shareCount,
    this.commentCount,
    this.listenerCount,
    this.createTime,
    this.categoryId,
    this.duration,
    this.secondCategoryId,
    this.radio,
    this.scheduledPublishTime,
    this.dj,
  });

  factory BlogDetailProgramItem.fromJson(Map<String, dynamic> srcJson) =>
      _$BlogDetailProgramItemFromJson(srcJson);

  Map<String, dynamic> toJson() => _$BlogDetailProgramItemToJson(this);
}
