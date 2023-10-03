// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookPitchSlotModelClass.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookPitchSlot _$BookPitchSlotFromJson(Map<String, dynamic> json) {
  return BookPitchSlot(
    year: json['year'] as int,
    months: (json['months'] as List)
        .map((e) =>
            e == null ? null : Months.fromJson(e as Map<String, dynamic>))
        .toList(),
    pitchType: json['pitchType'] == null
        ? null
        : PitchType.fromJson(json['pitchType'] as Map<String, dynamic>),
    current_datetime: json['current_datetime'] as String,
  );
}

Map<String, dynamic> _$BookPitchSlotToJson(BookPitchSlot instance) =>
    <String, dynamic>{
      'year': instance.year,
      'pitchType': instance.pitchType?.toJson(),
      'months': instance.months?.map((e) => e?.toJson()).toList(),
      'current_datetime': instance.current_datetime,
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

Months _$MonthsFromJson(Map<String, dynamic> json) {
  return Months(
    id: json['id'] as int,
    days: (json['days'] as List)
        .map(
            (e) => e == null ? null : Days.fromJson(e as Map<String, dynamic>))
        .toList(),
    monthNumber: json['monthNumber'] as int,
  );
}

Map<String, dynamic> _$MonthsToJson(Months instance) => <String, dynamic>{
      'id': instance.id,
      'monthNumber': instance.monthNumber,
      'days': instance.days?.map((e) => e?.toJson()).toList(),
    };

Days _$DaysFromJson(Map<String, dynamic> json) {
  return Days(
    id: json['id'] as int,
    dayNumber: json['dayNumber'] as int,
    slots: (json['slots'] as List)
        .map(
            (e) => e == null ? null : Slots.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$DaysToJson(Days instance) => <String, dynamic>{
      'id': instance.id,
      'dayNumber': instance.dayNumber,
      'slots': instance.slots?.map((e) => e?.toJson()).toList(),
    };

Slots _$SlotsFromJson(Map<String, dynamic> json) {
  return Slots(
    id: json['id'] as int,
    is_booked: json['is_booked'] as bool,
    slot_not_available: json['slot_not_available'] as bool,
    endTime: json['endTime'] as String,
    startTime: json['startTime'] as String,
    updated_at: json['updated_at'] as String,
    created_at: json['created_at'] as String,
  );
}

Map<String, dynamic> _$SlotsToJson(Slots instance) => <String, dynamic>{
      'id': instance.id,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'slot_not_available': instance.slot_not_available,
      'is_booked': instance.is_booked,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
    };

PitchType _$PitchTypeFromJson(Map<String, dynamic> json) {
  return PitchType(
    name: json['name'] as String,
    paymentSummary: json['paymentSummary'] == null
        ? null
        : PaymentSummary.fromJson(
            json['paymentSummary'] as Map<String, dynamic>),
    id: json['id'] as int,
    area: json['area'] as String,
  );
}

Map<String, dynamic> _$PitchTypeToJson(PitchType instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'area': instance.area,
      'paymentSummary': instance.paymentSummary?.toJson(),
    };
