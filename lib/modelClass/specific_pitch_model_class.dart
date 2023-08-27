class SpecificModelClass{
  final id;
  final String? code;
  final VenueDetails? venueDetails;
  final Images? images;
  final bool? isVerified;
  final bool? isDeclined;
  final sessions;

  SpecificModelClass(
      {this.id,
        this.code,
      this.venueDetails,
        this.images,
        this.isVerified,
        this.isDeclined,
        this.sessions
      });
  factory SpecificModelClass.fromJson(Map<String, dynamic> json) {
    return SpecificModelClass(
      id: json["id"],
        code: json["code"],
      venueDetails: VenueDetails.fromJson(json["venue_details"]),
      images: Images.fromJson(json["images"]),
      isVerified:json["is_verified"] ,
      isDeclined: json["is_declined"],
      sessions:  json["sessions"],
    );
  }
}
class VenueDetails{
  final String? name;
  final String? nameEnglish;
  final String? nameArabic;
  final String? location;
  final String? description;
  final String? descriptionEnglish;
  final String? descriptionArabic;
  final List<PitchType?>? pitchType;
  final List<Facility?>? facility;
  final GamePlay? gamePlay;


  VenueDetails(
      {
        this.name,
        this.nameEnglish,
        this.nameArabic,
        this.location,
        this.description,
        this.descriptionEnglish,
        this.descriptionArabic,
        this.pitchType,
        this.facility,
        this.gamePlay
      });
  factory VenueDetails.fromJson(Map<String, dynamic> json) {
    return VenueDetails(
      name: json["name"],
      nameEnglish: json["nameEnglish"]??"",
      nameArabic: json["nameArabic"]??"",
      location: json["location"],
      description: json["description"],
      descriptionEnglish: json["descriptionEnglish"],
      descriptionArabic: json["descriptionArabic"],
      pitchType:  (json["pitchType"] as List).map((e) => e == null ? null : PitchType.fromJson(e as Map<String, dynamic>)).toList(),
      facility: (json["facilities"] as List).map((e) => e == null ? null : Facility.fromJson(e as Map<String, dynamic>)).toList(),
    gamePlay: GamePlay.fromJson(json["gamePlay"]) ,


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
  final String? slug;

  GamePlay({
    this.id,
    this.name,
    this.slug
  });
  factory GamePlay.fromJson(Map json) {
    return GamePlay(
        id: json['id'],
        name: json['name'],
    slug:json['slug']);
  }

}


class Facility {
  final int? id;
  final String? name;
  final String? image;
  final String? slug;

  Facility({this.id, this.name, this.image,this.slug});
  factory Facility.fromJson(Map json) {
    return Facility(
        id: json['id'],
        name: json['name'],
        image: json['image']["filePath"],
       slug:json['slug']);
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







