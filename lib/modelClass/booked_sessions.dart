class BookedSessions {
  BookedSessions({
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

  BookedSessions.fromJson(dynamic json) {
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
  BookedSessions copyWith({
    num? id,
    bool? holiday,
    String? name,
    String? nameArabic,
    num? slotDuration,
    num? extraSlot,
    String? startTime,
    String? endTime,
  }) =>
      BookedSessions(
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
