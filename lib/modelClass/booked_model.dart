class BookedModel {
  BookedModel({
    num? academy,
    num? player,
    bool? paymentStatus,
    List<num>? bookedSession,
    dynamic bookingDate,
    num? playerCount,
    String? bookedDate,
    dynamic location,
    dynamic transactionId,
    dynamic price,
    dynamic currency,
    String? playerName,
    dynamic playerPicture,
    String? playerEmail,
    String? playerPhoneno,
  }) {
    _academy = academy;
    _player = player;
    _paymentStatus = paymentStatus;
    _bookedSession = bookedSession;
    _bookingDate = bookingDate;
    _playerCount = playerCount;
    _bookedDate = bookedDate;
    _location = location;
    _transactionId = transactionId;
    _price = price;
    _currency = currency;
    _playerName = playerName;
    _playerPicture = playerPicture;
    _playerEmail = playerEmail;
    _playerPhoneno = playerPhoneno;
  }

  BookedModel.fromJson(dynamic json) {
    _academy = json['academy'];
    _player = json['player'];
    _paymentStatus = json['payment_status'];
    _bookedSession = json['booked_session'] != null
        ? json['booked_session'].cast<num>()
        : [];
    _bookingDate = json['booking_date'];
    _playerCount = json['player_count'];
    _bookedDate = json['booked_date'];
    _location = json['location'];
    _transactionId = json['transaction_id'];
    _price = json['price'];
    _currency = json['currency'];
    _playerName = json['player_name'];
    _playerPicture = json['player_picture'];
    _playerEmail = json['player_email'];
    _playerPhoneno = json['player_phoneno'];
  }
  num? _academy;
  num? _player;
  bool? _paymentStatus;
  List<num>? _bookedSession;
  dynamic _bookingDate;
  num? _playerCount;
  String? _bookedDate;
  dynamic _location;
  dynamic _transactionId;
  dynamic _price;
  dynamic _currency;
  String? _playerName;
  dynamic _playerPicture;
  String? _playerEmail;
  String? _playerPhoneno;
  BookedModel copyWith({
    num? academy,
    num? player,
    bool? paymentStatus,
    List<num>? bookedSession,
    dynamic bookingDate,
    num? playerCount,
    String? bookedDate,
    dynamic location,
    dynamic transactionId,
    dynamic price,
    dynamic currency,
    String? playerName,
    dynamic playerPicture,
    String? playerEmail,
    String? playerPhoneno,
  }) =>
      BookedModel(
        academy: academy ?? _academy,
        player: player ?? _player,
        paymentStatus: paymentStatus ?? _paymentStatus,
        bookedSession: bookedSession ?? _bookedSession,
        bookingDate: bookingDate ?? _bookingDate,
        playerCount: playerCount ?? _playerCount,
        bookedDate: bookedDate ?? _bookedDate,
        location: location ?? _location,
        transactionId: transactionId ?? _transactionId,
        price: price ?? _price,
        currency: currency ?? _currency,
        playerName: playerName ?? _playerName,
        playerPicture: playerPicture ?? _playerPicture,
        playerEmail: playerEmail ?? _playerEmail,
        playerPhoneno: playerPhoneno ?? _playerPhoneno,
      );
  num? get academy => _academy;
  num? get player => _player;
  bool? get paymentStatus => _paymentStatus;
  List<num>? get bookedSession => _bookedSession;
  dynamic get bookingDate => _bookingDate;
  num? get playerCount => _playerCount;
  String? get bookedDate => _bookedDate;
  dynamic get location => _location;
  dynamic get transactionId => _transactionId;
  dynamic get price => _price;
  dynamic get currency => _currency;
  String? get playerName => _playerName;
  dynamic get playerPicture => _playerPicture;
  String? get playerEmail => _playerEmail;
  String? get playerPhoneno => _playerPhoneno;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['academy'] = _academy;
    map['player'] = _player;
    map['payment_status'] = _paymentStatus;
    map['booked_session'] = _bookedSession;
    map['booking_date'] = _bookingDate;
    map['player_count'] = _playerCount;
    map['booked_date'] = _bookedDate;
    map['location'] = _location;
    map['transaction_id'] = _transactionId;
    map['price'] = _price;
    map['currency'] = _currency;
    map['player_name'] = _playerName;
    map['player_picture'] = _playerPicture;
    map['player_email'] = _playerEmail;
    map['player_phoneno'] = _playerPhoneno;
    return map;
  }
}
