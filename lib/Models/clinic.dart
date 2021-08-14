import 'package:json_annotation/json_annotation.dart';
import 'package:swp409/Models/user.dart';

part 'clinic.g.dart';

@JsonSerializable(explicitToJson: true)
class Clinic {
  CoverImage coverImage;
  String name;
  String email;
  String address;
  String phone;
  List<Specialist> specialists;
  Geometry geometry;
  String description;
  List<Schedule> schedule;
  List<Reviews> reviews;
  String status;
  String sId;
  int iV;
  int reviewCount;
  double ratingAvg;
  String id;

  Clinic(
      {this.geometry,
      this.specialists,
      this.reviews,
      this.status,
      this.sId,
      this.email,
      this.phone,
      this.description,
      this.name,
      this.schedule,
      this.coverImage,
      this.iV,
      this.address,
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
  String id;
  double rating;
  String review;
  List<Replies> replies;
  User user;
  String createdAt;
  String updatedAt;
  int v;

  Reviews(
      {this.id,
      this.rating,
      this.review,
      this.replies,
      this.user,
      this.createdAt,
      this.updatedAt,
      this.v});

  factory Reviews.fromJson(Map<String, dynamic> json) =>
      _$ReviewsFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewsToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Replies {
  String sId;
  String reply;
  User user;

  Replies({
    this.sId,
    this.reply,
    this.user,
  });

  factory Replies.fromJson(Map<String, dynamic> json) =>
      _$RepliesFromJson(json);

  Map<String, dynamic> toJson() => _$RepliesToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Schedule {
  int dayOfWeek;
  List<WorkingHours> workingHours;

  Schedule({this.dayOfWeek, this.workingHours});

  factory Schedule.fromJson(Map<String, dynamic> json) =>
      _$ScheduleFromJson(json);

  Map<String, dynamic> toJson() => _$ScheduleToJson(this);
}

@JsonSerializable(explicitToJson: true)
class WorkingHours {
  int startTime;
  int endTime;

  WorkingHours({this.startTime, this.endTime});

  factory WorkingHours.fromJson(Map<String, dynamic> json) =>
      _$WorkingHoursFromJson(json);

  Map<String, dynamic> toJson() => _$WorkingHoursToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Specialist {
  String id;
  String name;
  List<String> symptoms;

  Specialist({this.id, this.name, this.symptoms});

  factory Specialist.fromJson(Map<String, dynamic> json) =>
      _$SpecialistFromJson(json);

  Map<String, dynamic> toJson() => _$SpecialistToJson(this);
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
