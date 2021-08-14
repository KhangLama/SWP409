// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    avatar: json['avatar'] == null
        ? null
        : Avatar.fromJson(json['avatar'] as Map<String, dynamic>),
    role: json['role'] as String,
    sId: json['_id'] as String,
    name: json['name'] as String,
    email: json['email'] as String,
    phone: json['phone'] as String,
    iV: json['iV'] as int,
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'avatar': instance.avatar?.toJson(),
      'role': instance.role,
      'sId': instance.sId,
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
      'iV': instance.iV,
    };

Avatar _$AvatarFromJson(Map<String, dynamic> json) {
  return Avatar(
    sId: json['sId'] as String,
    url: json['url'] as String,
    filename: json['filename'] as String,
  );
}

Map<String, dynamic> _$AvatarToJson(Avatar instance) => <String, dynamic>{
      'sId': instance.sId,
      'url': instance.url,
      'filename': instance.filename,
    };
