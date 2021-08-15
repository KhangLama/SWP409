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
            e == null ? null : Specialist.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    reviews: (json['reviews'] as List)
        ?.map((e) =>
            e == null ? null : Reviews.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    status: json['status'] as String,
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
    id: json['_id'] as String,
  );
}

Map<String, dynamic> _$ClinicToJson(Clinic instance) => <String, dynamic>{
      'coverImage': instance.coverImage?.toJson(),
      'name': instance.name,
      'email': instance.email,
      'address': instance.address,
      'phone': instance.phone,
      'specialists': instance.specialists?.map((e) => e?.toJson())?.toList(),
      'geometry': instance.geometry?.toJson(),
      'description': instance.description,
      'schedule': instance.schedule?.map((e) => e?.toJson())?.toList(),
      'reviews': instance.reviews?.map((e) => e?.toJson())?.toList(),
      'status': instance.status,
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
    id: json['_id'] as String,
    reply: json['reply'] as String,
    user: json['user'] == null
        ? null
        : User.fromJson(json['user'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$RepliesToJson(Replies instance) => <String, dynamic>{
      'id': instance.id,
      'reply': instance.reply,
      'user': instance.user?.toJson(),
    };

Schedule _$ScheduleFromJson(Map<String, dynamic> json) {
  return Schedule(
    workingHours: (json['workingHours'] as List)
        ?.map((e) =>
            e == null ? null : WorkingHours.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    dayOfWeek: json['dayOfWeek'] as int,
  );
}

Map<String, dynamic> _$ScheduleToJson(Schedule instance) => <String, dynamic>{
      'workingHours': instance.workingHours?.map((e) => e?.toJson())?.toList(),
      'dayOfWeek': instance.dayOfWeek,
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

Specialist _$SpecialistFromJson(Map<String, dynamic> json) {
  return Specialist(
    id: json['_id'] as String,
    name: json['name'] as String,
    symptoms: (json['symptoms'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$SpecialistToJson(Specialist instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'symptoms': instance.symptoms,
    };

CoverImage _$CoverImageFromJson(Map<String, dynamic> json) {
  return CoverImage(
    id: json['_id'] as String,
    url: json['url'] as String,
    filename: json['filename'] as String,
  );
}

Map<String, dynamic> _$CoverImageToJson(CoverImage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
      'filename': instance.filename,
    };
