class TerritoryModelClass{
  final int? id;
  final Country? country;
  final List<Cities?>? cities;
  TerritoryModelClass(
      {this.id,
        this.cities,
      this.country});

  factory TerritoryModelClass.fromJson(Map<String, dynamic> json) {
    return TerritoryModelClass(
      id: json["id"],
      country:Country.fromJson(json["country"]),
      cities: (json['cities'] as List)
          .map((e) =>
      e == null ? null : Cities.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
class Country{
  final int? id;
  final String? name;
  final String? nameArabic;
  final String? code;
  final String? continent;
  final String? image;
  Country(
      {this.id,
        this.name,
        this.nameArabic,
        this.code,
      this.continent,
        this.image});

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      id: json["id"],
      name:json["name"],
     nameArabic: json["arabic_name"],
     code: json["code"],
      continent: json["continent"],
      image: json["image_url"],
    );
  }
}
class Cities{
  final int? id;
 final bool? isDisable;
 final City? city;

  Cities(
      {this.id,
       this.isDisable,
        this.city});

  factory Cities.fromJson(Map<String, dynamic> json) {
    return Cities(
      id: json["id"],
      isDisable:json["is_disabled"],
      city:  City.fromJson(json["city"]),
    );
  }
}
class City{
  final int? id;
  final String? name;
  final String? nameArabic;
  final String? latitude;
  final String? longitude;

  City(
      {this.id,
        this.name,
        this.nameArabic,
        this.latitude,
      this.longitude});

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: json["id"],
      name:json["name"],
      nameArabic:json["arabic_name"],
      latitude: json["latitude"],
      longitude: json["longitude"],
    );
  }
}