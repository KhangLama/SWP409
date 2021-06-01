import 'package:json_annotation/json_annotation.dart';

part 'booking.g.dart';

@JsonSerializable(explicitToJson: true)
class Booking {
  String iId;
  String status;
  DateTime bookedDate;
  int bookedTime;
  String user;
  String clinic;
  DateTime createdAt;
  DateTime updatedAt;

  Booking({
    this.iId,
    this.status,
    this.bookedDate,
    this.bookedTime,
    this.user,
    this.clinic,
    this.createdAt,
    this.updatedAt,
  });

  factory Booking.fromJson(Map<String, dynamic> json) => _$BookingFromJson(json);

  Map<String, dynamic> toJson() => _$BookingToJson(this);
}

