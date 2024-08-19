// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'privilege_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PrivilegeModel _$PrivilegeModelFromJson(Map<String, dynamic> json) =>
    PrivilegeModel(
      (json['id'] as num).toInt(),
      (json['fee'] as num).toInt(),
      (json['payed'] as num).toInt(),
      json['preSell'] as bool,
      (json['playMaxbr'] as num?)?.toInt(),
      (json['maxbr'] as num?)?.toInt(),
      json['freeTrialPrivilege'] == null
          ? null
          : FreeTrialPrivilege.fromJson(
              json['freeTrialPrivilege'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PrivilegeModelToJson(PrivilegeModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fee': instance.fee,
      'payed': instance.payed,
      'preSell': instance.preSell,
      'playMaxbr': instance.playMaxbr,
      'maxbr': instance.maxbr,
      'freeTrialPrivilege': instance.freeTrialPrivilege,
    };

FreeTrialPrivilege _$FreeTrialPrivilegeFromJson(Map<String, dynamic> json) =>
    FreeTrialPrivilege(
      json['resConsumable'] as bool,
      json['userConsumable'] as bool,
    );

Map<String, dynamic> _$FreeTrialPrivilegeToJson(FreeTrialPrivilege instance) =>
    <String, dynamic>{
      'resConsumable': instance.resConsumable,
      'userConsumable': instance.userConsumable,
    };
