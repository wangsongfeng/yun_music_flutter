

import 'package:json_annotation/json_annotation.dart';

part 'recom_cale_model.g.dart';

@JsonSerializable()
class RecomCaleModel extends Object {
  @JsonKey(name: 'startTime')
  int startTime;

  @JsonKey(name: 'endTime')
  int endTime;

  @JsonKey(name: 'subed')
  bool subed;

  @JsonKey(name: 'subCount')
  int? subCount;

  @JsonKey(name: 'canSubscribe')
  bool canSubscribe;

  @JsonKey(name: 'tags')
  List<String>? tags;

  RecomCaleModel(
    this.startTime,
    this.endTime,
    this.subed,
    this.subCount,
    this.canSubscribe,
    this.tags,
  );

  factory RecomCaleModel.fromJson(Map<String, dynamic> srcJson) =>
      _$RecomCaleModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$RecomCaleModelToJson(this);
}
