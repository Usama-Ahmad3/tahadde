class Facilities {
  Facilities({
    num? id,
    String? facilityName,
    String? facilityArabicName,
    String? facilitySlug,
    String? facilityImage,
    bool? isActive,
  }) {
    _id = id;
    _facilityName = facilityName;
    _facilityArabicName = facilityArabicName;
    _facilitySlug = facilitySlug;
    _facilityImage = facilityImage;
    _isActive = isActive;
  }

  Facilities.fromJson(dynamic json) {
    _id = json['id'];
    _facilityName = json['facility_name'];
    _facilityArabicName = json['facility_arabic_name'];
    _facilitySlug = json['facility_slug'];
    _facilityImage = json['facility_image'];
    _isActive = json['is_active'];
  }
  num? _id;
  String? _facilityName;
  String? _facilityArabicName;
  String? _facilitySlug;
  String? _facilityImage;
  bool? _isActive;
  Facilities copyWith({
    num? id,
    String? facilityName,
    String? facilityArabicName,
    String? facilitySlug,
    String? facilityImage,
    bool? isActive,
  }) =>
      Facilities(
        id: id ?? _id,
        facilityName: facilityName ?? _facilityName,
        facilityArabicName: facilityArabicName ?? _facilityArabicName,
        facilitySlug: facilitySlug ?? _facilitySlug,
        facilityImage: facilityImage ?? _facilityImage,
        isActive: isActive ?? _isActive,
      );
  num? get id => _id;
  String? get facilityName => _facilityName;
  String? get facilityArabicName => _facilityArabicName;
  String? get facilitySlug => _facilitySlug;
  String? get facilityImage => _facilityImage;
  bool? get isActive => _isActive;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['facility_name'] = _facilityName;
    map['facility_arabic_name'] = _facilityArabicName;
    map['facility_slug'] = _facilitySlug;
    map['facility_image'] = _facilityImage;
    map['is_active'] = _isActive;
    return map;
  }
}
