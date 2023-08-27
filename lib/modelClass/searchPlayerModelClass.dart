import 'package:json_annotation/json_annotation.dart';
part 'searchPlayerModelClass.g.dart';

@JsonSerializable(explicitToJson: true)
class SearchPlayerModelClass {
  final int? id;
  final bool? is_sent;
  final String? contactNumber;
  final String? email;
  final String? first_name;
  final String? last_name;
  final Profile? profile_pic;
  final String? dob;
  final String? customerstripeId;
  final Position? playerPosition;

  SearchPlayerModelClass(
      {this.id,
      this.is_sent,
      this.contactNumber,
      this.email,
      this.first_name,
      this.last_name,
      this.profile_pic,
      this.playerPosition,
      this.dob,
      this.customerstripeId});
  factory SearchPlayerModelClass.fromJson(Map<String, dynamic> json) =>
      _$SearchPlayerModelClassFromJson(json);
  Map<String, dynamic> toJson() => _$SearchPlayerModelClassToJson(this);
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

@JsonSerializable()
class Position {
  final int? id;
  final String? name;
  final String? slug;

  Position({this.id, this.name, this.slug});
  factory Position.fromJson(Map<String, dynamic> json) =>
      _$PositionFromJson(json);
  Map<String, dynamic> toJson() => _$PositionToJson(this);
}
