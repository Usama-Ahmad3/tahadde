// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teamModelClass.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TeamModelClass _$TeamModelClassFromJson(Map<String, dynamic> json) {
  return TeamModelClass(
    id: json['id'] as int,
    contactNumber: json['contactNumber'] as String,
    email: json['email'] as String,
    captain: json['captain'] == null
        ? null
        : Captain.fromJson(json['captain'] as Map<String, dynamic>),
    created_at: json['created_at'] as String,
    numberofPlayers: json['numberofPlayers'] as int,
    players: (json['players'] as List)
        ?.map((e) =>
            e == null ? null : Players.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    teamLogo: json['teamLogo'] == null
        ? null
        : TeamLogo.fromJson(json['teamLogo'] as Map<String, dynamic>),
    teamName: json['teamName'] as String,
    countryCode: json['countryCode'] as String,
  );
}

Map<String, dynamic> _$TeamModelClassToJson(TeamModelClass instance) =>
    <String, dynamic>{
      'id': instance.id,
      'contactNumber': instance.contactNumber,
      'countryCode': instance.countryCode,
      'email': instance.email,
      'teamName': instance.teamName,
      'created_at': instance.created_at,
      'numberofPlayers': instance.numberofPlayers,
      'captain': instance.captain?.toJson(),
      'players': instance.players?.map((e) => e?.toJson())?.toList(),
      'teamLogo': instance.teamLogo?.toJson(),
    };

Captain _$CaptainFromJson(Map<String, dynamic> json) {
  return Captain(
    id: json['id'] as int,
    email: json['email'] as String,
    contact_number: json['contact_number'] as String,
    customerstripeId: json['customerstripeId'] as String,
    dob: json['dob'] as String,
    first_name: json['first_name'] as String,
    last_name: json['last_name'] as String,
    playerPosition: json['playerPosition'] == null
        ? null
        : Position.fromJson(json['playerPosition'] as Map<String, dynamic>),
    profile_pic: json['profile_pic'] == null
        ? null
        : Profile.fromJson(json['profile_pic'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CaptainToJson(Captain instance) => <String, dynamic>{
      'id': instance.id,
      'first_name': instance.first_name,
      'last_name': instance.last_name,
      'email': instance.email,
      'contact_number': instance.contact_number,
      'profile_pic': instance.profile_pic?.toJson(),
      'dob': instance.dob,
      'customerstripeId': instance.customerstripeId,
      'playerPosition': instance.playerPosition?.toJson(),
    };

TeamLogo _$TeamLogoFromJson(Map<String, dynamic> json) {
  return TeamLogo(
    id: json['id'] as int,
    fileOf: json['fileOf'] as String,
    filePath: json['filePath'] as String,
  );
}

Map<String, dynamic> _$TeamLogoToJson(TeamLogo instance) => <String, dynamic>{
      'id': instance.id,
      'fileOf': instance.fileOf,
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

Players _$PlayersFromJson(Map<String, dynamic> json) {
  return Players(
    dob: json['dob'] as String,
    id: json['id'] as int,
    contact_number: json['contact_number'] as String,
    email: json['email'] as String,
    last_name: json['last_name'] as String,
    customerstripeId: json['customerstripeId'] as String,
    playerPosition: json['playerPosition'] == null
        ? null
        : Position.fromJson(json['playerPosition'] as Map<String, dynamic>),
    first_name: json['first_name'] as String,
    profile_pic: json['profile_pic'] == null
        ? null
        : Profile.fromJson(json['profile_pic'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$PlayersToJson(Players instance) => <String, dynamic>{
      'id': instance.id,
      'first_name': instance.first_name,
      'last_name': instance.last_name,
      'email': instance.email,
      'contact_number': instance.contact_number,
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
