// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'specialist.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Specialists _$SpecialistsFromJson(Map<String, dynamic> json) {
  return Specialists(
    id: json['_id'] as String,
    name: json['name'] as String,
    symptoms: json['symptoms'] as List,
  );
}

Map<String, dynamic> _$SpecialistsToJson(Specialists instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'symptoms': instance.symptoms,
    };
