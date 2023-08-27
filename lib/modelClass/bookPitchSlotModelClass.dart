import 'package:json_annotation/json_annotation.dart';
part 'bookPitchSlotModelClass.g.dart';

@JsonSerializable(explicitToJson: true)
class BookPitchSlot {
  final int? year;
  final PitchType? pitchType;
  final List<Months?>? months;
  final String? current_datetime;
  BookPitchSlot(
      {this.year, this.months, this.pitchType, this.current_datetime});
  factory BookPitchSlot.fromJson(Map<String, dynamic> json) =>
      _$BookPitchSlotFromJson(json);
  Map<String, dynamic> toJson() => _$BookPitchSlotToJson(this);
}

@JsonSerializable()
class PaymentSummary {
  final int? id;
  final String? paymentFor;
  final String? name;
  final double? subTotal;
  final double? tax;
  final double? grandTotal;

  PaymentSummary(
      {this.id,
      this.name,
      this.grandTotal,
      this.tax,
      this.subTotal,
      this.paymentFor});
  factory PaymentSummary.fromJson(Map<String, dynamic> json) =>
      _$PaymentSummaryFromJson(json);
  Map<String, dynamic> toJson() => _$PaymentSummaryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Months {
  final int? id;
  final int? monthNumber;
  final List<Days?>? days;
  Months({this.id, this.days, this.monthNumber});
  factory Months.fromJson(Map<String, dynamic> json) => _$MonthsFromJson(json);
  Map<String, dynamic> toJson() => _$MonthsToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Days {
  final int? id;
  final int? dayNumber;
  final List<Slots?>? slots;
  Days({this.id, this.dayNumber, this.slots});
  factory Days.fromJson(Map<String, dynamic> json) => _$DaysFromJson(json);
  Map<String, dynamic> toJson() => _$DaysToJson(this);
}

@JsonSerializable()
class Slots {
  final int? id;
  final String? startTime;
  final String? endTime;
  final bool? slot_not_available;
  final bool? is_booked;
  final String? created_at;
  final String? updated_at;

  Slots(
      {this.id,
      this.is_booked,
      this.slot_not_available,
      this.endTime,
      this.startTime,
      this.updated_at,
      this.created_at});
  factory Slots.fromJson(Map<String, dynamic> json) => _$SlotsFromJson(json);
  Map<String, dynamic> toJson() => _$SlotsToJson(this);
}

@JsonSerializable(explicitToJson: true)
class PitchType {
  final int? id;
  final String? name;
  final String? area;
  final PaymentSummary? paymentSummary;

  PitchType({this.name, this.paymentSummary, this.id, this.area});

  factory PitchType.fromJson(Map<String, dynamic> json) =>
      _$PitchTypeFromJson(json);
  Map<String, dynamic> toJson() => _$PitchTypeToJson(this);
}
