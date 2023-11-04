class TerritoryModelClass {
  TerritoryModelClass({
    List<Countries>? countries,
  }) {
    _countries = countries;
  }

  TerritoryModelClass.fromJson(dynamic json) {
    if (json['countries'] != null) {
      _countries = [];
      json['countries'].forEach((v) {
        _countries?.add(Countries.fromJson(v));
      });
    }
  }
  List<Countries>? _countries;
  TerritoryModelClass copyWith({
    List<Countries>? countries,
  }) =>
      TerritoryModelClass(
        countries: countries ?? _countries,
      );
  List<Countries>? get countries => _countries;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_countries != null) {
      map['countries'] = _countries?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Countries {
  Countries({
    int? id,
    String? name,
    String? arabicName,
    String? code,
    String? continent,
    String? currencyCode,
    String? currencySymbol,
    String? flag,
    String? imageUrl,
    dynamic orderNumber,
    List<Cities>? cities,
  }) {
    _id = id;
    _name = name;
    _arabicName = arabicName;
    _code = code;
    _continent = continent;
    _currencyCode = currencyCode;
    _currencySymbol = currencySymbol;
    _flag = flag;
    _imageUrl = imageUrl;
    _orderNumber = orderNumber;
    _cities = cities;
  }

  Countries.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _arabicName = json['arabic_name'];
    _code = json['code'];
    _continent = json['continent'];
    _currencyCode = json['currency_code'];
    _currencySymbol = json['currency_symbol'];
    _flag = json['flag'];
    _imageUrl = json['image_url'];
    _orderNumber = json['order_number'];
    if (json['cities'] != null) {
      _cities = [];
      json['cities'].forEach((v) {
        _cities?.add(Cities.fromJson(v));
      });
    }
  }
  int? _id;
  String? _name;
  String? _arabicName;
  String? _code;
  String? _continent;
  String? _currencyCode;
  String? _currencySymbol;
  String? _flag;
  String? _imageUrl;
  dynamic _orderNumber;
  List<Cities>? _cities;
  Countries copyWith({
    int? id,
    String? name,
    String? arabicName,
    String? code,
    String? continent,
    String? currencyCode,
    String? currencySymbol,
    String? flag,
    String? imageUrl,
    dynamic orderNumber,
    List<Cities>? cities,
  }) =>
      Countries(
        id: id ?? _id,
        name: name ?? _name,
        arabicName: arabicName ?? _arabicName,
        code: code ?? _code,
        continent: continent ?? _continent,
        currencyCode: currencyCode ?? _currencyCode,
        currencySymbol: currencySymbol ?? _currencySymbol,
        flag: flag ?? _flag,
        imageUrl: imageUrl ?? _imageUrl,
        orderNumber: orderNumber ?? _orderNumber,
        cities: cities ?? _cities,
      );
  int? get id => _id;
  String? get name => _name;
  String? get arabicName => _arabicName;
  String? get code => _code;
  String? get continent => _continent;
  String? get currencyCode => _currencyCode;
  String? get currencySymbol => _currencySymbol;
  String? get flag => _flag;
  String? get imageUrl => _imageUrl;
  dynamic get orderNumber => _orderNumber;
  List<Cities>? get cities => _cities;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['arabic_name'] = _arabicName;
    map['code'] = _code;
    map['continent'] = _continent;
    map['currency_code'] = _currencyCode;
    map['currency_symbol'] = _currencySymbol;
    map['flag'] = _flag;
    map['image_url'] = _imageUrl;
    map['order_number'] = _orderNumber;
    if (_cities != null) {
      map['cities'] = _cities?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Cities {
  Cities({
    int? id,
    bool? isDeleted,
    bool? isDisabled,
    String? name,
    String? arabicName,
    String? latitude,
    String? longitude,
  }) {
    _id = id;
    _isDeleted = isDeleted;
    _isDisabled = isDisabled;
    _name = name;
    _arabicName = arabicName;
    _latitude = latitude;
    _longitude = longitude;
  }

  Cities.fromJson(dynamic json) {
    _id = json['id'];
    _isDeleted = json['is_deleted'];
    _isDisabled = json['is_disabled'];
    _name = json['name'];
    _arabicName = json['arabic_name'];
    _latitude = json['latitude'];
    _longitude = json['longitude'];
  }
  int? _id;
  bool? _isDeleted;
  bool? _isDisabled;
  String? _name;
  String? _arabicName;
  String? _latitude;
  String? _longitude;
  Cities copyWith({
    int? id,
    bool? isDeleted,
    bool? isDisabled,
    String? name,
    String? arabicName,
    String? latitude,
    String? longitude,
  }) =>
      Cities(
        id: id ?? _id,
        isDeleted: isDeleted ?? _isDeleted,
        isDisabled: isDisabled ?? _isDisabled,
        name: name ?? _name,
        arabicName: arabicName ?? _arabicName,
        latitude: latitude ?? _latitude,
        longitude: longitude ?? _longitude,
      );
  int? get id => _id;
  bool? get isDeleted => _isDeleted;
  bool? get isDisabled => _isDisabled;
  String? get name => _name;
  String? get arabicName => _arabicName;
  String? get latitude => _latitude;
  String? get longitude => _longitude;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['is_deleted'] = _isDeleted;
    map['is_disabled'] = _isDisabled;
    map['name'] = _name;
    map['arabic_name'] = _arabicName;
    map['latitude'] = _latitude;
    map['longitude'] = _longitude;
    return map;
  }
}
