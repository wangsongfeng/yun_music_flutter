// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) =>
    LoginResponse(
      (json['loginType'] as num).toInt(),
      (json['code'] as num).toInt(),
      Account.fromJson(json['account'] as Map<String, dynamic>),
      json['token'] as String,
      json['profile'] == null
          ? null
          : Profile.fromJson(json['profile'] as Map<String, dynamic>),
      json['cookie'] as String,
    );

Map<String, dynamic> _$LoginResponseToJson(LoginResponse instance) =>
    <String, dynamic>{
      'loginType': instance.loginType,
      'code': instance.code,
      'account': instance.account,
      'token': instance.token,
      'profile': instance.profile,
      'cookie': instance.cookie,
    };

Account _$AccountFromJson(Map<String, dynamic> json) => Account(
      (json['id'] as num).toInt(),
      json['userName'] as String,
      (json['type'] as num).toInt(),
      (json['status'] as num).toInt(),
      (json['whitelistAuthority'] as num).toInt(),
      (json['createTime'] as num).toInt(),
      json['salt'] as String,
      (json['tokenVersion'] as num).toInt(),
      (json['ban'] as num).toInt(),
      (json['baoyueVersion'] as num).toInt(),
      (json['donateVersion'] as num).toInt(),
      (json['vipType'] as num).toInt(),
      (json['viptypeVersion'] as num).toInt(),
      json['anonimousUser'] as bool,
    );

Map<String, dynamic> _$AccountToJson(Account instance) => <String, dynamic>{
      'id': instance.id,
      'userName': instance.userName,
      'type': instance.type,
      'status': instance.status,
      'whitelistAuthority': instance.whitelistAuthority,
      'createTime': instance.createTime,
      'salt': instance.salt,
      'tokenVersion': instance.tokenVersion,
      'ban': instance.ban,
      'baoyueVersion': instance.baoyueVersion,
      'donateVersion': instance.donateVersion,
      'vipType': instance.vipType,
      'viptypeVersion': instance.viptypeVersion,
      'anonimousUser': instance.anonimousUser,
    };

Profile _$ProfileFromJson(Map<String, dynamic> json) => Profile(
      (json['userId'] as num).toInt(),
      (json['userType'] as num).toInt(),
      (json['city'] as num).toInt(),
      json['avatarUrl'] as String,
      (json['djStatus'] as num).toInt(),
      json['followed'] as bool,
      json['backgroundUrl'] as String,
      json['detailDescription'] as String,
      json['avatarImgIdStr'] as String,
      json['backgroundImgIdStr'] as String,
      (json['vipType'] as num).toInt(),
      (json['avatarImgId'] as num).toInt(),
      json['nickname'] as String,
      (json['accountStatus'] as num).toInt(),
      (json['gender'] as num).toInt(),
      (json['backgroundImgId'] as num).toInt(),
      (json['birthday'] as num).toInt(),
      json['description'] as String,
      json['mutual'] as bool,
      (json['authStatus'] as num).toInt(),
      json['defaultAvatar'] as bool,
      (json['province'] as num).toInt(),
      json['signature'] as String,
      (json['authority'] as num).toInt(),
      (json['followeds'] as num).toInt(),
      (json['follows'] as num).toInt(),
      (json['eventCount'] as num).toInt(),
      (json['playlistCount'] as num).toInt(),
      (json['playlistBeSubscribedCount'] as num).toInt(),
    );

Map<String, dynamic> _$ProfileToJson(Profile instance) => <String, dynamic>{
      'userId': instance.userId,
      'userType': instance.userType,
      'city': instance.city,
      'avatarUrl': instance.avatarUrl,
      'djStatus': instance.djStatus,
      'followed': instance.followed,
      'backgroundUrl': instance.backgroundUrl,
      'detailDescription': instance.detailDescription,
      'avatarImgIdStr': instance.avatarImgIdStr,
      'backgroundImgIdStr': instance.backgroundImgIdStr,
      'vipType': instance.vipType,
      'avatarImgId': instance.avatarImgId,
      'nickname': instance.nickname,
      'accountStatus': instance.accountStatus,
      'gender': instance.gender,
      'backgroundImgId': instance.backgroundImgId,
      'birthday': instance.birthday,
      'description': instance.description,
      'mutual': instance.mutual,
      'authStatus': instance.authStatus,
      'defaultAvatar': instance.defaultAvatar,
      'province': instance.province,
      'signature': instance.signature,
      'authority': instance.authority,
      'followeds': instance.followeds,
      'follows': instance.follows,
      'eventCount': instance.eventCount,
      'playlistCount': instance.playlistCount,
      'playlistBeSubscribedCount': instance.playlistBeSubscribedCount,
    };

Experts _$ExpertsFromJson(Map<String, dynamic> json) => Experts();

Map<String, dynamic> _$ExpertsToJson(Experts instance) => <String, dynamic>{};
