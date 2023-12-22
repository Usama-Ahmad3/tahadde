class InnovativeBookingsModel {
  InnovativeBookingsModel({
    num? inovativehub,
    String? inovativehubName,
    String? inovativehubNameArabic,
    String? inovativehubImage,
    num? player,
    bool? paymentStatus,
    List<num>? bookedSession,
    String? bookingDate,
    num? playerCount,
    String? bookedDate,
    String? location,
    String? transactionId,
    String? price,
    String? currency,
    String? playerName,
    dynamic playerPicture,
    String? playerEmail,
    dynamic playerPhoneno,
  }) {
    _inovativehub = inovativehub;
    _inovativehubName = inovativehubName;
    _inovativehubNameArabic = inovativehubNameArabic;
    _inovativehubImage = inovativehubImage;
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

  InnovativeBookingsModel.fromJson(dynamic json) {
    _inovativehub = json['inovativehub'];
    _inovativehubName = json['inovativehub_name'];
    _inovativehubNameArabic = json['inovativehub_name_arabic'];
    _inovativehubImage = json['inovativehub_image'];
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
  num? _inovativehub;
  String? _inovativehubName;
  String? _inovativehubNameArabic;
  String? _inovativehubImage;
  num? _player;
  bool? _paymentStatus;
  List<num>? _bookedSession;
  String? _bookingDate;
  num? _playerCount;
  String? _bookedDate;
  String? _location;
  String? _transactionId;
  String? _price;
  String? _currency;
  String? _playerName;
  dynamic _playerPicture;
  String? _playerEmail;
  dynamic _playerPhoneno;
  InnovativeBookingsModel copyWith({
    num? inovativehub,
    String? inovativehubName,
    String? inovativehubNameArabic,
    String? inovativehubImage,
    num? player,
    bool? paymentStatus,
    List<num>? bookedSession,
    String? bookingDate,
    num? playerCount,
    String? bookedDate,
    String? location,
    String? transactionId,
    String? price,
    String? currency,
    String? playerName,
    dynamic playerPicture,
    String? playerEmail,
    dynamic playerPhoneno,
  }) =>
      InnovativeBookingsModel(
        inovativehub: inovativehub ?? _inovativehub,
        inovativehubName: inovativehubName ?? _inovativehubName,
        inovativehubNameArabic:
            inovativehubNameArabic ?? _inovativehubNameArabic,
        inovativehubImage: inovativehubImage ?? _inovativehubImage,
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
  num? get inovativehub => _inovativehub;
  String? get inovativehubName => _inovativehubName;
  String? get inovativehubNameArabic => _inovativehubNameArabic;
  String? get inovativehubImage => _inovativehubImage;
  num? get player => _player;
  bool? get paymentStatus => _paymentStatus;
  List<num>? get bookedSession => _bookedSession;
  String? get bookingDate => _bookingDate;
  num? get playerCount => _playerCount;
  String? get bookedDate => _bookedDate;
  String? get location => _location;
  String? get transactionId => _transactionId;
  String? get price => _price;
  String? get currency => _currency;
  String? get playerName => _playerName;
  dynamic get playerPicture => _playerPicture;
  String? get playerEmail => _playerEmail;
  dynamic get playerPhoneno => _playerPhoneno;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['inovativehub'] = _inovativehub;
    map['inovativehub_name'] = _inovativehubName;
    map['inovativehub_name_arabic'] = _inovativehubNameArabic;
    map['inovativehub_image'] = _inovativehubImage;
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
