class AvalaibleSlots {
  AvalaibleSlots({
    String? message,
    num? academyId,
    num? totalSessions,
    num? bookedSessions,
    num? remainingSessions,
  }) {
    _message = message;
    _academyId = academyId;
    _totalSessions = totalSessions;
    _bookedSessions = bookedSessions;
    _remainingSessions = remainingSessions;
  }

  AvalaibleSlots.fromJson(dynamic json) {
    _message = json['message'];
    _academyId = json['academy_id'];
    _totalSessions = json['total_sessions'];
    _bookedSessions = json['booked_sessions'];
    _remainingSessions = json['remaining_sessions'];
  }
  String? _message;
  num? _academyId;
  num? _totalSessions;
  num? _bookedSessions;
  num? _remainingSessions;
  AvalaibleSlots copyWith({
    String? message,
    num? academyId,
    num? totalSessions,
    num? bookedSessions,
    num? remainingSessions,
  }) =>
      AvalaibleSlots(
        message: message ?? _message,
        academyId: academyId ?? _academyId,
        totalSessions: totalSessions ?? _totalSessions,
        bookedSessions: bookedSessions ?? _bookedSessions,
        remainingSessions: remainingSessions ?? _remainingSessions,
      );
  String? get message => _message;
  num? get academyId => _academyId;
  num? get totalSessions => _totalSessions;
  num? get bookedSessions => _bookedSessions;
  num? get remainingSessions => _remainingSessions;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = _message;
    map['academy_id'] = _academyId;
    map['total_sessions'] = _totalSessions;
    map['booked_sessions'] = _bookedSessions;
    map['remaining_sessions'] = _remainingSessions;
    return map;
  }
}
