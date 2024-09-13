import 'package:json_annotation/json_annotation.dart';
import 'package:yun_music/pages/blog_page/models/blog_banner_model.dart';
import 'package:yun_music/pages/blog_page/models/blog_personal_model.dart';
import 'package:yun_music/pages/blog_page/models/blog_recom_model.dart';

part 'blog_home_model.g.dart';

@JsonSerializable()
class BlogHomeModel extends Object {
  @JsonKey(name: 'code')
  int? code;
  @JsonKey(name: 'msg')
  String? msg;
  @JsonKey(name: 'data')
  List<BlogRecomModel>? data;
  @JsonKey(name: 'banner')
  List<BlogBannerModel>? banner;
  @JsonKey(name: 'personal')
  List<BlogPersonalModel>? personal;

  BlogHomeModel({this.code, this.msg, this.data});

  factory BlogHomeModel.fromJson(Map<String, dynamic> srcJson) =>
      _$BlogHomeModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$BlogHomeModelToJson(this);
}
