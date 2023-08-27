import 'package:json_annotation/json_annotation.dart';
part 'turnamentModelClass.g.dart';

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

@JsonSerializable(explicitToJson: true)
class Turnament {
  final int? id;
  final String? name;
  final String? country;
  final String? location;
  final PitchType? pitchType;
  final double? latitude;
  final double? longitude;
  final String? description;
  final String? startDate;
  final String? endDate;
  final String? bookingLastDate;
  final PaymentSummary? paymentSummary;
  final OrganisedBy? organisedBy;
  final LeagueFiles? tournamentfiles;
  final GamePlay? gamePlay;
  final String? link;
  final List<Facility?>? facilities;
  final List<RegisteredTeam?>? registeredTeam;

  Turnament(
      {this.id,
      this.name,
      this.country,
      this.location,
      this.pitchType,
      this.latitude,
      this.longitude,
      this.description,
      this.startDate,
      this.endDate,
      this.bookingLastDate,
      this.paymentSummary,
      this.organisedBy,
      this.tournamentfiles,
      this.facilities,
      this.gamePlay,
      this.link,
      this.registeredTeam});

  factory Turnament.fromJson(Map<String, dynamic> json) =>
      _$TurnamentFromJson(json);
  Map<String, dynamic> toJson() => _$TurnamentToJson(this);
}

@JsonSerializable()
class LeagueFiles {
  final int? id;
  final Files? files;
  final bool? is_active;
//  List<Files> files;
  LeagueFiles({this.id, this.files, this.is_active});
  factory LeagueFiles.fromJson(Map<String, dynamic> json) =>
      _$LeagueFilesFromJson(json);
  Map<String, dynamic> toJson() => _$LeagueFilesToJson(this);
}

@JsonSerializable(explicitToJson: true)
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
class PitchType {
  final int? id;
  final String? name;

  PitchType({
    this.id,
    this.name,
  });
  factory PitchType.fromJson(Map<String, dynamic> json) =>
      _$PitchTypeFromJson(json);
  Map<String, dynamic> toJson() => _$PitchTypeToJson(this);
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

@JsonSerializable(explicitToJson: true)
class RegisteredTeam {
  final User? user;
  final String? transactionId;
  final double? paidTotal;
  final Team? team;

  RegisteredTeam({this.user, this.team, this.paidTotal, this.transactionId});
  factory RegisteredTeam.fromJson(Map<String, dynamic> json) =>
      _$RegisteredTeamFromJson(json);
  Map<String, dynamic> toJson() => _$RegisteredTeamToJson(this);
}

@JsonSerializable(explicitToJson: true)
class User {
  final String? first_name;
  final String? last_name;
  final String? email;
  final String? contact_number;
  final Profile? profile_pic;
  User(
      {this.first_name,
      this.last_name,
      this.profile_pic,
      this.email,
      this.contact_number});
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Team {
  final String? teamName;
  final bool? is_external;
  final Logo? teamLogo;
  Team({this.is_external, this.teamName, this.teamLogo});
  factory Team.fromJson(Map<String, dynamic> json) => _$TeamFromJson(json);
  Map<String, dynamic> toJson() => _$TeamToJson(this);
}

@JsonSerializable()
class Profile {
  final String? filePath;

  Profile({this.filePath});
  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileToJson(this);
}

@JsonSerializable()
class Logo {
  final String? filePath;
  Logo({this.filePath});
  factory Logo.fromJson(Map<String, dynamic> json) => _$LogoFromJson(json);
  Map<String, dynamic> toJson() => _$LogoToJson(this);
}
