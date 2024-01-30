class AcademySessionCount {
  AcademySessionCount({
    String? sessionId,
    String? currentDate,
    List<DateStats>? dateStats,
  }) {
    _sessionId = sessionId;
    _currentDate = currentDate;
    _dateStats = dateStats;
  }

  AcademySessionCount.fromJson(dynamic json) {
    _sessionId = json['session_id'];
    _currentDate = json['current_date'];
    if (json['date_stats'] != null) {
      _dateStats = [];
      json['date_stats'].forEach((v) {
        _dateStats?.add(DateStats.fromJson(v));
      });
    }
  }
  String? _sessionId;
  String? _currentDate;
  List<DateStats>? _dateStats;
  AcademySessionCount copyWith({
    String? sessionId,
    String? currentDate,
    List<DateStats>? dateStats,
  }) =>
      AcademySessionCount(
        sessionId: sessionId ?? _sessionId,
        currentDate: currentDate ?? _currentDate,
        dateStats: dateStats ?? _dateStats,
      );
  String? get sessionId => _sessionId;
  String? get currentDate => _currentDate;
  List<DateStats>? get dateStats => _dateStats;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['session_id'] = _sessionId;
    map['current_date'] = _currentDate;
    if (_dateStats != null) {
      map['date_stats'] = _dateStats?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class DateStats {
  DateStats({
    String? date,
    num? bookedPlayers,
    num? cartPlayers,
    num? yourBooking,
    num? remainingSlots,
  }) {
    _date = date;
    _bookedPlayers = bookedPlayers;
    _cartPlayers = cartPlayers;
    _yourBooking = yourBooking;
    _remainingSlots = remainingSlots;
  }

  DateStats.fromJson(dynamic json) {
    _date = json['date'];
    _bookedPlayers = json['booked_players'];
    _cartPlayers = json['cart_players'];
    _yourBooking = json['your_booking'];
    _remainingSlots = json['remaining_slots'];
  }
  String? _date;
  num? _bookedPlayers;
  num? _cartPlayers;
  num? _yourBooking;
  num? _remainingSlots;
  DateStats copyWith({
    String? date,
    num? bookedPlayers,
    num? cartPlayers,
    num? yourBooking,
    num? remainingSlots,
  }) =>
      DateStats(
        date: date ?? _date,
        bookedPlayers: bookedPlayers ?? _bookedPlayers,
        cartPlayers: cartPlayers ?? _cartPlayers,
        yourBooking: yourBooking ?? _yourBooking,
        remainingSlots: remainingSlots ?? _remainingSlots,
      );
  String? get date => _date;
  num? get bookedPlayers => _bookedPlayers;
  num? get cartPlayers => _cartPlayers;
  num? get yourBooking => _yourBooking;
  num? get remainingSlots => _remainingSlots;
  setRemainingSlots(int value) {
    _remainingSlots = _remainingSlots! + value;
  }

  setRemainingSlotsMinus(int value) {
    _remainingSlots = _remainingSlots! - value;
  }
  totalRemainingSlotsMinus(int value) {
    _remainingSlots =  value;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['date'] = _date;
    map['booked_players'] = _bookedPlayers;
    map['cart_players'] = _cartPlayers;
    map['your_booking'] = _yourBooking;
    map['remaining_slots'] = _remainingSlots;
    return map;
  }
}
