// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'searchPlayerModelClass.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchPlayerModelClass _$SearchPlayerModelClassFromJson(
    Map<String, dynamic> json) {
  return SearchPlayerModelClass(
    id: json['id'] as int,
    is_sent: json['is_sent'] as bool,
    contactNumber: json['contactNumber'] as String,
    email: json['email'] as String,
    first_name: json['first_name'] as String,
    last_name: json['last_name'] as String,
    profile_pic: json['profile_pic'] == null
        ? null
        : Profile.fromJson(json['profile_pic'] as Map<String, dynamic>),
    playerPosition: json['playerPosition'] == null
        ? null
        : Position.fromJson(json['playerPosition'] as Map<String, dynamic>),
    dob: json['dob'] as String,
    customerstripeId: json['customerstripeId'] as String,
  );
}

Map<String, dynamic> _$SearchPlayerModelClassToJson(
        SearchPlayerModelClass instance) =>
    <String, dynamic>{
      'id': instance.id,
      'is_sent': instance.is_sent,
      'contactNumber': instance.contactNumber,
      'email': instance.email,
      'first_name': instance.first_name,
      'last_name': instance.last_name,
      'profile_pic': instance.profile_pic?.toJson(),
      'dob': instance.dob,
      'customerstripeId': instance.customerstripeId,
      'playerPosition': instance.playerPosition?.toJson(),
    };

Profile _$ProfileFromJson(Map<String, dynamic> json) {
  return Profile(
    filePath: json['filePath'] as String,
  );
}

Map<String, dynamic> _$ProfileToJson(Profile instance) => <String, dynamic>{
      'filePath': instance.filePath,
    };

Position _$PositionFromJson(Map<String, dynamic> json) {
  return Position(
    id: json['id'] as int,
    name: json['name'] as String,
    slug: json['slug'] as String,
  );
}

Map<String, dynamic> _$PositionToJson(Position instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'slug': instance.slug,
    };
