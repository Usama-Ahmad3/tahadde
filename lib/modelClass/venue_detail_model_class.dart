
class SpecificVenueModelClass{
  final id;
  final VenueDetails? venueDetails;
  final Images? images;
  final double? latitude ;
  final double? longitude;
  final WeekTimeTable? weekTimeTable;
  bool? isFavourite;
  final SportsType? sports;
  SpecificVenueModelClass(
      {this.id,
        this.venueDetails,
        this.images,
        this.latitude,
        this.longitude,
        this.weekTimeTable,
        this.isFavourite,
        this.sports
      });
  factory SpecificVenueModelClass.fromJson(Map<String, dynamic> json) {
    return SpecificVenueModelClass(
        id: json["id"],
        venueDetails: VenueDetails.fromJson(json["venue_details"]),
        images: Images.fromJson(json["images"],),
      latitude: json["latitude"],
      longitude: json["longitude"],
      weekTimeTable:  WeekTimeTable.fromJson(json["weekday_time_table"]),
      isFavourite:  json["is_favourite"]??false,
        sports: SportsType.fromJson(json["sports_types"])
    );
  }
}
class VenueDetails{
  final String? name;
  final String? location;
  final String? description;
  final List<Facility?>? facilities;
  final List<PitchType?>? pitchType;
  final GamePlay? gamePlay;

  VenueDetails(
      {this.name,
        this.location,
        this.description,
        this.pitchType,
        this.gamePlay,
        this.facilities,

      });
  factory VenueDetails.fromJson(Map<String, dynamic> json) {
    return VenueDetails(
      name: json["name"],
      location: json["location"],
      description: json["description"],
      pitchType: (json['pitchType'] as List)
          .map((e) =>
      e == null ? null : PitchType.fromJson(e as Map<String, dynamic>))
          .toList(),
      gamePlay:  GamePlay.fromJson(json["gamePlay"]),
      facilities: (json['facilities'] as List)
          .map((e) =>
      e == null ? null : Facility.fromJson(e as Map<String, dynamic>))
          .toList(),



    );
  }
}
class Files {
  final int? id;
  final String? filePath;
  final String? fileType;

  Files(
      {this.id,
        this.filePath,
        this.fileType,
      });
  factory Files.fromJson(Map json) {
    return Files(
      id: json['id'],
      filePath: json['filePath'],
      fileType: json['fileType'],
    );
  }

}
class PitchType {
  final int? id;
  final String? name;
  final String? area;

  PitchType({this.id, this.name, this.area, });
  factory PitchType.fromJson(Map json) {
    return PitchType(
        id: json['id'],
        name: json['name'],
        area: json['area']);
  }

}
class GamePlay {
  final int? id;
  final String? name;

  GamePlay({
    this.id,
    this.name,
  });
  factory GamePlay.fromJson(Map json) {
    return GamePlay(
        id: json['id'],
        name: json['name'],
       );
  }

}
class Facility {
  final int? id;
  final String? name;
  final String? image;
  Facility({this.id, this.name, this.image});
  factory Facility.fromJson(Map json) {
    return Facility(
      id: json['id'],
      name: json['name'],
      image: json['image']==null?null:json['image']["filePath"],
    );
  }
}
class Images {
  final int? id;
  final List<Files?>? files;
  Images({
    this.id,
    this.files,
  });
  factory Images.fromJson(Map json) {
    return Images(
      id: json['id'],
      files: (json['files'] as List)
          .map((e) =>
      e == null ? null : Files.fromJson(e as Map<String, dynamic>))
          .toList(),);
  }

}
class WeekTimeTable{
  final TimeTable? monday;
  final TimeTable? tuesday;
  final TimeTable? wednesday;
  final TimeTable? thursday;
  final TimeTable? friday;
  final TimeTable? saturday;
  final TimeTable? sunday;
  WeekTimeTable({this.monday,this.tuesday,this.wednesday,this.thursday,this.friday,this.saturday,this.sunday});
  factory WeekTimeTable.fromJson(Map json){
    return WeekTimeTable(
      monday: json['monday']==null?null:TimeTable.fromJson(json['monday']),
      tuesday: json['tuesday']==null?null:TimeTable.fromJson(json['tuesday']),
      wednesday: json['wednesday']==null?null:TimeTable.fromJson(json['wednesday']),
      thursday: json['thursday']==null?null:TimeTable.fromJson(json['thursday']),
      friday: json['friday']==null?null:TimeTable.fromJson(json['friday']),
      saturday: json['saturday']==null?null:TimeTable.fromJson(json['saturday']),
      sunday: json['sunday']==null?null:TimeTable.fromJson(json['sunday']),

    );
  }
}


 class TimeTable{
  final String? startTime;
  final String? endTime;
  TimeTable({this.startTime,this.endTime});
  factory TimeTable.fromJson(Map json){
    return TimeTable(
      startTime: json['startTime__min'],
      endTime: json['endTime__max'],
    );
  }

 }
class SportsType {
  final int? id;
  final String? name;
  final String? sportArabic;
  final String? sportSlug;


  SportsType({this.id, this.name,this.sportArabic,this.sportSlug,});
  factory SportsType.fromJson(Map json) {
    return SportsType(
      id: json['id'],
      name: json['sport_name'],
      sportArabic: json['sport_arabic_name'],
      sportSlug: json['sport_slug'],



    );
  }

}