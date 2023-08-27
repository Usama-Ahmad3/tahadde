// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manageSlotModelClass.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ManageSlotModelClass _$ManageSlotModelClassFromJson(Map<String, dynamic> json) {
  return ManageSlotModelClass(
    pitchType: json['pitchType'] == null
        ? null
        : PitchType.fromJson(json['pitchType'] as Map<String, dynamic>),
    paidTotal: json['paidTotal'] as int,
    current_datetime: json['current_datetime'] as String,
    bookpitch: json['bookpitch'] == null
        ? null
        : Bookpitch.fromJson(json['bookpitch'] as Map<String, dynamic>),
    slots: (json['slots'] as List)
        ?.map(
            (e) => e == null ? null : Slot.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ManageSlotModelClassToJson(
        ManageSlotModelClass instance) =>
    <String, dynamic>{
      'bookpitch': instance.bookpitch?.toJson(),
      'pitchType': instance.pitchType?.toJson(),
      'current_datetime': instance.current_datetime,
      'slots': instance.slots?.map((e) => e?.toJson())?.toList(),
      'paidTotal': instance.paidTotal,
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

Bookpitch _$BookpitchFromJson(Map<String, dynamic> json) {
  return Bookpitch(
    id: json['id'] as int,
    name: json['name'] as String,
  );
}

Map<String, dynamic> _$BookpitchToJson(Bookpitch instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

Slot _$SlotFromJson(Map<String, dynamic> json) {
  return Slot(
    endTime: json['endTime'] as String,
    startTime: json['startTime'] as String,
    id: json['id'] as int,
    slot_not_available: json['slot_not_available'] as bool,
    is_booked: json['is_booked'] as bool,
  );
}

Map<String, dynamic> _$SlotToJson(Slot instance) => <String, dynamic>{
      'id': instance.id,
      'endTime': instance.endTime,
      'startTime': instance.startTime,
      'slot_not_available': instance.slot_not_available,
      'is_booked': instance.is_booked,
    };
