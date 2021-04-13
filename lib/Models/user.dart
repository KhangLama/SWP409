import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';
@JsonSerializable(explicitToJson: true)
class User {
  String name;
  String phone;
  String email;
  String password;

  // ignore: sort_constructors_first
  User({this.name, this.phone, this.email, this.password});

  // ignore: sort_constructors_first
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
