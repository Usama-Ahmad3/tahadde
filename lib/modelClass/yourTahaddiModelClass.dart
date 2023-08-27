import 'package:json_annotation/json_annotation.dart';
part 'yourTahaddiModelClass.g.dart';

@JsonSerializable(explicitToJson: true)
class Files {
  final int? id;
  final File? files;
  final bool? is_active;
  Files({this.id, this.files, this.is_active});
  factory Files.fromJson(Map<String, dynamic> json) => _$FilesFromJson(json);
  Map<String, dynamic> toJson() => _$FilesToJson(this);
}

@JsonSerializable()
class File {
  final int? id;
  final String? filePath;
  File({
    this.id,
    this.filePath,
  });
  factory File.fromJson(Map<String, dynamic> json) => _$FileFromJson(json);
  Map<String, dynamic> toJson() => _$FileToJson(this);
}

@JsonSerializable(explicitToJson: true)
class YourTahaddi {
  final Tahaddi? tahaddis;
  final String? transactionMadeon;
  final String? transactionFor;
  final List<PitchType?>? pitchType;

  YourTahaddi(
      {this.tahaddis,
      this.transactionMadeon,
      this.transactionFor,
      this.pitchType});

  factory YourTahaddi.fromJson(Map<String, dynamic> json) =>
      _$YourTahaddiFromJson(json);
  Map<String, dynamic> toJson() => _$YourTahaddiToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Tahaddi {
  final String? name;
  final Files? files;
  final int? id;
  final String? country;
  final String? startDate;
  final String? endDate;
  final OrganisedBy? organisedBy;

//  List<Files> files;
  Tahaddi(
      {this.name,
      this.country,
      this.files,
      this.startDate,
      this.endDate,
      this.organisedBy,
      this.id});
  factory Tahaddi.fromJson(Map<String, dynamic> json) =>
      _$TahaddiFromJson(json);
  Map<String, dynamic> toJson() => _$TahaddiToJson(this);
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
class PitchType {
  final int? id;
  final String? name;
  final String? area;

  PitchType({this.id, this.name, this.area});
  factory PitchType.fromJson(Map<String, dynamic> json) =>
      _$PitchTypeFromJson(json);
  Map<String, dynamic> toJson() => _$PitchTypeToJson(this);
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
