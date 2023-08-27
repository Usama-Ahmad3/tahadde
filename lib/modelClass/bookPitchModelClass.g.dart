// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookPitchModelClass.dart';

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

PaymentSummary _$PaymentSummaryFromJson(Map<String, dynamic> json) {
  return PaymentSummary(
    id: json['id'] as int,
    name: json['name'] as String,
    grandTotal: (json['grandTotal'] as num)!.toDouble(),
    tax: (json['tax'] as num)!.toDouble(),
    subTotal: (json['subTotal'] as num)!.toDouble(),
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

BookPitchDetail _$BookPitchDetailFromJson(Map<String, dynamic> json) {
  return BookPitchDetail(
    id: json['id'] as int,
    country: json['country'] as String,
    name: json['name'] as String,
    location: json['location'] as String,
    pitchType: (json['pitchType'] as List)
        ?.map((e) =>
            e == null ? null : PitchType.fromJson(e as Map<String, dynamic>))
        !.toList(),
    latitude: (json['latitude'] as num)?.toDouble(),
    longitude: (json['longitude'] as num)?.toDouble(),
    description: json['description'] as String,
    organisedBy: json['organisedBy'] == null
        ? null
        : OrganisedBy.fromJson(json['organisedBy'] as Map<String, dynamic>),
    bookpitchfiles: json['bookpitchfiles'] == null
        ? null
        : BookPitchFiles.fromJson(
            json['bookpitchfiles'] as Map<String, dynamic>),
    currentMonth: json['currentMonth'] as int,
    currentYear: json['currentYear'] as int,
    gamePlay: json['gamePlay'] == null
        ? null
        : GamePlay.fromJson(json['gamePlay'] as Map<String, dynamic>),
    link: json['link'] as String,
    facilities: (json['facilities'] as List)
        ?.map((e) =>
            e == null ? null : Facility.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    createdDate: json['createdDate'] as int,
    is_declined: json['is_declined'] as bool,
    is_verified: json['is_verified'] as bool,
    my_favourite: json['my_favourite'] as bool,
  );
}

Map<String, dynamic> _$BookPitchDetailToJson(BookPitchDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'country': instance.country,
      'my_favourite': instance.my_favourite,
      'name': instance.name,
      'currentYear': instance.currentYear,
      'currentMonth': instance.currentMonth,
      'location': instance.location,
      'pitchType': instance.pitchType?.map((e) => e?.toJson())?.toList(),
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'is_verified': instance.is_verified,
      'is_declined': instance.is_declined,
      'createdDate': instance.createdDate,
      'description': instance.description,
      'organisedBy': instance.organisedBy?.toJson(),
      'bookpitchfiles': instance.bookpitchfiles?.toJson(),
      'gamePlay': instance.gamePlay?.toJson(),
      'link': instance.link,
      'facilities': instance.facilities?.map((e) => e?.toJson())?.toList(),
    };

BookPitchFiles _$BookPitchFilesFromJson(Map<String, dynamic> json) {
  return BookPitchFiles(
    id: json['id'] as int,
    files: (json['files'] as List)
        ?.map(
            (e) => e == null ? null : Files.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    is_active: json['is_active'] as bool,
    document: json['document'] == null
        ? null
        : Document.fromJson(json['document'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$BookPitchFilesToJson(BookPitchFiles instance) =>
    <String, dynamic>{
      'id': instance.id,
      'files': instance.files?.map((e) => e?.toJson())?.toList(),
      'is_active': instance.is_active,
      'document': instance.document?.toJson(),
    };

OrganisedBy _$OrganisedByFromJson(Map<String, dynamic> json) {
  return OrganisedBy(
    id: json['id'] as int,
    name: json['name'] as String,
    email: json['email'] as String,
    contact_number: json['contact_number'] as String,
    countryCode: json['countryCode'] as String,
    userReviews: (json['userReviews'] as List)
        ?.map((e) =>
            e == null ? null : Reviews.fromJson(e as Map<String, dynamic>))
        ?.toList(),
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
      'userReviews': instance.userReviews?.map((e) => e?.toJson())?.toList(),
    };

PitchType _$PitchTypeFromJson(Map<String, dynamic> json) {
  return PitchType(
    id: json['id'] as int,
    name: json['name'] as String,
    area: json['area'] as String,
    paymentSummary: json['paymentSummary'] == null
        ? null
        : PaymentSummary.fromJson(
            json['paymentSummary'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$PitchTypeToJson(PitchType instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'area': instance.area,
      'paymentSummary': instance.paymentSummary?.toJson(),
    };

Document _$DocumentFromJson(Map<String, dynamic> json) {
  return Document(
    id: json['id'] as int,
    filePath: json['filePath'] as String,
    fileOf: json['fileOf'] as String,
  );
}

Map<String, dynamic> _$DocumentToJson(Document instance) => <String, dynamic>{
      'id': instance.id,
      'fileOf': instance.fileOf,
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

Rating _$RatingFromJson(Map<String, dynamic> json) {
  return Rating(
    ratingsAvg: (json['ratingsAvg'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$RatingToJson(Rating instance) => <String, dynamic>{
      'ratingsAvg': instance.ratingsAvg,
    };

Reviews _$ReviewsFromJson(Map<String, dynamic> json) {
  return Reviews(
    user: json['user'] == null
        ? null
        : User.fromJson(json['user'] as Map<String, dynamic>),
    review: json['review'] as String,
    created_at: json['created_at'] as String,
  );
}

Map<String, dynamic> _$ReviewsToJson(Reviews instance) => <String, dynamic>{
      'user': instance.user?.toJson(),
      'review': instance.review,
      'created_at': instance.created_at,
    };

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    first_name: json['first_name'] as String,
    last_name: json['last_name'] as String,
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'first_name': instance.first_name,
      'last_name': instance.last_name,
    };
