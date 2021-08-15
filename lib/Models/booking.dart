import 'package:json_annotation/json_annotation.dart';
import 'package:swp409/Models/user.dart';

import 'clinic.dart';

part 'booking.g.dart';

@JsonSerializable(explicitToJson: true)
class Booking {
  String id;
  String status;
  DateTime bookedDate;
  int bookedTime;
  User user;
  Clinic clinic;
  DateTime createdAt;
  DateTime updatedAt;

  Booking({
    this.id,
    this.status,
    this.bookedDate,
    this.bookedTime,
    this.user,
    this.clinic,
    this.createdAt,
    this.updatedAt,
  });

  factory Booking.fromJson(Map<String, dynamic> json) =>
      _$BookingFromJson(json);

  Map<String, dynamic> toJson() => _$BookingToJson(this);
}
