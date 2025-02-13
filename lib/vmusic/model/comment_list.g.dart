// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentListWrap _$CommentListWrapFromJson(Map<String, dynamic> json) =>
    CommentListWrap(
      json['data'] == null
          ? null
          : CommentListData.fromJson(json['data'] as Map<String, dynamic>),
      (json['code'] as num?)?.toInt(),
    );

Map<String, dynamic> _$CommentListWrapToJson(CommentListWrap instance) =>
    <String, dynamic>{
      'data': instance.data,
      'code': instance.code,
    };

CommentListData _$CommentListDataFromJson(Map<String, dynamic> json) =>
    CommentListData(
      json['hasMore'] as bool?,
      json['cursor'] as String?,
      (json['totalCount'] as num?)?.toInt(),
      (json['sortType'] as num?)?.toInt(),
      (json['sortTypeList'] as List<dynamic>?)
          ?.map((e) =>
              CommentListDataSortType.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['comments'] as List<dynamic>?)
          ?.map((e) => CommentItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['currentComment'] == null
          ? null
          : CommentItem.fromJson(
              json['currentComment'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CommentListDataToJson(CommentListData instance) =>
    <String, dynamic>{
      'hasMore': instance.hasMore,
      'cursor': instance.cursor,
      'totalCount': instance.totalCount,
      'sortType': instance.sortType,
      'sortTypeList': instance.sortTypeList,
      'comments': instance.comments,
      'currentComment': instance.currentComment,
    };

CommentListDataSortType _$CommentListDataSortTypeFromJson(
        Map<String, dynamic> json) =>
    CommentListDataSortType(
      (json['sortType'] as num?)?.toInt(),
      json['sortTypeName'] as String?,
      json['target'] as String?,
    );

Map<String, dynamic> _$CommentListDataSortTypeToJson(
        CommentListDataSortType instance) =>
    <String, dynamic>{
      'sortType': instance.sortType,
      'sortTypeName': instance.sortTypeName,
      'target': instance.target,
    };

CommentItem _$CommentItemFromJson(Map<String, dynamic> json) => CommentItem(
      (json['commentId'] as num?)?.toInt(),
      (json['parentCommentId'] as num?)?.toInt(),
      UserInfo.fromJson(json['user'] as Map<String, dynamic>),
      json['content'] as String?,
      (json['time'] as num?)?.toInt(),
      json['timeStr'] as String?,
      (json['likedCount'] as num?)?.toInt(),
      (json['replyCount'] as num?)?.toInt(),
      json['liked'] as bool?,
      (json['status'] as num?)?.toInt(),
      (json['commentLocationType'] as num?)?.toInt(),
    );

Map<String, dynamic> _$CommentItemToJson(CommentItem instance) =>
    <String, dynamic>{
      'commentId': instance.commentId,
      'parentCommentId': instance.parentCommentId,
      'user': instance.user,
      'content': instance.content,
      'time': instance.time,
      'timeStr': instance.timeStr,
      'likedCount': instance.likedCount,
      'replyCount': instance.replyCount,
      'liked': instance.liked,
      'status': instance.status,
      'commentLocationType': instance.commentLocationType,
    };
