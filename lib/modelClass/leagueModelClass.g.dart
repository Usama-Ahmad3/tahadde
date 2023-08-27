// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leagueModelClass.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Files _$FilesFromJson(Map<String, dynamic> json) {
  return Files(
    id: json['id'] as int,
    filePath: json['filePath'] as String,
    fileType: json['fileType'] as String,
    created_at: json['created_at'] as String,
    updated_at: json['updated_at'] as String,
  );
}

Map<String, dynamic> _$FilesToJson(Files instance) => <String, dynamic>{
      'id': instance.id,
      'filePath': instance.filePath,
      'fileType': instance.fileType,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
    };

League _$LeagueFromJson(Map<String, dynamic> json) {
  return League(
    id: json['id'] as int,
    country: json['country'] as String,
    name: json['name'] as String,
    location: json['location'] as String,
    pitchType: json['pitchType'] == null
        ? null
        : PitchType.fromJson(json['pitchType'] as Map<String, dynamic>),
    latitude: (json['latitude'] as num)?.toDouble(),
    longitude: (json['longitude'] as num)?.toDouble(),
    description: json['description'] as String,
    startDate: json['startDate'] as String,
    endDate: json['endDate'] as String,
    bookingLastDate: json['bookingLastDate'] as String,
    paymentSummary: json['paymentSummary'] == null
        ? null
        : PaymentSummary.fromJson(
            json['paymentSummary'] as Map<String, dynamic>),
    organisedBy: json['organisedBy'] == null
        ? null
        : OrganisedBy.fromJson(json['organisedBy'] as Map<String, dynamic>),
    leaguefiles: json['leaguefiles'] == null
        ? null
        : LeagueFiles.fromJson(json['leaguefiles'] as Map<String, dynamic>),
    leagueLogo: json['leagueLogo'] == null
        ? null
        : LeagueLogo.fromJson(json['leagueLogo'] as Map<String, dynamic>),
    facilities: (json['facilities'] as List)
        ?.map((e) =>
            e == null ? null : Facility.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    link: json['link'] as String,
    registeredTeam: (json['registeredTeam'] as List)
        ?.map((e) => e == null
            ? null
            : RegisteredTeam.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    gamePlay: json['gamePlay'] == null
        ? null
        : GamePlay.fromJson(json['gamePlay'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$LeagueToJson(League instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'country': instance.country,
      'location': instance.location,
      'pitchType': instance.pitchType?.toJson(),
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'description': instance.description,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'bookingLastDate': instance.bookingLastDate,
      'paymentSummary': instance.paymentSummary?.toJson(),
      'organisedBy': instance.organisedBy?.toJson(),
      'leaguefiles': instance.leaguefiles?.toJson(),
      'leagueLogo': instance.leagueLogo?.toJson(),
      'facilities': instance.facilities?.map((e) => e?.toJson())?.toList(),
      'gamePlay': instance.gamePlay?.toJson(),
      'link': instance.link,
      'registeredTeam':
          instance.registeredTeam?.map((e) => e?.toJson())?.toList(),
    };

LeagueFiles _$LeagueFilesFromJson(Map<String, dynamic> json) {
  return LeagueFiles(
    id: json['id'] as int,
    files: json['files'] == null
        ? null
        : Files.fromJson(json['files'] as Map<String, dynamic>),
    is_active: json['is_active'] as bool,
  );
}

Map<String, dynamic> _$LeagueFilesToJson(LeagueFiles instance) =>
    <String, dynamic>{
      'id': instance.id,
      'files': instance.files?.toJson(),
      'is_active': instance.is_active,
    };

OrganisedBy _$OrganisedByFromJson(Map<String, dynamic> json) {
  return OrganisedBy(
    id: json['id'] as int,
    name: json['name'] as String,
    email: json['email'] as String,
    contact_number: json['contact_number'] as String,
    countryCode: json['countryCode'] as String,
    ratings: json['ratings'] == null
        ? null
        : Rating.fromJson(json['ratings'] as Map<String, dynamic>),
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
  );
}

Map<String, dynamic> _$PitchTypeToJson(PitchType instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

Rating _$RatingFromJson(Map<String, dynamic> json) {
  return Rating(
    rating: json['rating'] as String,
  );
}

Map<String, dynamic> _$RatingToJson(Rating instance) => <String, dynamic>{
      'rating': instance.rating,
    };

PaymentSummary _$PaymentSummaryFromJson(Map<String, dynamic> json) {
  return PaymentSummary(
    id: json['id'] as int,
    name: json['name'] as String,
    grandTotal: (json['grandTotal'] as num)?.toDouble(),
    tax: (json['tax'] as num)?.toDouble(),
    subTotal: (json['subTotal'] as num)?.toDouble(),
    paymentFor: json['paymentFor'] as String,
  );
}

Map<String, dynamic> _$PaymentSummaryToJson(PaymentSummary instance) =>
    <String, dynamic>{
      'id': instance.id,
      'paymentFor': instance.paymentFor,
      'name': instance.name,
      'subTotal': instance.subTotal,
      'tax': instance.tax,
      'grandTotal': instance.grandTotal,
    };

LeagueLogo _$LeagueLogoFromJson(Map<String, dynamic> json) {
  return LeagueLogo(
    filePath: json['filePath'] as String,
  );
}

Map<String, dynamic> _$LeagueLogoToJson(LeagueLogo instance) =>
    <String, dynamic>{
      'filePath': instance.filePath,
    };

GamePlay _$GamePlayFromJson(Map<String, dynamic> json) {
  return GamePlay(
    id: json['id'] as int,
    name: json['name'] as String,
  );
}

Map<String, dynamic> _$GamePlayToJson(GamePlay instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

Facility _$FacilityFromJson(Map<String, dynamic> json) {
  return Facility(
    id: json['id'] as int,
    name: json['name'] as String,
    image: json['image'] == null
        ? null
        : Images.fromJson(json['image'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$FacilityToJson(Facility instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image': instance.image?.toJson(),
    };

Images _$ImagesFromJson(Map<String, dynamic> json) {
  return Images(
    id: json['id'] as int,
    filePath: json['filePath'] as String,
  );
}

Map<String, dynamic> _$ImagesToJson(Images instance) => <String, dynamic>{
      'id': instance.id,
      'filePath': instance.filePath,
    };

RegisteredTeam _$RegisteredTeamFromJson(Map<String, dynamic> json) {
  return RegisteredTeam(
    user: json['user'] == null
        ? null
        : User.fromJson(json['user'] as Map<String, dynamic>),
    team: json['team'] == null
        ? null
        : Team.fromJson(json['team'] as Map<String, dynamic>),
    paidTotal: (json['paidTotal'] as num)?.toDouble(),
    transactionId: json['transactionId'] as String,
  );
}

Map<String, dynamic> _$RegisteredTeamToJson(RegisteredTeam instance) =>
    <String, dynamic>{
      'user': instance.user?.toJson(),
      'transactionId': instance.transactionId,
      'paidTotal': instance.paidTotal,
      'team': instance.team?.toJson(),
    };

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    first_name: json['first_name'] as String,
    last_name: json['last_name'] as String,
    profile_pic: json['profile_pic'] == null
        ? null
        : Profile.fromJson(json['profile_pic'] as Map<String, dynamic>),
    email: json['email'] as String,
    contact_number: json['contact_number'] as String,
    countryCode: json['countryCode'] as String,
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'first_name': instance.first_name,
      'last_name': instance.last_name,
      'email': instance.email,
      'contact_number': instance.contact_number,
      'countryCode': instance.countryCode,
      'profile_pic': instance.profile_pic?.toJson(),
    };

Team _$TeamFromJson(Map<String, dynamic> json) {
  return Team(
    is_external: json['is_external'] as bool,
    teamName: json['teamName'] as String,
    teamLogo: json['teamLogo'] == null
        ? null
        : Logo.fromJson(json['teamLogo'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$TeamToJson(Team instance) => <String, dynamic>{
      'teamName': instance.teamName,
      'is_external': instance.is_external,
      'teamLogo': instance.teamLogo?.toJson(),
    };

Profile _$ProfileFromJson(Map<String, dynamic> json) {
  return Profile(
    filePath: json['filePath'] as String,
  );
}

Map<String, dynamic> _$ProfileToJson(Profile instance) => <String, dynamic>{
      'filePath': instance.filePath,
    };

Logo _$LogoFromJson(Map<String, dynamic> json) {
  return Logo(
    filePath: json['filePath'] as String,
  );
}

Map<String, dynamic> _$LogoToJson(Logo instance) => <String, dynamic>{
      'filePath': instance.filePath,
    };
