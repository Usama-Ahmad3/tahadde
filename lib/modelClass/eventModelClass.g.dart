// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'eventModelClass.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Event _$EventFromJson(Map<String, dynamic> json) {
  return Event(
    user: json['user'] == null
        ? null
        : User.fromJson(json['user'] as Map<String, dynamic>),
    event: json['event'] == null
        ? null
        : EventType.fromJson(json['event'] as Map<String, dynamic>),
    paidTotal: (json['paidTotal'] as num)?.toDouble(),
    transactionId: json['transactionId'] as String,
    transactionMadeon: json['transactionMadeon'] as String,
  );
}

Map<String, dynamic> _$EventToJson(Event instance) => <String, dynamic>{
      'user': instance.user?.toJson(),
      'transactionId': instance.transactionId,
      'transactionMadeon': instance.transactionMadeon,
      'event': instance.event?.toJson(),
      'paidTotal': instance.paidTotal,
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
    startDate: json['startDate'] as String,
  );
}

Map<String, dynamic> _$EventTypeToJson(EventType instance) => <String, dynamic>{
      'name': instance.name,
      'startDate': instance.startDate,
    };
