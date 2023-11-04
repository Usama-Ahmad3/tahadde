class AcademyModel {
  AcademyModel({
    num? academyId,
    String? academyNameEnglish,
    String? academyNameArabic,
    String? descriptionEnglish,
    String? descriptionArabic,
    String? academyLocation,
    String? country,
    num? latitude,
    num? longitude,
    String? sportSlug,
    String? sportImage,
    String? facilitySlug,
    String? gameplaySlug,
    String? status,
    List<String>? academyImage,
    Owner? owner,
    List<Session>? session,
    List<Documents>? documents,
    List<Prices>? prices,
  }) {
    _academyId = academyId;
    _academyNameEnglish = academyNameEnglish;
    _academyNameArabic = academyNameArabic;
    _descriptionEnglish = descriptionEnglish;
    _descriptionArabic = descriptionArabic;
    _academyLocation = academyLocation;
    _country = country;
    _latitude = latitude;
    _longitude = longitude;
    _sportSlug = sportSlug;
    _sportImage = sportImage;
    _facilitySlug = facilitySlug;
    _gameplaySlug = gameplaySlug;
    _status = status;
    _academyImage = academyImage;
    _owner = owner;
    _session = session;
    _documents = documents;
    _prices = prices;
  }

  AcademyModel.fromJson(dynamic json) {
    _academyId = json['academy_id'];
    _academyNameEnglish = json['Academy_NameEnglish'];
    _academyNameArabic = json['Academy_NameArabic'];
    _descriptionEnglish = json['descriptionEnglish'];
    _descriptionArabic = json['descriptionArabic'];
    _academyLocation = json['Academy_Location'];
    _country = json['Country'];
    _latitude = json['latitude'];
    _longitude = json['longitude'];
    _sportSlug = json['sport_slug'];
    _sportImage = json['sport_image'];
    _facilitySlug = json['facilitySlug'];
    _gameplaySlug = json['gameplaySlug'];
    _status = json['status'];
    _academyImage = json['academy_image'] != null
        ? json['academy_image'].cast<String>()
        : [];
    _owner = json['owner'] != null ? Owner.fromJson(json['owner']) : null;
    if (json['session'] != null) {
      _session = [];
      json['session'].forEach((v) {
        _session?.add(Session.fromJson(v));
      });
    }
    if (json['documents'] != null) {
      _documents = [];
      json['documents'].forEach((v) {
        _documents?.add(Documents.fromJson(v));
      });
    }
    if (json['prices'] != null) {
      _prices = [];
      json['prices'].forEach((v) {
        _prices?.add(Prices.fromJson(v));
      });
    }
  }
  num? _academyId;
  String? _academyNameEnglish;
  String? _academyNameArabic;
  String? _descriptionEnglish;
  String? _descriptionArabic;
  String? _academyLocation;
  String? _country;
  num? _latitude;
  num? _longitude;
  String? _sportSlug;
  String? _sportImage;
  String? _facilitySlug;
  String? _gameplaySlug;
  String? _status;
  List<String>? _academyImage;
  Owner? _owner;
  List<Session>? _session;
  List<Documents>? _documents;
  List<Prices>? _prices;
  AcademyModel copyWith({
    num? academyId,
    String? academyNameEnglish,
    String? academyNameArabic,
    String? descriptionEnglish,
    String? descriptionArabic,
    String? academyLocation,
    String? country,
    num? latitude,
    num? longitude,
    String? sportSlug,
    String? sportImage,
    String? facilitySlug,
    String? gameplaySlug,
    String? status,
    List<String>? academyImage,
    Owner? owner,
    List<Session>? session,
    List<Documents>? documents,
    List<Prices>? prices,
  }) =>
      AcademyModel(
        academyId: academyId ?? _academyId,
        academyNameEnglish: academyNameEnglish ?? _academyNameEnglish,
        academyNameArabic: academyNameArabic ?? _academyNameArabic,
        descriptionEnglish: descriptionEnglish ?? _descriptionEnglish,
        descriptionArabic: descriptionArabic ?? _descriptionArabic,
        academyLocation: academyLocation ?? _academyLocation,
        country: country ?? _country,
        latitude: latitude ?? _latitude,
        longitude: longitude ?? _longitude,
        sportSlug: sportSlug ?? _sportSlug,
        sportImage: sportImage ?? _sportImage,
        facilitySlug: facilitySlug ?? _facilitySlug,
        gameplaySlug: gameplaySlug ?? _gameplaySlug,
        status: status ?? _status,
        academyImage: academyImage ?? _academyImage,
        owner: owner ?? _owner,
        session: session ?? _session,
        documents: documents ?? _documents,
        prices: prices ?? _prices,
      );
  num? get academyId => _academyId;
  String? get academyNameEnglish => _academyNameEnglish;
  String? get academyNameArabic => _academyNameArabic;
  String? get descriptionEnglish => _descriptionEnglish;
  String? get descriptionArabic => _descriptionArabic;
  String? get academyLocation => _academyLocation;
  String? get country => _country;
  num? get latitude => _latitude;
  num? get longitude => _longitude;
  String? get sportSlug => _sportSlug;
  String? get sportImage => _sportImage;
  String? get facilitySlug => _facilitySlug;
  String? get gameplaySlug => _gameplaySlug;
  String? get status => _status;
  List<String>? get academyImage => _academyImage;
  Owner? get owner => _owner;
  List<Session>? get session => _session;
  List<Documents>? get documents => _documents;
  List<Prices>? get prices => _prices;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['academy_id'] = _academyId;
    map['Academy_NameEnglish'] = _academyNameEnglish;
    map['Academy_NameArabic'] = _academyNameArabic;
    map['descriptionEnglish'] = _descriptionEnglish;
    map['descriptionArabic'] = _descriptionArabic;
    map['Academy_Location'] = _academyLocation;
    map['Country'] = _country;
    map['latitude'] = _latitude;
    map['longitude'] = _longitude;
    map['sport_slug'] = _sportSlug;
    map['sport_image'] = _sportImage;
    map['facilitySlug'] = _facilitySlug;
    map['gameplaySlug'] = _gameplaySlug;
    map['status'] = _status;
    map['academy_image'] = _academyImage;
    if (_owner != null) {
      map['owner'] = _owner?.toJson();
    }
    if (_session != null) {
      map['session'] = _session?.map((v) => v.toJson()).toList();
    }
    if (_documents != null) {
      map['documents'] = _documents?.map((v) => v.toJson()).toList();
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
    String? subAcademy,
    num? price,
  }) {
    _priceId = priceId;
    _subAcademy = subAcademy;
    _price = price;
  }

  Prices.fromJson(dynamic json) {
    _priceId = json['price_id'];
    _subAcademy = json['Sub_Academy'];
    _price = json['Price'];
  }
  num? _priceId;
  String? _subAcademy;
  num? _price;
  Prices copyWith({
    num? priceId,
    String? subAcademy,
    num? price,
  }) =>
      Prices(
        priceId: priceId ?? _priceId,
        subAcademy: subAcademy ?? _subAcademy,
        price: price ?? _price,
      );
  num? get priceId => _priceId;
  String? get subAcademy => _subAcademy;
  num? get price => _price;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['price_id'] = _priceId;
    map['Sub_Academy'] = _subAcademy;
    map['Price'] = _price;
    return map;
  }
}

class Documents {
  Documents({
    num? documentId,
    String? documentName,
    String? licenseNumber,
    String? expiryDate,
    String? file,
  }) {
    _documentId = documentId;
    _documentName = documentName;
    _licenseNumber = licenseNumber;
    _expiryDate = expiryDate;
    _file = file;
  }

  Documents.fromJson(dynamic json) {
    _documentId = json['document_id'];
    _documentName = json['Document_Name'];
    _licenseNumber = json['License_Number'];
    _expiryDate = json['Expiry_Date'];
    _file = json['file'];
  }
  num? _documentId;
  String? _documentName;
  String? _licenseNumber;
  String? _expiryDate;
  String? _file;
  Documents copyWith({
    num? documentId,
    String? documentName,
    String? licenseNumber,
    String? expiryDate,
    String? file,
  }) =>
      Documents(
        documentId: documentId ?? _documentId,
        documentName: documentName ?? _documentName,
        licenseNumber: licenseNumber ?? _licenseNumber,
        expiryDate: expiryDate ?? _expiryDate,
        file: file ?? _file,
      );
  num? get documentId => _documentId;
  String? get documentName => _documentName;
  String? get licenseNumber => _licenseNumber;
  String? get expiryDate => _expiryDate;
  String? get file => _file;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['document_id'] = _documentId;
    map['Document_Name'] = _documentName;
    map['License_Number'] = _licenseNumber;
    map['Expiry_Date'] = _expiryDate;
    map['file'] = _file;
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
    bool? holiday,
    String? name,
    String? nameArabic,
    num? slotDuration,
    num? extraSlot,
    String? startTime,
    String? endTime,
  }) {
    _holiday = holiday;
    _name = name;
    _nameArabic = nameArabic;
    _slotDuration = slotDuration;
    _extraSlot = extraSlot;
    _startTime = startTime;
    _endTime = endTime;
  }

  Sessions.fromJson(dynamic json) {
    _holiday = json['Holiday'];
    _name = json['Name'];
    _nameArabic = json['Name_Arabic'];
    _slotDuration = json['Slot_duration'];
    _extraSlot = json['Extra_slot'];
    _startTime = json['Start_time'];
    _endTime = json['End_time'];
  }
  bool? _holiday;
  String? _name;
  String? _nameArabic;
  num? _slotDuration;
  num? _extraSlot;
  String? _startTime;
  String? _endTime;
  Sessions copyWith({
    bool? holiday,
    String? name,
    String? nameArabic,
    num? slotDuration,
    num? extraSlot,
    String? startTime,
    String? endTime,
  }) =>
      Sessions(
        holiday: holiday ?? _holiday,
        name: name ?? _name,
        nameArabic: nameArabic ?? _nameArabic,
        slotDuration: slotDuration ?? _slotDuration,
        extraSlot: extraSlot ?? _extraSlot,
        startTime: startTime ?? _startTime,
        endTime: endTime ?? _endTime,
      );
  bool? get holiday => _holiday;
  String? get name => _name;
  String? get nameArabic => _nameArabic;
  num? get slotDuration => _slotDuration;
  num? get extraSlot => _extraSlot;
  String? get startTime => _startTime;
  String? get endTime => _endTime;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
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
