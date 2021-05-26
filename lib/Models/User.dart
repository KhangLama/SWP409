import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable(explicitToJson: true)
class User {
  String role;
  String sId;
  String name;
  String email;
  String phone;
  String address;
  dynamic avatar;
  User({this.role, this.sId, this.name, this.email, this.phone, this.address, this.avatar});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
