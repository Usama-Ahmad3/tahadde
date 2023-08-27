class SessionResponse {
  final List<SlotDetail?>? slotDetail;
  final String? weekday;
  final String? session_name;
  final String? sub_pitch;
  final String?  sports;
  SessionResponse(
      {this.weekday,
        this.session_name,
        this.slotDetail,
        this.sub_pitch,
        this.sports
        });
  factory SessionResponse.fromJson(Map<String, dynamic> json) {
    return SessionResponse(
      weekday: json["weekday"],
      session_name: json["session_name"],
      sub_pitch: json["sub_pitch"],
      sports: json["sports"],
      slotDetail: (json['slots_details'] as List)
        .map((e) =>
    e == null ? null : SlotDetail.fromJson(e as Map<String, dynamic>))
        .toList(),
    );
  }
}

class SlotDetail {
  final int? id;
  final int? subPitchId;
  final String? startTime;
  final int? sport_slot_time;
  final String? session_name;
  final double? pricePerPlayer;
  final double? venuePrice;
  SlotDetail({ this.id,this.subPitchId, this.startTime,this.sport_slot_time,this.session_name,this.pricePerPlayer,this.venuePrice});
  factory SlotDetail.fromJson(Map json) {
    return SlotDetail(
        id: json['id'],
        subPitchId:json['sub_pitch']["id"],
        startTime: json['startTime'],
        sport_slot_time: json['sport_slot_time'],
        session_name: json['session_name'],
       pricePerPlayer:json['slot_price_per_player'],
       venuePrice:json['slot_price_per_pitch'],);
  }
}


