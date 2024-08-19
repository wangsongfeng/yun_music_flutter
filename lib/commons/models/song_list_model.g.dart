// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'song_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SongListModel _$SongListModelFromJson(Map<String, dynamic> json) =>
    SongListModel(
      (json['songs'] as List<dynamic>)
          .map((e) => Song.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['privileges'] as List<dynamic>)
          .map((e) => PrivilegeModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SongListModelToJson(SongListModel instance) =>
    <String, dynamic>{
      'songs': instance.songs,
      'privileges': instance.privileges,
    };
