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
    specialists: (json['specialists'] as List)
        ?.map((e) =>
            e == null ? null : Specialists.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    reviews: (json['reviews'] as List)
        ?.map((e) =>
            e == null ? null : Reviews.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    status: json['status'] as String,
    sId: json['sId'] as String,
    email: json['email'] as String,
    phone: json['phone'] as String,
    description: json['description'] as String,
    name: json['name'] as String,
    schedule: (json['schedule'] as List)
        ?.map((e) =>
            e == null ? null : Schedule.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    coverImage: json['coverImage'] == null
        ? null
        : CoverImage.fromJson(json['coverImage'] as Map<String, dynamic>),
    iV: json['iV'] as int,
    address: json['address'] as String,
    reviewCount: json['reviewCount'] as int,
    ratingAvg: (json['ratingAvg'] as num)?.toDouble(),
    id: json['id'] as String,
  );
}

Map<String, dynamic> _$ClinicToJson(Clinic instance) => <String, dynamic>{
      'geometry': instance.geometry?.toJson(),
      'specialists': instance.specialists?.map((e) => e?.toJson())?.toList(),
      'reviews': instance.reviews?.map((e) => e?.toJson())?.toList(),
      'status': instance.status,
      'sId': instance.sId,
      'email': instance.email,
      'phone': instance.phone,
      'description': instance.description,
      'name': instance.name,
      'schedule': instance.schedule?.map((e) => e?.toJson())?.toList(),
      'coverImage': instance.coverImage?.toJson(),
      'iV': instance.iV,
      'address': instance.address,
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
    id: json['_id'] as String,
    rating: (json['rating'] as num)?.toDouble(),
    review: json['review'] as String,
    replies: (json['replies'] as List)
        ?.map((e) =>
            e == null ? null : Replies.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    user: json['user'] == null
        ? null
        : User.fromJson(json['user'] as Map<String, dynamic>),
    createdAt: json['createdAt'] as String,
    updatedAt: json['updatedAt'] as String,
    v: json['v'] as int,
  );
}

Map<String, dynamic> _$ReviewsToJson(Reviews instance) => <String, dynamic>{
      'id': instance.id,
      'rating': instance.rating,
      'review': instance.review,
      'replies': instance.replies?.map((e) => e?.toJson())?.toList(),
      'user': instance.user?.toJson(),
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'v': instance.v,
    };

Replies _$RepliesFromJson(Map<String, dynamic> json) {
  return Replies(
    sId: json['_id'] as String,
    reply: json['reply'] as String,
    user: json['user'] == null
        ? null
        : User.fromJson(json['user'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$RepliesToJson(Replies instance) => <String, dynamic>{
      'sId': instance.sId,
      'reply': instance.reply,
      'user': instance.user?.toJson(),
    };

Schedule _$ScheduleFromJson(Map<String, dynamic> json) {
  return Schedule(
    dayOfWeek: json['dayOfWeek'] as int,
    workingHours: (json['workingHours'] as List)
        ?.map((e) =>
            e == null ? null : WorkingHours.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ScheduleToJson(Schedule instance) => <String, dynamic>{
      'dayOfWeek': instance.dayOfWeek,
      'workingHours': instance.workingHours?.map((e) => e?.toJson())?.toList(),
    };

WorkingHours _$WorkingHoursFromJson(Map<String, dynamic> json) {
  return WorkingHours(
    startTime: json['startTime'] as int,
    endTime: json['endTime'] as int,
  );
}

Map<String, dynamic> _$WorkingHoursToJson(WorkingHours instance) =>
    <String, dynamic>{
      'startTime': instance.startTime,
      'endTime': instance.endTime,
    };

Specialists _$SpecialistsFromJson(Map<String, dynamic> json) {
  return Specialists(
    id: json['id'] as int,
    name: json['name'] as int,
  );
}

Map<String, dynamic> _$SpecialistsToJson(Specialists instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
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
