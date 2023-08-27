// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'yourTahaddiBookPitch.dart';

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

YourTahaddiBookPitchDetail _$YourTahaddiBookPitchDetailFromJson(
    Map<String, dynamic> json) {
  return YourTahaddiBookPitchDetail(
    bookPitch: json['bookPitch'] == null
        ? null
        : BookPitch.fromJson(json['bookPitch'] as Map<String, dynamic>),
    bookingDetails: (json['bookingDetails'] as List)
        ?.map((e) => e == null
            ? null
            : BookingDetails.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$YourTahaddiBookPitchDetailToJson(
        YourTahaddiBookPitchDetail instance) =>
    <String, dynamic>{
      'bookPitch': instance.bookPitch?.toJson(),
      'bookingDetails':
          instance.bookingDetails?.map((e) => e?.toJson())?.toList(),
    };

BookPitch _$BookPitchFromJson(Map<String, dynamic> json) {
  return BookPitch(
    id: json['id'] as int,
    name: json['name'] as String,
    country: json['country'] as String,
    currentYear: json['currentYear'] as int,
    currentMonth: json['currentMonth'] as int,
    location: json['location'] as String,
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
    paymentSummary: json['paymentSummary'] == null
        ? null
        : PaymentSummary.fromJson(
            json['paymentSummary'] as Map<String, dynamic>),
    facilities: (json['facilities'] as List)
        ?.map((e) =>
            e == null ? null : Facility.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    gamePlay: json['gamePlay'] == null
        ? null
        : GamePlay.fromJson(json['gamePlay'] as Map<String, dynamic>),
    link: json['link'] as String,
  );
}

Map<String, dynamic> _$BookPitchToJson(BookPitch instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'country': instance.country,
      'location': instance.location,
      'currentYear': instance.currentYear,
      'currentMonth': instance.currentMonth,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'description': instance.description,
      'organisedBy': instance.organisedBy?.toJson(),
      'gamePlay': instance.gamePlay?.toJson(),
      'link': instance.link,
      'facilities': instance.facilities?.map((e) => e?.toJson())?.toList(),
      'bookpitchfiles': instance.bookpitchfiles?.toJson(),
      'paymentSummary': instance.paymentSummary?.toJson(),
    };

BookPitchFiles _$BookPitchFilesFromJson(Map<String, dynamic> json) {
  return BookPitchFiles(
    id: json['id'] as int,
    files: json['files'] == null
        ? null
        : Files.fromJson(json['files'] as Map<String, dynamic>),
    is_active: json['is_active'] as bool,
  );
}

Map<String, dynamic> _$BookPitchFilesToJson(BookPitchFiles instance) =>
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
      'ratings': instance.ratings,
    };

BookingDetails _$BookingDetailsFromJson(Map<String, dynamic> json) {
  return BookingDetails(
    paidTotal: (json['paidTotal'] as num)?.toDouble(),
    pitchType: json['pitchType'] == null
        ? null
        : PitchType.fromJson(json['pitchType'] as Map<String, dynamic>),
    slotDate: (json['slotDate'] as List)
        ?.map((e) =>
            e == null ? null : SlotDate.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$BookingDetailsToJson(BookingDetails instance) =>
    <String, dynamic>{
      'pitchType': instance.pitchType?.toJson(),
      'slotDate': instance.slotDate?.map((e) => e?.toJson())?.toList(),
      'paidTotal': instance.paidTotal,
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

SlotDate _$SlotDateFromJson(Map<String, dynamic> json) {
  return SlotDate(
    slots: (json['slots'] as List)
        ?.map(
            (e) => e == null ? null : Slot.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    date: json['date'] as String,
  );
}

Map<String, dynamic> _$SlotDateToJson(SlotDate instance) => <String, dynamic>{
      'slots': instance.slots?.map((e) => e?.toJson())?.toList(),
      'date': instance.date,
    };

Slot _$SlotFromJson(Map<String, dynamic> json) {
  return Slot(
    endTime: json['endTime'] as String,
    startTime: json['startTime'] as String,
  );
}

Map<String, dynamic> _$SlotToJson(Slot instance) => <String, dynamic>{
      'endTime': instance.endTime,
      'startTime': instance.startTime,
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
    rating: json['rating'] as String,
  );
}

Map<String, dynamic> _$RatingToJson(Rating instance) => <String, dynamic>{
      'rating': instance.rating,
    };
