import 'package:json_annotation/json_annotation.dart';
import 'package:swp409/Models/user.dart';

part 'user.g.dart';

@JsonSerializable(explicitToJson: true)
class User {
  Avatar avatar;
  String role;
  String sId;
  String name;
  String email;
  String phone;
  int iV;

  User(
  {this.avatar,
      this.role,
      this.sId,
      this.name,
      this.email,
      this.phone,
      this.iV});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Avatar {
  String sId;
  String url;
  String filename;

  Avatar({this.sId, this.url, this.filename});

  factory Avatar.fromJson(Map<String, dynamic> json) => _$AvatarFromJson(json);
  Map<String, dynamic> toJson() => _$AvatarToJson(this);
}
