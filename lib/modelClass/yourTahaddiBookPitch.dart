import 'package:json_annotation/json_annotation.dart';
part 'yourTahaddiBookPitch.g.dart';

@JsonSerializable()
class Files {
  final int? id;
  final String? filePath;
  final String? fileType;
  final String? created_at;
  final String? updated_at;
  Files(
      {this.id,
      this.filePath,
      this.fileType,
      this.created_at,
      this.updated_at});
  factory Files.fromJson(Map<String, dynamic> json) => _$FilesFromJson(json);
  Map<String, dynamic> toJson() => _$FilesToJson(this);
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
class YourTahaddiBookPitchDetail {
  final BookPitch? bookPitch;
  final List<BookingDetails?>? bookingDetails;

  YourTahaddiBookPitchDetail({this.bookPitch, this.bookingDetails});
  factory YourTahaddiBookPitchDetail.fromJson(Map<String, dynamic> json) =>
      _$YourTahaddiBookPitchDetailFromJson(json);
  Map<String, dynamic> toJson() => _$YourTahaddiBookPitchDetailToJson(this);
}

@JsonSerializable(explicitToJson: true)
class BookPitch {
  final int? id;
  final String? name;
  final String? country;
  final String? location;
  final int? currentYear;
  final int? currentMonth;
  final double? latitude;
  final double? longitude;
  final String? description;
  final OrganisedBy? organisedBy;
  final GamePlay? gamePlay;
  final String? link;
  final List<Facility?>? facilities;
  final BookPitchFiles? bookpitchfiles;
  final PaymentSummary? paymentSummary;

  BookPitch(
      {this.id,
      this.name,
      this.country,
      this.currentYear,
      this.currentMonth,
      this.location,
      this.latitude,
      this.longitude,
      this.description,
      this.organisedBy,
      this.bookpitchfiles,
      this.paymentSummary,
      this.facilities,
      this.gamePlay,
      this.link});

  factory BookPitch.fromJson(Map<String, dynamic> json) =>
      _$BookPitchFromJson(json);
  Map<String, dynamic> toJson() => _$BookPitchToJson(this);
}

@JsonSerializable(explicitToJson: true)
class BookPitchFiles {
  final int? id;
  final Files? files;
  final bool? is_active;
  BookPitchFiles({this.id, this.files, this.is_active});
  factory BookPitchFiles.fromJson(Map<String, dynamic> json) =>
      _$BookPitchFilesFromJson(json);
  Map<String, dynamic> toJson() => _$BookPitchFilesToJson(this);
}

@JsonSerializable()
class OrganisedBy {
  final int? id;
  final String? name;
  final String? email;
  final String? contact_number;
  final String? countryCode;
  final Rating? ratings;
  OrganisedBy(
      {this.id,
      this.name,
      this.email,
      this.contact_number,
      this.ratings,
      this.countryCode});
  factory OrganisedBy.fromJson(Map<String, dynamic> json) =>
      _$OrganisedByFromJson(json);
  Map<String, dynamic> toJson() => _$OrganisedByToJson(this);
}

@JsonSerializable(explicitToJson: true)
class BookingDetails {
  final PitchType? pitchType;
  final List<SlotDate?>? slotDate;
  final double? paidTotal;

  BookingDetails({this.paidTotal, this.pitchType, this.slotDate});
  factory BookingDetails.fromJson(Map<String, dynamic> json) =>
      _$BookingDetailsFromJson(json);
  Map<String, dynamic> toJson() => _$BookingDetailsToJson(this);
}

@JsonSerializable()
class PitchType {
  final int? id;
  final String? name;
  final String? area;

  PitchType({this.id, this.name, this.area});
  factory PitchType.fromJson(Map<String, dynamic> json) =>
      _$PitchTypeFromJson(json);
  Map<String, dynamic> toJson() => _$PitchTypeToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SlotDate {
  final List<Slot?>? slots;
  final String? date;
  SlotDate({this.slots, this.date});
  factory SlotDate.fromJson(Map<String, dynamic> json) =>
      _$SlotDateFromJson(json);
  Map<String, dynamic> toJson() => _$SlotDateToJson(this);
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

@JsonSerializable()
class GamePlay {
  final int? id;
  final String? name;

  GamePlay({
    this.id,
    this.name,
  });
  factory GamePlay.fromJson(Map<String, dynamic> json) =>
      _$GamePlayFromJson(json);
  Map<String, dynamic> toJson() => _$GamePlayToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Facility {
  final int? id;
  final String? name;
  final Images? image;

  Facility({this.id, this.name, this.image});
  factory Facility.fromJson(Map<String, dynamic> json) =>
      _$FacilityFromJson(json);
  Map<String, dynamic> toJson() => _$FacilityToJson(this);
}

@JsonSerializable()
class Images {
  final int? id;
  final String? filePath;

  Images({
    this.id,
    this.filePath,
  });
  factory Images.fromJson(Map<String, dynamic> json) => _$ImagesFromJson(json);
  Map<String, dynamic> toJson() => _$ImagesToJson(this);
}

@JsonSerializable()
class Rating {
  final String? rating;

  Rating({
    this.rating,
  });
  factory Rating.fromJson(Map<String, dynamic> json) => _$RatingFromJson(json);
  Map<String, dynamic> toJson() => _$RatingToJson(this);
}
