// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Booking _$BookingFromJson(Map<String, dynamic> json) {
  return Booking(
    iId: json['iId'] as String,
    status: json['status'] as String,
    bookedDate: json['bookedDate'] == null
        ? null
        : DateTime.parse(json['bookedDate'] as String),
    bookedTime: json['bookedTime'] as int,
    user: json['user'] as String,
    clinic: json['clinic'] as String,
    createdAt: json['createdAt'] == null
        ? null
        : DateTime.parse(json['createdAt'] as String),
    updatedAt: json['updatedAt'] == null
        ? null
        : DateTime.parse(json['updatedAt'] as String),
  );
}

Map<String, dynamic> _$BookingToJson(Booking instance) => <String, dynamic>{
      'iId': instance.iId,
      'status': instance.status,
      'bookedDate': instance.bookedDate?.toIso8601String(),
      'bookedTime': instance.bookedTime,
      'user': instance.user,
      'clinic': instance.clinic,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
