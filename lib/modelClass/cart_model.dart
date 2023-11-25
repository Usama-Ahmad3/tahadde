class CartModel {
  CartModel({
    num? id,
    double? price,
    num? academy,
    List<num>? session,
    String? academyName,
    String? subAcademy,
    String? location,
    num? playerCount,
    String? bookedDate,
    num? pricePerPlayer,
  }) {
    _id = id;
    _price = price;
    _academy = academy;
    _session = session;
    _academyName = academyName;
    _subAcademy = subAcademy;
    _location = location;
    _playerCount = playerCount;
    _bookedDate = bookedDate;
    _pricePerPlayer = pricePerPlayer;
  }

  CartModel.fromJson(dynamic json) {
    _id = json['id'];
    _price = json['price'];
    _academy = json['academy'];
    _session = json['session'] != null ? json['session'].cast<num>() : [];
    _academyName = json['academyName'];
    _subAcademy = json['Sub_Academy'];
    _location = json['location'];
    _playerCount = json['player_count'];
    _bookedDate = json['booked_date'];
    _pricePerPlayer = json['price_per_player'];
  }
  num? _id;
  double? _price;
  num? _academy;
  List<num>? _session;
  String? _academyName;
  String? _subAcademy;
  String? _location;
  num? _playerCount;
  String? _bookedDate;
  num? _pricePerPlayer;
  CartModel copyWith({
    num? id,
    double? price,
    num? academy,
    List<num>? session,
    String? academyName,
    String? subAcademy,
    String? location,
    num? playerCount,
    String? bookedDate,
    num? pricePerPlayer,
  }) =>
      CartModel(
        id: id ?? _id,
        price: price ?? _price,
        academy: academy ?? _academy,
        session: session ?? _session,
        academyName: academyName ?? _academyName,
        subAcademy: subAcademy ?? _subAcademy,
        location: location ?? _location,
        playerCount: playerCount ?? _playerCount,
        bookedDate: bookedDate ?? _bookedDate,
        pricePerPlayer: pricePerPlayer ?? _pricePerPlayer,
      );
  num? get id => _id;
  double? get price => _price;
  num? get academy => _academy;
  List<num>? get session => _session;
  String? get academyName => _academyName;
  String? get subAcademy => _subAcademy;
  String? get location => _location;
  num? get playerCount => _playerCount;
  String? get bookedDate => _bookedDate;
  num? get pricePerPlayer => _pricePerPlayer;
  set playerCount(num? value) {
    _playerCount = value;
  }

  set price(double? value) {
    _price = value;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['price'] = _price;
    map['academy'] = _academy;
    map['session'] = _session;
    map['academyName'] = _academyName;
    map['Sub_Academy'] = _subAcademy;
    map['location'] = _location;
    map['player_count'] = _playerCount;
    map['booked_date'] = _bookedDate;
    map['price_per_player'] = _pricePerPlayer;
    return map;
  }
}
