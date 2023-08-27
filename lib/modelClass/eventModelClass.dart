import 'package:json_annotation/json_annotation.dart';
part 'eventModelClass.g.dart';

@JsonSerializable(explicitToJson: true)
class Event {
  final User? user;
  final String? transactionId;
  final String? transactionMadeon;
  final EventType? event;
  final double? paidTotal;
  Event(
      {this.user,
      this.event,
      this.paidTotal,
      this.transactionId,
      this.transactionMadeon});

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);
  Map<String, dynamic> toJson() => _$EventToJson(this);
}

@JsonSerializable()
class User {
  final String? first_name;
  final String? last_name;
  User({this.first_name, this.last_name});
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}

@JsonSerializable()
class EventType {
  final String? name;
  final String? startDate;
  EventType({this.name, this.startDate});
  factory EventType.fromJson(Map<String, dynamic> json) =>
      _$EventTypeFromJson(json);
  Map<String, dynamic> toJson() => _$EventTypeToJson(this);
}
