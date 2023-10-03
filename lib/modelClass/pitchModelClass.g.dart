// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pitchModelClass.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PitchHistory _$PitchHistoryFromJson(Map<String, dynamic> json) {
  return PitchHistory(
    user: json['user'] == null
        ? null
        : User.fromJson(json['user'] as Map<String, dynamic>),
    bookpitch: json['bookpitch'] == null
        ? null
        : EventType.fromJson(json['bookpitch'] as Map<String, dynamic>),
    paidTotal: (json['paidTotal'] as num).toDouble(),
    transactionId: json['transactionId'] as String,
    payment_id: json['payment_id'] as String,
    transactionMadeon: json['transactionMadeon'] as String,
    slotDate: json['slotDate'] as String,
    slots: json['slots'] == null
        ? null
        : Slots.fromJson(json['slots'] as Map<String, dynamic>),
    pitchType: json['pitchType'] == null
        ? null
        : PitchType.fromJson(json['pitchType'] as Map<String, dynamic>),
    booking_cancelled: json['booking_cancelled'] as bool,
  );
}

Map<String, dynamic> _$PitchHistoryToJson(PitchHistory instance) =>
    <String, dynamic>{
      'user': instance.user?.toJson(),
      'transactionId': instance.transactionId,
      'payment_id': instance.payment_id,
      'transactionMadeon': instance.transactionMadeon,
      'bookpitch': instance.bookpitch?.toJson(),
      'pitchType': instance.pitchType?.toJson(),
      'slotDate': instance.slotDate,
      'paidTotal': instance.paidTotal,
      'slots': instance.slots?.toJson(),
      'booking_cancelled': instance.booking_cancelled,
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

EventType _$EventTypeFromJson(Map<String, dynamic> json) {
  return EventType(
    name: json['name'] as String,
    id: json['id'] as int,
  );
}

Map<String, dynamic> _$EventTypeToJson(EventType instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

PitchType _$PitchTypeFromJson(Map<String, dynamic> json) {
  return PitchType(
    name: json['name'] as String,
  );
}

Map<String, dynamic> _$PitchTypeToJson(PitchType instance) => <String, dynamic>{
      'name': instance.name,
    };

Slots _$SlotsFromJson(Map<String, dynamic> json) {
  return Slots(
    booked_for_date: json['booked_for_date'] as String,
    booked_slots: (json['booked_slots'] as List)
        .map((e) =>
            e == null ? null : BookedSlots.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$SlotsToJson(Slots instance) => <String, dynamic>{
      'booked_for_date': instance.booked_for_date,
      'booked_slots': instance.booked_slots?.map((e) => e?.toJson()).toList(),
    };

BookedSlots _$BookedSlotsFromJson(Map<String, dynamic> json) {
  return BookedSlots(
    startTime: json['startTime'] as String,
    endTime: json['endTime'] as String,
  );
}

Map<String, dynamic> _$BookedSlotsToJson(BookedSlots instance) =>
    <String, dynamic>{
      'startTime': instance.startTime,
      'endTime': instance.endTime,
    };
