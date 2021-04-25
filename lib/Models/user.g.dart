// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    name: json['name'] as String,
    phone: json['phone'] as String,
    username: json['username'] as String,
    password: json['password'] as String,
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'name': instance.name,
      'phone': instance.phone,
      'username': instance.username,
      'password': instance.password,
    };
