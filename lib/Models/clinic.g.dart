// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'clinic.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Clinic _$ClinicFromJson(Map<String, dynamic> json) {
  return Clinic(
    geometry: json['geometry'] == null
        ? null
        : Geometry.fromJson(json['geometry'] as Map<String, dynamic>),
    reviews: (json['reviews'] as List)
        ?.map((e) =>
            e == null ? null : Reviews.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    status: json['status'] as String,
    sId: json['sId'] as String,
    name: json['name'] as String,
    phone: json['phone'] as String,
    email: json['email'] as String,
    description: json['description'] as String,
    address: json['address'] as String,
    schedule: (json['schedule'] as List)
        ?.map((e) =>
            e == null ? null : Schedule.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    coverImage: json['coverImage'] == null
        ? null
        : CoverImage.fromJson(json['coverImage'] as Map<String, dynamic>),
    iV: json['iV'] as int,
    reviewCount: json['reviewCount'] as int,
    ratingAvg: json['ratingAvg'] as int,
    id: json['id'] as String,
  );
}

Map<String, dynamic> _$ClinicToJson(Clinic instance) => <String, dynamic>{
      'geometry': instance.geometry?.toJson(),
      'reviews': instance.reviews?.map((e) => e?.toJson())?.toList(),
      'status': instance.status,
      'sId': instance.sId,
      'name': instance.name,
      'phone': instance.phone,
      'email': instance.email,
      'description': instance.description,
      'address': instance.address,
      'schedule': instance.schedule?.map((e) => e?.toJson())?.toList(),
      'coverImage': instance.coverImage?.toJson(),
      'iV': instance.iV,
      'reviewCount': instance.reviewCount,
      'ratingAvg': instance.ratingAvg,
      'id': instance.id,
    };

Geometry _$GeometryFromJson(Map<String, dynamic> json) {
  return Geometry(
    type: json['type'] as String,
    coordinates: (json['coordinates'] as List)
        ?.map((e) => (e as num)?.toDouble())
        ?.toList(),
  );
}

Map<String, dynamic> _$GeometryToJson(Geometry instance) => <String, dynamic>{
      'type': instance.type,
      'coordinates': instance.coordinates,
    };

Reviews _$ReviewsFromJson(Map<String, dynamic> json) {
  return Reviews(
    replies: (json['replies'] as List)
        ?.map((e) =>
            e == null ? null : Replies.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    sId: json['sId'] as String,
    rating: json['rating'] as int,
    review: json['review'] as String,
    user: json['user'] == null
        ? null
        : User.fromJson(json['user'] as Map<String, dynamic>),
    createdAt: json['createdAt'] as String,
    updatedAt: json['updatedAt'] as String,
    iV: json['iV'] as int,
  );
}

Map<String, dynamic> _$ReviewsToJson(Reviews instance) => <String, dynamic>{
      'replies': instance.replies?.map((e) => e?.toJson())?.toList(),
      'sId': instance.sId,
      'rating': instance.rating,
      'review': instance.review,
      'user': instance.user?.toJson(),
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'iV': instance.iV,
    };

Replies _$RepliesFromJson(Map<String, dynamic> json) {
  return Replies(
    sId: json['sId'] as String,
    rating: json['rating'] as int,
    review: json['review'] as String,
    user: json['user'] == null
        ? null
        : User.fromJson(json['user'] as Map<String, dynamic>),
    createdAt: json['createdAt'] as String,
    updatedAt: json['updatedAt'] as String,
    iV: json['iV'] as int,
  );
}

Map<String, dynamic> _$RepliesToJson(Replies instance) => <String, dynamic>{
      'sId': instance.sId,
      'rating': instance.rating,
      'review': instance.review,
      'user': instance.user?.toJson(),
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'iV': instance.iV,
    };

Schedule _$ScheduleFromJson(Map<String, dynamic> json) {
  return Schedule(
    dayOfWeek: json['dayOfWeek'] as int,
    startTime: json['startTime'] == null
        ? null
        : DateTime.parse(json['startTime'] as String),
    endTime: json['endTime'] == null
        ? null
        : DateTime.parse(json['endTime'] as String),
  );
}

Map<String, dynamic> _$ScheduleToJson(Schedule instance) => <String, dynamic>{
      'dayOfWeek': instance.dayOfWeek,
      'startTime': instance.startTime?.toIso8601String(),
      'endTime': instance.endTime?.toIso8601String(),
    };

CoverImage _$CoverImageFromJson(Map<String, dynamic> json) {
  return CoverImage(
    sId: json['sId'] as String,
    url: json['url'] as String,
    filename: json['filename'] as String,
  );
}

Map<String, dynamic> _$CoverImageToJson(CoverImage instance) =>
    <String, dynamic>{
      'sId': instance.sId,
      'url': instance.url,
      'filename': instance.filename,
    };
