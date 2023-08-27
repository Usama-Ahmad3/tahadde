import 'package:json_annotation/json_annotation.dart';
part 'bookPitchModelClass.g.dart';

@JsonSerializable()
class Files {
  final int id;
  final String filePath;
  final String fileType;
  final String created_at;
  final String updated_at;
  Files(
      {required this.id,
      required this.filePath,
      required this.fileType,
      required this.created_at,
      required this.updated_at});
  factory Files.fromJson(Map<String, dynamic> json) => _$FilesFromJson(json);
  Map<String, dynamic> toJson() => _$FilesToJson(this);
}

@JsonSerializable()
class PaymentSummary {
  final int id;
  final String paymentFor;
  final String name;
  final double subTotal;
  final double tax;
  final double grandTotal;

  PaymentSummary(
      {required this.id,
      required this.name,
      required this.grandTotal,
      required this.tax,
      required this.subTotal,
      required this.paymentFor});
  factory PaymentSummary.fromJson(Map<String, dynamic> json) =>
      _$PaymentSummaryFromJson(json);
  Map<String, dynamic> toJson() => _$PaymentSummaryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class BookPitchDetail {
  final int? id;
  final String? country;
  final bool? my_favourite;
  final String? name;
  final int? currentYear;
  final int? currentMonth;
  final String? location;
  final List<PitchType?>? pitchType;
  final double? latitude;
  final double? longitude;
  final bool? is_verified;
  final bool? is_declined;
  final int? createdDate;

  final String? description;
  final OrganisedBy? organisedBy;
  final BookPitchFiles? bookpitchfiles;

  final GamePlay? gamePlay;
  final String? link;
  final List<Facility?>? facilities;

  BookPitchDetail(
      { this.id,
       this.country,
       this.name,
       this.location,
      this.pitchType,
       this.latitude,
       this.longitude,
       this.description,
       this.organisedBy,
       this.bookpitchfiles,
       this.currentMonth,
       this.currentYear,
       this.gamePlay,
       this.link,
      this.facilities,
       this.createdDate,
       this.is_declined,
       this.is_verified,
       this.my_favourite});

  factory BookPitchDetail.fromJson(Map<String, dynamic> json) =>
      _$BookPitchDetailFromJson(json);
  Map<String, dynamic> toJson() => _$BookPitchDetailToJson(this);
}

@JsonSerializable(explicitToJson: true)
class BookPitchFiles {
  final int? id;
  final List<Files?>? files;
  final bool? is_active;
  final Document? document;

  BookPitchFiles({this.id, this.files, this.is_active, this.document});
  factory BookPitchFiles.fromJson(Map<String, dynamic> json) =>
      _$BookPitchFilesFromJson(json);
  Map<String, dynamic> toJson() => _$BookPitchFilesToJson(this);
}

@JsonSerializable(explicitToJson: true)
class OrganisedBy {
  final int? id;
  final String? name;
  final String? email;
  final String? contact_number;
  final String? countryCode;
  final Rating? ratings;
  final List<Reviews?>? userReviews;

  OrganisedBy(
      {this.id,
      this.name,
      this.email,
      this.contact_number,
      this.countryCode,
      this.userReviews,
      this.ratings});
  factory OrganisedBy.fromJson(Map<String, dynamic> json) =>
      _$OrganisedByFromJson(json);
  Map<String, dynamic> toJson() => _$OrganisedByToJson(this);
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
class Document {
  final int? id;
  final String? fileOf;
  final String? filePath;

  Document({
    this.id,
    this.filePath,
    this.fileOf,
  });
  factory Document.fromJson(Map<String, dynamic> json) =>
      _$DocumentFromJson(json);
  Map<String, dynamic> toJson() => _$DocumentToJson(this);
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
  final double? ratingsAvg;
  Rating({
    this.ratingsAvg,
  });
  factory Rating.fromJson(Map<String, dynamic> json) => _$RatingFromJson(json);
  Map<String, dynamic> toJson() => _$RatingToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Reviews {
  final User? user;
  final String? review;
  final String? created_at;

  Reviews({this.user, this.review, this.created_at});
  factory Reviews.fromJson(Map<String, dynamic> json) =>
      _$ReviewsFromJson(json);
  Map<String, dynamic> toJson() => _$ReviewsToJson(this);
}

@JsonSerializable()
class User {
  final String? first_name;
  final String? last_name;
  User({
    this.first_name,
    this.last_name,
  });
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
