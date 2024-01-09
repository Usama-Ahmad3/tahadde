class AcademyReport {
  AcademyReport({
    num? academyId,
    String? academyName,
    String? academyNameArabic,
    String? academyLocation,
    List? academyPic,
    num? totalBookings,
    num? totalProfit,
    MostBookedSession? mostBookedSession,
    num? commission,
    num? tax,
  }) {
    _academyId = academyId;
    _academyName = academyName;
    _academyNameArabic = academyNameArabic;
    _academyLocation = academyLocation;
    _academyPic = academyPic;
    _totalBookings = totalBookings;
    _totalProfit = totalProfit;
    _mostBookedSession = mostBookedSession;
    _commission = commission;
    _tax = tax;
  }

  AcademyReport.fromJson(dynamic json) {
    _academyId = json['academy_id'];
    _academyName = json['academy_name'];
    _academyNameArabic = json['academy_nameArabic'];
    _academyLocation = json['academy_location'];
    _academyPic =
        json['academy_pic'] != null ? json['academy_pic'].cast<String>() : [];
    _totalBookings = json['total_bookings'];
    _totalProfit = json['total_profit'];
    _mostBookedSession = json['most_booked_session'] != null
        ? MostBookedSession.fromJson(json['most_booked_session'])
        : null;
    _commission = json['commission'];
    _tax = json['tax'];
  }
  num? _academyId;
  String? _academyName;
  String? _academyNameArabic;
  String? _academyLocation;
  List? _academyPic;
  num? _totalBookings;
  num? _totalProfit;
  MostBookedSession? _mostBookedSession;
  num? _commission;
  num? _tax;
  AcademyReport copyWith({
    num? academyId,
    String? academyName,
    String? academyNameArabic,
    String? academyLocation,
    List? academyPic,
    num? totalBookings,
    num? totalProfit,
    MostBookedSession? mostBookedSession,
    num? commission,
    num? tax,
  }) =>
      AcademyReport(
        academyId: academyId ?? _academyId,
        academyName: academyName ?? _academyName,
        academyNameArabic: academyNameArabic ?? _academyNameArabic,
        academyLocation: academyLocation ?? _academyLocation,
        academyPic: academyPic ?? _academyPic,
        totalBookings: totalBookings ?? _totalBookings,
        totalProfit: totalProfit ?? _totalProfit,
        mostBookedSession: mostBookedSession ?? _mostBookedSession,
        commission: commission ?? _commission,
        tax: tax ?? _tax,
      );
  num? get academyId => _academyId;
  String? get academyName => _academyName;
  String? get academyNameArabic => _academyNameArabic;
  String? get academyLocation => _academyLocation;
  List? get academyPic => _academyPic;
  num? get totalBookings => _totalBookings;
  num? get totalProfit => _totalProfit;
  MostBookedSession? get mostBookedSession => _mostBookedSession;
  num? get commission => _commission;
  num? get tax => _tax;

  Map<dynamic, dynamic> toJson() {
    final map = <dynamic, dynamic>{};
    map['academy_id'] = _academyId;
    map['academy_name'] = _academyName;
    map['academy_nameArabic'] = _academyNameArabic;
    map['academy_location'] = _academyLocation;
    map['academy_pic'] = _academyPic;
    map['total_bookings'] = _totalBookings;
    map['total_profit'] = _totalProfit;
    if (_mostBookedSession != null) {
      map['most_booked_session'] = _mostBookedSession?.toJson();
    }
    map['commission'] = _commission;
    map['tax'] = _tax;
    return map;
  }
}

class MostBookedSession {
  MostBookedSession({
    num? id,
    String? sessionName,
    String? arabicName,
    num? slotDuration,
    dynamic slotPrice,
    String? startTime,
    String? endTime,
    String? weekday,
  }) {
    _id = id;
    _sessionName = sessionName;
    _arabicName = arabicName;
    _slotDuration = slotDuration;
    _slotPrice = slotPrice;
    _startTime = startTime;
    _endTime = endTime;
    _weekday = weekday;
  }

  MostBookedSession.fromJson(dynamic json) {
    _id = json['id'];
    _sessionName = json['SessionName'];
    _arabicName = json['ArabicName'];
    _slotDuration = json['SlotDuration'];
    _slotPrice = json['SlotPrice'];
    _startTime = json['StartTime'];
    _endTime = json['EndTime'];
    _weekday = json['Weekday'];
  }
  num? _id;
  String? _sessionName;
  String? _arabicName;
  num? _slotDuration;
  dynamic _slotPrice;
  String? _startTime;
  String? _endTime;
  String? _weekday;
  MostBookedSession copyWith({
    num? id,
    String? sessionName,
    String? arabicName,
    num? slotDuration,
    dynamic slotPrice,
    String? startTime,
    String? endTime,
    String? weekday,
  }) =>
      MostBookedSession(
        id: id ?? _id,
        sessionName: sessionName ?? _sessionName,
        arabicName: arabicName ?? _arabicName,
        slotDuration: slotDuration ?? _slotDuration,
        slotPrice: slotPrice ?? _slotPrice,
        startTime: startTime ?? _startTime,
        endTime: endTime ?? _endTime,
        weekday: weekday ?? _weekday,
      );
  num? get id => _id;
  String? get sessionName => _sessionName;
  String? get arabicName => _arabicName;
  num? get slotDuration => _slotDuration;
  dynamic get slotPrice => _slotPrice;
  String? get startTime => _startTime;
  String? get endTime => _endTime;
  String? get weekday => _weekday;

  Map<dynamic, dynamic> toJson() {
    final map = <dynamic, dynamic>{};
    map['id'] = _id;
    map['SessionName'] = _sessionName;
    map['ArabicName'] = _arabicName;
    map['SlotDuration'] = _slotDuration;
    map['SlotPrice'] = _slotPrice;
    map['StartTime'] = _startTime;
    map['EndTime'] = _endTime;
    map['Weekday'] = _weekday;
    return map;
  }
}
