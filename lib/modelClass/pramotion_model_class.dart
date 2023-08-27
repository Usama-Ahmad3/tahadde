class PromotionModelClass{
  final int? id;
  final String? name;
  final String? image_url;
  final String? type_of_promotion;
  final String? link;
  var pitchData;
  PromotionModelClass(
  {this.id,
  this.name,
 this.image_url,
    this.link,
  this.type_of_promotion,this.pitchData});

  factory PromotionModelClass.fromJson(Map<String, dynamic> json) {
    return PromotionModelClass(
      id: json["id"],
      name:json["name"],
      image_url: json["image_url"][0]["filePath"],
      type_of_promotion: json["type_of_promotion"],
      link:  json["link"],
      pitchData:json["book_pitch"]
    );
  }
}