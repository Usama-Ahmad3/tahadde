import 'package:json_annotation/json_annotation.dart';
part 'bookingModelClass.g.dart';

@JsonSerializable(explicitToJson: true)
class BookingModelClass {
  final int? id;
  final User? user;

  final String? transactionId;
  final PitchType? pitchType;
  final BookedSlots? slots;
  final double? paidTotal;
  final String? location;
  final String? slotDate;
  final bool? booking_cancelled;
  BookingModelClass(
      {this.id,
      this.pitchType,
      this.slotDate,
      this.paidTotal,
      this.slots,
      this.transactionId,
      this.user,
      this.location,
      this.booking_cancelled});
  factory BookingModelClass.fromJson(Map<String, dynamic> json) =>
      _$BookingModelClassFromJson(json);
  Map<String, dynamic> toJson() => _$BookingModelClassToJson(this);
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

@JsonSerializable(explicitToJson: true)
class User {
  final String? email;
  final String? contact_number;
  final String? countryCode;
  final String? name;
  final Profile? profile_pic;

  User(
      {this.name,
      this.contact_number,
      this.email,
      this.profile_pic,
      this.countryCode});
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}

@JsonSerializable()
class Slot {
  final String? endTime;
  final String? startTime;

  Slot({
    this.endTime,
    this.startTime,
  });
  factory Slot.fromJson(Map<String, dynamic> json) => _$SlotFromJson(json);
  Map<String, dynamic> toJson() => _$SlotToJson(this);
}
@JsonSerializable(explicitToJson: true)
class BookedSlots {
  final List<Slot?>? booked_slots;
  BookedSlots({
    this.booked_slots,
  });
  factory BookedSlots.fromJson(Map<String, dynamic> json) => _$BookedSlotsFromJson(json);
  Map<String, dynamic> toJson() => _$BookedSlotsToJson(this);
}
@JsonSerializable()
class Profile {
  final String? filePath;

  Profile({
    this.filePath,
  });
  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileToJson(this);
}
