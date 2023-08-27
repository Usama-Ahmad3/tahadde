import 'package:json_annotation/json_annotation.dart';
part 'manageSlotModelClass.g.dart';

@JsonSerializable(explicitToJson: true)
class ManageSlotModelClass {
  final Bookpitch? bookpitch;
  final PitchType? pitchType;
  final String? current_datetime;
  final List<Slot?>? slots;

  final int? paidTotal;
  ManageSlotModelClass(
      {this.pitchType,
      this.paidTotal,
      this.current_datetime,
      this.bookpitch,
      this.slots});
  factory ManageSlotModelClass.fromJson(Map<String, dynamic> json) =>
      _$ManageSlotModelClassFromJson(json);
  Map<String, dynamic> toJson() => _$ManageSlotModelClassToJson(this);
}

@JsonSerializable(explicitToJson: true)
class PitchType {
  final int? id;
  final String? name;
  final String? area;
  final PaymentSummary? paymentSummary;

  PitchType({this.id, this.name, this.area, this.paymentSummary});
  factory PitchType.fromJson(Map<String, dynamic> json) =>
      _$PitchTypeFromJson(json);
  Map<String, dynamic> toJson() => _$PitchTypeToJson(this);
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

@JsonSerializable()
class Bookpitch {
  final int? id;
  final String? name;
  Bookpitch({
    this.id,
    this.name,
  });
  factory Bookpitch.fromJson(Map<String, dynamic> json) =>
      _$BookpitchFromJson(json);
  Map<String, dynamic> toJson() => _$BookpitchToJson(this);
}

@JsonSerializable()
class Slot {
  final int? id;
  final String? endTime;
  final String? startTime;
  final bool? slot_not_available;
  final bool? is_booked;

  Slot(
      {this.endTime,
      this.startTime,
      this.id,
      this.slot_not_available,
      this.is_booked});
  factory Slot.fromJson(Map<String, dynamic> json) => _$SlotFromJson(json);
  Map<String, dynamic> toJson() => _$SlotToJson(this);
}
