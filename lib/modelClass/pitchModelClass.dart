import 'package:json_annotation/json_annotation.dart';
part 'pitchModelClass.g.dart';

@JsonSerializable(explicitToJson: true)
class PitchHistory {
  final User? user;
  final String? transactionId;
  final String? payment_id;
  final String? transactionMadeon;
  final EventType? bookpitch;
  final PitchType? pitchType;
  final String? slotDate;
  final double? paidTotal;
  final Slots? slots;
  final bool? booking_cancelled;
  PitchHistory(
      {this.user,
      this.bookpitch,
      this.paidTotal,
      this.transactionId,
        this.payment_id,
      this.transactionMadeon,
      this.slotDate,
      this.slots,
      this.pitchType,this.booking_cancelled});

  factory PitchHistory.fromJson(Map<String, dynamic> json) =>
      _$PitchHistoryFromJson(json);
  Map<String, dynamic> toJson() => _$PitchHistoryToJson(this);
}

@JsonSerializable()
class User {
  final String? first_name;
  final String? last_name;
  User({this.first_name, this.last_name});
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}

@JsonSerializable(explicitToJson: true)
class EventType {
  final int? id;
  final String? name;

  EventType({this.name, this.id});
  factory EventType.fromJson(Map<String, dynamic> json) =>
      _$EventTypeFromJson(json);
  Map<String, dynamic> toJson() => _$EventTypeToJson(this);
}

@JsonSerializable()
class PitchType {
  final String? name;
  PitchType({this.name});
  factory PitchType.fromJson(Map<String, dynamic> json) =>
      _$PitchTypeFromJson(json);
  Map<String, dynamic> toJson() => _$PitchTypeToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Slots {
  final String? booked_for_date;
  final List<BookedSlots?>? booked_slots;
  Slots({this.booked_for_date, this.booked_slots});
  factory Slots.fromJson(Map<String, dynamic> json) => _$SlotsFromJson(json);
  Map<String, dynamic> toJson() => _$SlotsToJson(this);
}

@JsonSerializable(explicitToJson: true)
class BookedSlots {
  final String? startTime;
  final String? endTime;
  BookedSlots({this.startTime,this.endTime});
  factory BookedSlots.fromJson(Map<String, dynamic> json) => _$BookedSlotsFromJson(json);
  Map<String, dynamic> toJson() => _$BookedSlotsToJson(this);
}