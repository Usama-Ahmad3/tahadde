// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'yourTahaddiModelClass.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Files _$FilesFromJson(Map<String, dynamic> json) {
  return Files(
    id: json['id'] as int,
    files: json['files'] == null
        ? null
        : File.fromJson(json['files'] as Map<String, dynamic>),
    is_active: json['is_active'] as bool,
  );
}

Map<String, dynamic> _$FilesToJson(Files instance) => <String, dynamic>{
      'id': instance.id,
      'files': instance.files?.toJson(),
      'is_active': instance.is_active,
    };

File _$FileFromJson(Map<String, dynamic> json) {
  return File(
    id: json['id'] as int,
    filePath: json['filePath'] as String,
  );
}

Map<String, dynamic> _$FileToJson(File instance) => <String, dynamic>{
      'id': instance.id,
      'filePath': instance.filePath,
    };

YourTahaddi _$YourTahaddiFromJson(Map<String, dynamic> json) {
  return YourTahaddi(
    tahaddis: json['tahaddis'] == null
        ? null
        : Tahaddi.fromJson(json['tahaddis'] as Map<String, dynamic>),
    transactionMadeon: json['transactionMadeon'] as String,
    transactionFor: json['transactionFor'] as String,
    pitchType: (json['pitchType'] as List)
        .map((e) =>
            e == null ? null : PitchType.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$YourTahaddiToJson(YourTahaddi instance) =>
    <String, dynamic>{
      'tahaddis': instance.tahaddis?.toJson(),
      'transactionMadeon': instance.transactionMadeon,
      'transactionFor': instance.transactionFor,
      'pitchType': instance.pitchType?.map((e) => e?.toJson()).toList(),
    };

Tahaddi _$TahaddiFromJson(Map<String, dynamic> json) {
  return Tahaddi(
    name: json['name'] as String,
    country: json['country'] as String,
    files: json['files'] == null
        ? null
        : Files.fromJson(json['files'] as Map<String, dynamic>),
    startDate: json['startDate'] as String,
    endDate: json['endDate'] as String,
    organisedBy: json['organisedBy'] == null
        ? null
        : OrganisedBy.fromJson(json['organisedBy'] as Map<String, dynamic>),
    id: json['id'] as int,
  );
}

Map<String, dynamic> _$TahaddiToJson(Tahaddi instance) => <String, dynamic>{
      'name': instance.name,
      'files': instance.files?.toJson(),
      'id': instance.id,
      'country': instance.country,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'organisedBy': instance.organisedBy?.toJson(),
    };

OrganisedBy _$OrganisedByFromJson(Map<String, dynamic> json) {
  return OrganisedBy(
    id: json['id'] as int,
    name: json['name'] as String,
    email: json['email'] as String,
    contact_number: json['contact_number'] as String,
    ratings: json['ratings'] == null
        ? null
        : Rating.fromJson(json['ratings'] as Map<String, dynamic>),
    countryCode: json['countryCode'] as String,
  );
}

Map<String, dynamic> _$OrganisedByToJson(OrganisedBy instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'contact_number': instance.contact_number,
      'countryCode': instance.countryCode,
      'ratings': instance.ratings?.toJson(),
    };

PitchType _$PitchTypeFromJson(Map<String, dynamic> json) {
  return PitchType(
    id: json['id'] as int,
    name: json['name'] as String,
    area: json['area'] as String,
  );
}

Map<String, dynamic> _$PitchTypeToJson(PitchType instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'area': instance.area,
    };

Rating _$RatingFromJson(Map<String, dynamic> json) {
  return Rating(
    rating: json['rating'] as String,
  );
}

Map<String, dynamic> _$RatingToJson(Rating instance) => <String, dynamic>{
      'rating': instance.rating,
    };
