// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookingModelClass.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookingModelClass _$BookingModelClassFromJson(Map<String, dynamic> json) {
  return BookingModelClass(
    id: json['id'] as int,
    pitchType: json['pitchType'] == null
        ? null
        : PitchType.fromJson(json['pitchType'] as Map<String, dynamic>),
    slotDate: json['slotDate'] as String,
    paidTotal: (json['paidTotal'] as num).toDouble(),
    slots: json['slots'] == null
        ? null
        : BookedSlots.fromJson(json['slots'] as Map<String, dynamic>),
    transactionId: json['transactionId'] as String,
    user: json['user'] == null
        ? null
        : User.fromJson(json['user'] as Map<String, dynamic>),
    location: json['location'] as String,
    booking_cancelled: json['booking_cancelled'] as bool,
  );
}

Map<String, dynamic> _$BookingModelClassToJson(BookingModelClass instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user': instance.user?.toJson(),
      'transactionId': instance.transactionId,
      'pitchType': instance.pitchType?.toJson(),
      'slots': instance.slots?.toJson(),
      'paidTotal': instance.paidTotal,
      'location': instance.location,
      'slotDate': instance.slotDate,
      'booking_cancelled': instance.booking_cancelled,
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

PaymentSummary _$PaymentSummaryFromJson(Map<String, dynamic> json) {
  return PaymentSummary(
    id: json['id'] as int,
    name: json['name'] as String,
    grandTotal: (json['grandTotal'] as num).toDouble(),
    tax: (json['tax'] as num).toDouble(),
    subTotal: (json['subTotal'] as num).toDouble(),
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

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    name: json['name'] as String,
    contact_number: json['contact_number'] as String,
    email: json['email'] as String,
    profile_pic: json['profile_pic'] == null
        ? null
        : Profile.fromJson(json['profile_pic'] as Map<String, dynamic>),
    countryCode: json['countryCode'] as String,
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'email': instance.email,
      'contact_number': instance.contact_number,
      'countryCode': instance.countryCode,
      'name': instance.name,
      'profile_pic': instance.profile_pic?.toJson(),
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

BookedSlots _$BookedSlotsFromJson(Map<String, dynamic> json) {
  return BookedSlots(
    booked_slots: (json['booked_slots'] as List).map(
            (e) => e == null ? null : Slot.fromJson(e as Map<String, dynamic>)).toList(),
  );
}

Map<String, dynamic> _$BookedSlotsToJson(BookedSlots instance) =>
    <String, dynamic>{
      'booked_slots': instance.booked_slots?.map((e) => e?.toJson()).toList(),
    };

Profile _$ProfileFromJson(Map<String, dynamic> json) {
  return Profile(
    filePath: json['filePath'] as String,
  );
}

Map<String, dynamic> _$ProfileToJson(Profile instance) => <String, dynamic>{
      'filePath': instance.filePath,
    };
