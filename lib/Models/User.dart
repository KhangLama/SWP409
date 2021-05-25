import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable(explicitToJson: true)
class User {
  String role;
  String sId;
  String name;
  String email;

  User({this.role, this.sId, this.name, this.email});

  User.fromJson(Map<String, dynamic> json) {
    role = json['role'];
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['role'] = this.role;
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['email'] = this.email;
    return data;
  }
}
