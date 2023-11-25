class PlayerBookings {
  PlayerBookings({
    num? totalBookings,
    List<Bookings>? bookings,
  }) {
    _totalBookings = totalBookings;
    _bookings = bookings;
  }

  PlayerBookings.fromJson(dynamic json) {
    _totalBookings = json['total_bookings'];
    if (json['bookings'] != null) {
      _bookings = [];
      json['bookings'].forEach((v) {
        _bookings?.add(Bookings.fromJson(v));
      });
    }
  }
  num? _totalBookings;
  List<Bookings>? _bookings;
  PlayerBookings copyWith({
    num? totalBookings,
    List<Bookings>? bookings,
  }) =>
      PlayerBookings(
        totalBookings: totalBookings ?? _totalBookings,
        bookings: bookings ?? _bookings,
      );
  num? get totalBookings => _totalBookings;
  List<Bookings>? get bookings => _bookings;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['total_bookings'] = _totalBookings;
    if (_bookings != null) {
      map['bookings'] = _bookings?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Bookings {
  Bookings({
    num? academy,
    String? academyName,
    String? academyNameArabic,
    List<String>? academyPics,
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
    String? playerPicture,
    String? playerEmail,
    String? playerPhoneno,
  }) {
    _academy = academy;
    _academyName = academyName;
    _academyNameArabic = academyNameArabic;
    _academyPics = academyPics;
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

  Bookings.fromJson(dynamic json) {
    _academy = json['academy'];
    _academyName = json['academy_name'];
    _academyNameArabic = json['academy_name_arabic'];
    _academyPics =
        json['academy_pics'] != null ? json['academy_pics'].cast<String>() : [];
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
  String? _academyName;
  String? _academyNameArabic;
  List<String>? _academyPics;
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
  String? _playerPicture;
  String? _playerEmail;
  String? _playerPhoneno;
  Bookings copyWith({
    num? academy,
    String? academyName,
    String? academyNameArabic,
    List<String>? academyPics,
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
    String? playerPicture,
    String? playerEmail,
    String? playerPhoneno,
  }) =>
      Bookings(
        academy: academy ?? _academy,
        academyName: academyName ?? _academyName,
        academyNameArabic: academyNameArabic ?? _academyNameArabic,
        academyPics: academyPics ?? _academyPics,
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
  String? get academyName => _academyName;
  String? get academyNameArabic => _academyNameArabic;
  List<String>? get academyPics => _academyPics;
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
  String? get playerPicture => _playerPicture;
  String? get playerEmail => _playerEmail;
  String? get playerPhoneno => _playerPhoneno;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['academy'] = _academy;
    map['academy_name'] = _academyName;
    map['academy_name_arabic'] = _academyNameArabic;
    map['academy_pics'] = _academyPics;
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
