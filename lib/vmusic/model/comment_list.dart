import 'package:json_annotation/json_annotation.dart';

import '../../commons/models/user_info_model.dart';
part 'comment_list.g.dart';

@JsonSerializable()
class CommentListData extends Object {
  @JsonKey(name: 'hasMore')
  bool? hasMore;
  @JsonKey(name: 'cursor')
  String? cursor;
  @JsonKey(name: 'totalCount')
  int? totalCount;
  @JsonKey(name: 'sortType')
  int? sortType;
  @JsonKey(name: 'sortTypeList')
  List<CommentListDataSortType>? sortTypeList;
  @JsonKey(name: 'comments')
  List<CommentItem>? comments;
  @JsonKey(name: 'currentComment')
  CommentItem? currentComment;

  CommentListData(
    this.hasMore,
    this.cursor,
    this.totalCount,
    this.sortType,
    this.sortTypeList,
    this.comments,
    this.currentComment,
  );

  factory CommentListData.fromJson(Map<String, dynamic> srcJson) =>
      _$CommentListDataFromJson(srcJson);

  Map<String, dynamic> toJson() => _$CommentListDataToJson(this);
}

@JsonSerializable()
class CommentListDataSortType extends Object {
  @JsonKey(name: 'sortType')
  int? sortType;
  @JsonKey(name: 'sortTypeName')
  String? sortTypeName;
  @JsonKey(name: 'target')
  String? target;
  CommentListDataSortType(
    this.sortType,
    this.sortTypeName,
    this.target,
  );

  factory CommentListDataSortType.fromJson(Map<String, dynamic> srcJson) =>
      _$CommentListDataSortTypeFromJson(srcJson);

  Map<String, dynamic> toJson() => _$CommentListDataSortTypeToJson(this);
}

@JsonSerializable()
class CommentItem extends Object {
  @JsonKey(name: 'commentId')
  int? commentId;
  @JsonKey(name: 'parentCommentId')
  int? parentCommentId;
  @JsonKey(name: 'user')
  late UserInfo user;
  @JsonKey(name: 'content')
  String? content;
  @JsonKey(name: 'time')
  int? time;
  @JsonKey(name: 'timeStr')
  String? timeStr;
  @JsonKey(name: 'likedCount')
  int? likedCount;
  @JsonKey(name: 'replyCount')
  int? replyCount;
  @JsonKey(name: 'liked')
  bool? liked;
  // beReplied
  @JsonKey(name: 'status')
  int? status;
  @JsonKey(name: 'commentLocationType')
  int? commentLocationType;

  CommentItem(
    this.commentId,
    this.parentCommentId,
    this.user,
    this.content,
    this.time,
    this.timeStr,
    this.likedCount,
    this.replyCount,
    this.liked,
    this.status,
    this.commentLocationType,
  );

  factory CommentItem.fromJson(Map<String, dynamic> srcJson) =>
      _$CommentItemFromJson(srcJson);

  Map<String, dynamic> toJson() => _$CommentItemToJson(this);
}
