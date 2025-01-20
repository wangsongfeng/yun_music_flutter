import 'package:json_annotation/json_annotation.dart';

part 'square_info.g.dart';

@JsonSerializable()
class SquareInfo extends Object {
  @JsonKey(name: 'pageNum')
  int? pageNum;
  @JsonKey(name: 'pageSize')
  int? pageSize;
  @JsonKey(name: 'size')
  int? size;
  @JsonKey(name: 'total')
  int? total;
  @JsonKey(name: 'pages')
  int? pages;
  @JsonKey(name: 'list')
  List<SquareList>? list;

  SquareInfo(
    this.pageNum,
    this.pageSize,
    this.size,
    this.total,
    this.pages,
    this.list,
  );

  factory SquareInfo.fromJson(Map<String, dynamic> srcJson) =>
      _$SquareInfoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$SquareInfoToJson(this);
}

@JsonSerializable()
class SquareList extends Object {
  @JsonKey(name: 'weiboId')
  String? weiboId;
  @JsonKey(name: 'categoryId')
  String? categoryId;
  @JsonKey(name: 'content')
  String? content;
  @JsonKey(name: 'vediourl')
  String? vediourl;
  @JsonKey(name: 'tail')
  String? tail;
  @JsonKey(name: 'createtime')
  int? createtime;
  @JsonKey(name: 'zanStatus')
  int? zanStatus;
  @JsonKey(name: 'zhuanfaNum')
  int? zhuanfaNum;
  @JsonKey(name: 'likeNum')
  int? likeNum;
  @JsonKey(name: 'commentNum')
  int? commentNum;
  @JsonKey(name: 'userInfo')
  SquareUserInfo? userInfo;
  @JsonKey(name: 'picurl')
  List<String>? picurl;
  @JsonKey(name: 'zfContent')
  String? zfContent;
  @JsonKey(name: 'zfNick')
  String? zfNick;
  @JsonKey(name: 'zfUserId')
  String? zfUserId;
  @JsonKey(name: 'zfPicurl')
  List<String>? zfPicurl;
  @JsonKey(name: 'zfWeiBoId')
  String? zfWeiBoId;
  @JsonKey(name: 'zfVedioUrl')
  String? zfVedioUrl;
  @JsonKey(name: 'containZf')
  bool? containZf;

  SquareList(
      this.weiboId,
      this.categoryId,
      this.content,
      this.vediourl,
      this.tail,
      this.createtime,
      this.zanStatus,
      this.zhuanfaNum,
      this.likeNum,
      this.commentNum,
      this.userInfo,
      this.picurl,
      this.zfContent,
      this.zfNick,
      this.zfUserId,
      this.zfPicurl,
      this.zfWeiBoId,
      this.zfVedioUrl,
      this.containZf);

  factory SquareList.fromJson(Map<String, dynamic> srcJson) =>
      _$SquareListFromJson(srcJson);

  Map<String, dynamic> toJson() => _$SquareListToJson(this);
}

@JsonSerializable()
class SquareUserInfo extends Object {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'nick')
  String? nick;
  @JsonKey(name: 'headurl')
  String? headurl;
  @JsonKey(name: 'decs')
  String? decs;
  @JsonKey(name: 'ismember')
  int? ismember;
  @JsonKey(name: 'isvertify')
  int? isvertify;

  SquareUserInfo(this.id, this.nick, this.headurl, this.decs, this.ismember,
      this.isvertify);

  factory SquareUserInfo.fromJson(Map<String, dynamic> srcJson) =>
      _$SquareUserInfoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$SquareUserInfoToJson(this);
}
