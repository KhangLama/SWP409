import 'package:json_annotation/json_annotation.dart';

part 'clinic.g.dart';

@JsonSerializable(explicitToJson: true)
class Clinic {
  String id;
  String lat;
  String lng;
  String name;
  String address;
  Clinic({this.id, this.lat, this.lng, this.name, this.address});

  factory Clinic.fromJson(Map<String, dynamic> json) => _$ClinicFromJson(json);

  Map<String, dynamic> toJson() => _$ClinicToJson(this);
}
