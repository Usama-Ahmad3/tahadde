import 'package:json_annotation/json_annotation.dart';
part 'teamModelClass.g.dart';

@JsonSerializable(explicitToJson: true)
class TeamModelClass {
  final int? id;
  final String? contactNumber;
  final String? countryCode;
  final String? email;
  final String? teamName;
  final String? created_at;
  final int? numberofPlayers;
  final Captain? captain;
  final List<Players?>? players;
  final TeamLogo? teamLogo;

  TeamModelClass(
      {this.id,
      this.contactNumber,
      this.email,
      this.captain,
      this.created_at,
      this.numberofPlayers,
      this.players,
      this.teamLogo,
      this.teamName,
      this.countryCode});
  factory TeamModelClass.fromJson(Map<String, dynamic> json) =>
      _$TeamModelClassFromJson(json);
  Map<String, dynamic> toJson() => _$TeamModelClassToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Captain {
  final int? id;
  final String? first_name;
  final String? last_name;
  final String? email;
  final String? contact_number;
  final Profile? profile_pic;
  final String? dob;
  final String? customerstripeId;
  final Position? playerPosition;
  Captain(
      {this.id,
      this.email,
      this.contact_number,
      this.customerstripeId,
      this.dob,
      this.first_name,
      this.last_name,
      this.playerPosition,
      this.profile_pic});
  factory Captain.fromJson(Map<String, dynamic> json) =>
      _$CaptainFromJson(json);
  Map<String, dynamic> toJson() => _$CaptainToJson(this);
}

@JsonSerializable()
class TeamLogo {
  final int? id;
  final String? fileOf;
  final String? filePath;

  TeamLogo({this.id, this.fileOf, this.filePath});
  factory TeamLogo.fromJson(Map<String, dynamic> json) =>
      _$TeamLogoFromJson(json);
  Map<String, dynamic> toJson() => _$TeamLogoToJson(this);
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

@JsonSerializable(explicitToJson: true)
class Players {
  final int? id;
  final String? first_name;
  final String? last_name;
  final String? email;
  final String? contact_number;
  final Profile? profile_pic;
  final String? dob;
  final String? customerstripeId;
  final Position? playerPosition;

  Players(
      {this.dob,
      this.id,
      this.contact_number,
      this.email,
      this.last_name,
      this.customerstripeId,
      this.playerPosition,
      this.first_name,
      this.profile_pic});
  factory Players.fromJson(Map<String, dynamic> json) =>
      _$PlayersFromJson(json);
  Map<String, dynamic> toJson() => _$PlayersToJson(this);
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
