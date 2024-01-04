class Campaign {
  Campaign({
    String? name,
    String? link,
    String? validityStart,
    String? validityEnd,
    String? description,
    String? country,
    String? city,
    String? days,
    String? campaignType,
    String? bannerImage,
  }) {
    _name = name;
    _link = link;
    _validityStart = validityStart;
    _validityEnd = validityEnd;
    _description = description;
    _country = country;
    _city = city;
    _days = days;
    _campaignType = campaignType;
    _bannerImage = bannerImage;
  }

  Campaign.fromJson(dynamic json) {
    _name = json['name'];
    _link = json['link'];
    _validityStart = json['validity_start'];
    _validityEnd = json['validity_end'];
    _description = json['description'];
    _country = json['country'];
    _city = json['city'];
    _days = json['days'];
    _campaignType = json['campaign_type'];
    _bannerImage = json['banner_image'];
  }
  String? _name;
  String? _link;
  String? _validityStart;
  String? _validityEnd;
  String? _description;
  String? _country;
  String? _city;
  String? _days;
  String? _campaignType;
  String? _bannerImage;
  Campaign copyWith({
    String? name,
    String? link,
    String? validityStart,
    String? validityEnd,
    String? description,
    String? country,
    String? city,
    String? days,
    String? campaignType,
    String? bannerImage,
  }) =>
      Campaign(
        name: name ?? _name,
        link: link ?? _link,
        validityStart: validityStart ?? _validityStart,
        validityEnd: validityEnd ?? _validityEnd,
        description: description ?? _description,
        country: country ?? _country,
        city: city ?? _city,
        days: days ?? _days,
        campaignType: campaignType ?? _campaignType,
        bannerImage: bannerImage ?? _bannerImage,
      );
  String? get name => _name;
  String? get link => _link;
  String? get validityStart => _validityStart;
  String? get validityEnd => _validityEnd;
  String? get description => _description;
  String? get country => _country;
  String? get city => _city;
  String? get days => _days;
  String? get campaignType => _campaignType;
  String? get bannerImage => _bannerImage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['link'] = _link;
    map['validity_start'] = _validityStart;
    map['validity_end'] = _validityEnd;
    map['description'] = _description;
    map['country'] = _country;
    map['city'] = _city;
    map['days'] = _days;
    map['campaign_type'] = _campaignType;
    map['banner_image'] = _bannerImage;
    return map;
  }
}
