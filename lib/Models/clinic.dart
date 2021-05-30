import 'package:json_annotation/json_annotation.dart';
import 'package:swp409/Models/user.dart';

part 'clinic.g.dart';

@JsonSerializable(explicitToJson: true)
class Clinic {
  Geometry geometry;
  List<Reviews> reviews;
  String status;
  String sId;
  String name;
  String phone;
  String email;
  String description;
  String address;
  List<Schedule> schedule;
  CoverImage coverImage;
  int iV;
  int reviewCount;
  int ratingAvg;
  String id;

  Clinic(
      {this.geometry,
      this.reviews,
      this.status,
      this.sId,
      this.name,
      this.phone,
      this.email,
      this.description,
      this.address,
      this.schedule,
      this.coverImage,
      this.iV,
      this.reviewCount,
      this.ratingAvg,
      this.id});

  factory Clinic.fromJson(Map<String, dynamic> json) => _$ClinicFromJson(json);

  Map<String, dynamic> toJson() => _$ClinicToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Geometry {
  String type;
  List<double> coordinates;

  Geometry({this.type, this.coordinates});

  factory Geometry.fromJson(Map<String, dynamic> json) =>
      _$GeometryFromJson(json);

  Map<String, dynamic> toJson() => _$GeometryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Reviews {
  List<Replies> replies;
  String sId;
  int rating;
  String review;
  User user;
  String createdAt;
  String updatedAt;
  int iV;

  Reviews(
      {this.replies,
      this.sId,
      this.rating,
      this.review,
      this.user,
      this.createdAt,
      this.updatedAt,
      this.iV});

  factory Reviews.fromJson(Map<String, dynamic> json) =>
      _$ReviewsFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewsToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Replies {
  String sId;
  int rating;
  String review;
  User user;
  String createdAt;
  String updatedAt;
  int iV;

  Replies(
      {this.sId,
      this.rating,
      this.review,
      this.user,
      this.createdAt,
      this.updatedAt,
      this.iV});

  factory Replies.fromJson(Map<String, dynamic> json) =>
      _$RepliesFromJson(json);

  Map<String, dynamic> toJson() => _$RepliesToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Schedule {
  String sId;
  int dayOfWeek;
  int startTime;
  int endTime;

  Schedule({this.sId, this.dayOfWeek, this.startTime, this.endTime});

  factory Schedule.fromJson(Map<String, dynamic> json) =>
      _$ScheduleFromJson(json);

  Map<String, dynamic> toJson() => _$ScheduleToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CoverImage {
  String sId;
  String url;
  String filename;

  CoverImage({this.sId, this.url, this.filename});

  factory CoverImage.fromJson(Map<String, dynamic> json) =>
      _$CoverImageFromJson(json);

  Map<String, dynamic> toJson() => _$CoverImageToJson(this);
}
