import 'package:json_annotation/json_annotation.dart';

part 'blog_recom_model.g.dart';

@JsonSerializable()
class BlogRecomModel extends Object {
  @JsonKey(name: 'categoryId')
  int? categoryId;
  @JsonKey(name: 'categoryName')
  String? categoryName;
  @JsonKey(name: 'radios')
  List<BlogRadios>? radios;

  BlogRecomModel({this.categoryId, this.categoryName, this.radios});

  factory BlogRecomModel.fromJson(Map<String, dynamic> srcJson) =>
      _$BlogRecomModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$BlogRecomModelToJson(this);
}

@JsonSerializable()
class BlogRadios extends Object {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'rcmdText')
  String? rcmdText;
  @JsonKey(name: 'radioFeeType')
  int? radioFeeType;
  @JsonKey(name: 'feeScope')
  int? feeScope;
  @JsonKey(name: 'picUrl')
  String? picUrl;
  @JsonKey(name: 'programCount')
  int? programCount;
  @JsonKey(name: 'subCount')
  int? subCount;
  @JsonKey(name: 'subed')
  bool? subed;
  @JsonKey(name: 'playCount')
  int? playCount;
  @JsonKey(name: 'alg')
  String? alg;
  @JsonKey(name: 'lastProgramName')
  String? lastProgramName;
  @JsonKey(name: 'traceId')
  String? traceId;
  @JsonKey(name: 'icon')
  BlogIcons? icon;

  BlogRadios(
      {this.id,
      this.name,
      this.rcmdText,
      this.radioFeeType,
      this.feeScope,
      this.picUrl,
      this.programCount,
      this.subCount,
      this.subed,
      this.playCount,
      this.alg,
      this.lastProgramName,
      this.traceId,
      this.icon});

  factory BlogRadios.fromJson(Map<String, dynamic> srcJson) =>
      _$BlogRadiosFromJson(srcJson);

  Map<String, dynamic> toJson() => _$BlogRadiosToJson(this);
}

@JsonSerializable()
class BlogIcons extends Object {
  @JsonKey(name: 'type')
  String? type;
  @JsonKey(name: 'value')
  String? value;
  @JsonKey(name: 'color')
  String? color;

  BlogIcons({
    this.type,
    this.value,
    this.color,
  });
  factory BlogIcons.fromJson(Map<String, dynamic> srcJson) =>
      _$BlogIconsFromJson(srcJson);

  Map<String, dynamic> toJson() => _$BlogIconsToJson(this);
}
