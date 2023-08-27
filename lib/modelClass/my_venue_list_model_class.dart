class MyVenueModelClass {
  final int? id;
  final String? venueName;
  final String? pitchImage;
  final String? sportImage;
  final String? location;
  final List<PitchType?>? pitchType;

  final bool? isVerified;
  final bool? isDecline;
  MyVenueModelClass(
      {this.id,
       this.venueName,
        this.pitchImage,
        this.sportImage,
        this.location,
        this.isDecline,
        this.isVerified,
        this.pitchType,
      });
  factory MyVenueModelClass.fromJson(Map<String, dynamic> json) {
    return MyVenueModelClass(
      id: json["id"],
      venueName: json["name"],
      pitchImage: json["bookpitchfiles"]==null?null:json["bookpitchfiles"]["files"].isEmpty?null:json["bookpitchfiles"]["files"][0]["filePath"],
      sportImage: json["sports_types"]==null?null:json["sports_types"]["sport_image"]==null?null:json["sports_types"]["sport_image"]["filePath"],
      location: json["location"],
      isDecline:  json["is_declined"],
      isVerified: json["is_verified"],
      pitchType: (json['pitchType'] as List)
          .map((e) =>
      e == null ? null : PitchType.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}


class PitchType {
  final int? id;
  final String? nameEnglish;
  final String? nameArabic;
  final String? area;

  PitchType({this.id, this.nameEnglish,this.nameArabic, this.area});
  factory PitchType.fromJson(Map<String, dynamic> json) {
    return PitchType(
      id: json["id"],
      nameEnglish: json["nameEnglish"],
      nameArabic: json["nameArabic"],
      area: json["area"],
    );
  }
}

