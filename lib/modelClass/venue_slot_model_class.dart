class SlotModelClass{
  final String? sports;
final String? sessionName;
final List<SlotDetail?>? slotDetail;
SlotModelClass({ this.slotDetail,this.sessionName,this.sports});
factory SlotModelClass.fromJson(Map<String, dynamic> json) {
  return SlotModelClass(
    sessionName: json["session_name"],
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
  final String? startTime;
  final int? sportSlotTime;
  final int? graceTime;
  final bool? isAvailable;
  final bool? isBooked;
  final double? slotPrice;
  final double? slotPlayerPrice;
  final bool? bookedVenue;
  final bool? bookedPlayer;
  final int? maximumPlayers;
  final int? bookedPlayersCount;
  SlotDetail({ this.id, this.startTime,this.sportSlotTime,this.graceTime,this.isBooked,this.isAvailable,this.slotPrice,this.bookedPlayer,this.bookedPlayersCount,this.bookedVenue,this.maximumPlayers,this.slotPlayerPrice});
  factory SlotDetail.fromJson(Map json) {
    return SlotDetail(
      id: json['id'],
      startTime: json['startTime'],
      sportSlotTime: json['sport_slot_time'],
      graceTime: json["grace_time"],
      isAvailable: json["slot_not_available"],
      isBooked: json["is_booked"],
      slotPrice: json["slot_price_per_pitch"],
      slotPlayerPrice: json["slot_price_per_player"],
      bookedVenue: json["booked_per_venue"],
      bookedPlayer: json["booked_price_per_player"],
      maximumPlayers: json["maximum_allowed_players"],
      bookedPlayersCount: json["booked_players_count"],
      );
  }
}