// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Booking _$BookingFromJson(Map<String, dynamic> json) {
  return Booking(
    id: json['_id'] as String,
    status: json['status'] as String,
    bookedDate: json['bookedDate'] == null
        ? null
        : DateTime.parse(json['bookedDate'] as String),
    bookedTime: json['bookedTime'] as int,
    user: json['user'] == null
        ? null
        : User.fromJson(json['user'] as Map<String, dynamic>),
    clinic: json['clinic'] == null
        ? null
        : Clinic.fromJson(json['clinic'] as Map<String, dynamic>),
    createdAt: json['createdAt'] == null
        ? null
        : DateTime.parse(json['createdAt'] as String),
    updatedAt: json['updatedAt'] == null
        ? null
        : DateTime.parse(json['updatedAt'] as String),
  );
}

Map<String, dynamic> _$BookingToJson(Booking instance) => <String, dynamic>{
      'id': instance.id,
      'status': instance.status,
      'bookedDate': instance.bookedDate?.toIso8601String(),
      'bookedTime': instance.bookedTime,
      'user': instance.user?.toJson(),
      'clinic': instance.clinic?.toJson(),
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
