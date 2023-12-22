class InnovativeHub {
  InnovativeHub({
    num? innovativehubId,
    String? nameEnglish,
    String? nameArabic,
    String? descriptionEnglish,
    String? descriptionArabic,
    String? location,
    String? country,
    num? latitude,
    num? longitude,
    String? sportSlug,
    String? sportImage,
    String? image,
    Owner? owner,
    List<Session>? session,
    List<Prices>? prices,
  }) {
    _innovativehubId = innovativehubId;
    _nameEnglish = nameEnglish;
    _nameArabic = nameArabic;
    _descriptionEnglish = descriptionEnglish;
    _descriptionArabic = descriptionArabic;
    _location = location;
    _country = country;
    _latitude = latitude;
    _longitude = longitude;
    _sportSlug = sportSlug;
    _sportImage = sportImage;
    _image = image;
    _owner = owner;
    _session = session;
    _prices = prices;
  }

  InnovativeHub.fromJson(dynamic json) {
    _innovativehubId = json['innovativehub_id'];
    _nameEnglish = json['NameEnglish'];
    _nameArabic = json['NameArabic'];
    _descriptionEnglish = json['descriptionEnglish'];
    _descriptionArabic = json['descriptionArabic'];
    _location = json['Location'];
    _country = json['Country'];
    _latitude = json['latitude'];
    _longitude = json['longitude'];
    _sportSlug = json['sport_slug'];
    _sportImage = json['sport_image'];
    _image = json['image'];
    _owner = json['owner'] != null ? Owner.fromJson(json['owner']) : null;
    if (json['session'] != null) {
      _session = [];
      json['session'].forEach((v) {
        _session?.add(Session.fromJson(v));
      });
    }
    if (json['prices'] != null) {
      _prices = [];
      json['prices'].forEach((v) {
        _prices?.add(Prices.fromJson(v));
      });
    }
  }
  num? _innovativehubId;
  String? _nameEnglish;
  String? _nameArabic;
  String? _descriptionEnglish;
  String? _descriptionArabic;
  String? _location;
  String? _country;
  num? _latitude;
  num? _longitude;
  String? _sportSlug;
  String? _sportImage;
  String? _image;
  Owner? _owner;
  List<Session>? _session;
  List<Prices>? _prices;
  InnovativeHub copyWith({
    num? innovativehubId,
    String? nameEnglish,
    String? nameArabic,
    String? descriptionEnglish,
    String? descriptionArabic,
    String? location,
    String? country,
    num? latitude,
    num? longitude,
    String? sportSlug,
    String? sportImage,
    String? image,
    Owner? owner,
    List<Session>? session,
    List<Prices>? prices,
  }) =>
      InnovativeHub(
        innovativehubId: innovativehubId ?? _innovativehubId,
        nameEnglish: nameEnglish ?? _nameEnglish,
        nameArabic: nameArabic ?? _nameArabic,
        descriptionEnglish: descriptionEnglish ?? _descriptionEnglish,
        descriptionArabic: descriptionArabic ?? _descriptionArabic,
        location: location ?? _location,
        country: country ?? _country,
        latitude: latitude ?? _latitude,
        longitude: longitude ?? _longitude,
        sportSlug: sportSlug ?? _sportSlug,
        sportImage: sportImage ?? _sportImage,
        image: image ?? _image,
        owner: owner ?? _owner,
        session: session ?? _session,
        prices: prices ?? _prices,
      );
  num? get innovativehubId => _innovativehubId;
  String? get nameEnglish => _nameEnglish;
  String? get nameArabic => _nameArabic;
  String? get descriptionEnglish => _descriptionEnglish;
  String? get descriptionArabic => _descriptionArabic;
  String? get location => _location;
  String? get country => _country;
  num? get latitude => _latitude;
  num? get longitude => _longitude;
  String? get sportSlug => _sportSlug;
  String? get sportImage => _sportImage;
  String? get image => _image;
  Owner? get owner => _owner;
  List<Session>? get session => _session;
  List<Prices>? get prices => _prices;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['innovativehub_id'] = _innovativehubId;
    map['NameEnglish'] = _nameEnglish;
    map['NameArabic'] = _nameArabic;
    map['descriptionEnglish'] = _descriptionEnglish;
    map['descriptionArabic'] = _descriptionArabic;
    map['Location'] = _location;
    map['Country'] = _country;
    map['latitude'] = _latitude;
    map['longitude'] = _longitude;
    map['sport_slug'] = _sportSlug;
    map['sport_image'] = _sportImage;
    map['image'] = _image;
    if (_owner != null) {
      map['owner'] = _owner?.toJson();
    }
    if (_session != null) {
      map['session'] = _session?.map((v) => v.toJson()).toList();
    }
    if (_prices != null) {
      map['prices'] = _prices?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Prices {
  Prices({
    num? priceId,
    num? price,
  }) {
    _priceId = priceId;
    _price = price;
  }

  Prices.fromJson(dynamic json) {
    _priceId = json['price_id'];
    _price = json['Price'];
  }
  num? _priceId;
  num? _price;
  Prices copyWith({
    num? priceId,
    num? price,
  }) =>
      Prices(
        priceId: priceId ?? _priceId,
        price: price ?? _price,
      );
  num? get priceId => _priceId;
  num? get price => _price;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['price_id'] = _priceId;
    map['Price'] = _price;
    return map;
  }
}

class Session {
  Session({
    String? weekday,
    List<Sessions>? sessions,
  }) {
    _weekday = weekday;
    _sessions = sessions;
  }

  Session.fromJson(dynamic json) {
    _weekday = json['weekday'];
    if (json['sessions'] != null) {
      _sessions = [];
      json['sessions'].forEach((v) {
        _sessions?.add(Sessions.fromJson(v));
      });
    }
  }
  String? _weekday;
  List<Sessions>? _sessions;
  Session copyWith({
    String? weekday,
    List<Sessions>? sessions,
  }) =>
      Session(
        weekday: weekday ?? _weekday,
        sessions: sessions ?? _sessions,
      );
  String? get weekday => _weekday;
  List<Sessions>? get sessions => _sessions;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['weekday'] = _weekday;
    if (_sessions != null) {
      map['sessions'] = _sessions?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Sessions {
  Sessions({
    num? id,
    bool? holiday,
    String? name,
    String? nameArabic,
    num? slotDuration,
    num? extraSlot,
    String? startTime,
    String? endTime,
  }) {
    _id = id;
    _holiday = holiday;
    _name = name;
    _nameArabic = nameArabic;
    _slotDuration = slotDuration;
    _extraSlot = extraSlot;
    _startTime = startTime;
    _endTime = endTime;
  }

  Sessions.fromJson(dynamic json) {
    _id = json['id'];
    _holiday = json['Holiday'];
    _name = json['Name'];
    _nameArabic = json['Name_Arabic'];
    _slotDuration = json['Slot_duration'];
    _extraSlot = json['Extra_slot'];
    _startTime = json['Start_time'];
    _endTime = json['End_time'];
  }
  num? _id;
  bool? _holiday;
  String? _name;
  String? _nameArabic;
  num? _slotDuration;
  num? _extraSlot;
  String? _startTime;
  String? _endTime;
  Sessions copyWith({
    num? id,
    bool? holiday,
    String? name,
    String? nameArabic,
    num? slotDuration,
    num? extraSlot,
    String? startTime,
    String? endTime,
  }) =>
      Sessions(
        id: id ?? _id,
        holiday: holiday ?? _holiday,
        name: name ?? _name,
        nameArabic: nameArabic ?? _nameArabic,
        slotDuration: slotDuration ?? _slotDuration,
        extraSlot: extraSlot ?? _extraSlot,
        startTime: startTime ?? _startTime,
        endTime: endTime ?? _endTime,
      );
  num? get id => _id;
  bool? get holiday => _holiday;
  String? get name => _name;
  String? get nameArabic => _nameArabic;
  num? get slotDuration => _slotDuration;
  num? get extraSlot => _extraSlot;
  String? get startTime => _startTime;
  String? get endTime => _endTime;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['Holiday'] = _holiday;
    map['Name'] = _name;
    map['Name_Arabic'] = _nameArabic;
    map['Slot_duration'] = _slotDuration;
    map['Extra_slot'] = _extraSlot;
    map['Start_time'] = _startTime;
    map['End_time'] = _endTime;
    return map;
  }
}

class Owner {
  Owner({
    num? ownerId,
    String? ownerEmail,
  }) {
    _ownerId = ownerId;
    _ownerEmail = ownerEmail;
  }

  Owner.fromJson(dynamic json) {
    _ownerId = json['owner_id'];
    _ownerEmail = json['owner_email'];
  }
  num? _ownerId;
  String? _ownerEmail;
  Owner copyWith({
    num? ownerId,
    String? ownerEmail,
  }) =>
      Owner(
        ownerId: ownerId ?? _ownerId,
        ownerEmail: ownerEmail ?? _ownerEmail,
      );
  num? get ownerId => _ownerId;
  String? get ownerEmail => _ownerEmail;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['owner_id'] = _ownerId;
    map['owner_email'] = _ownerEmail;
    return map;
  }
}
