class PlayerRating {
  PlayerRating({
    num? user,
    String? userName,
    String? profilePicture,
    String? review,
    num? rating,
    num? academy,
    String? createdAt,
  }) {
    _user = user;
    _userName = userName;
    _profilePicture = profilePicture;
    _review = review;
    _rating = rating;
    _academy = academy;
    _createdAt = createdAt;
  }

  PlayerRating.fromJson(dynamic json) {
    _user = json['user'];
    _profilePicture = json['profile_picture'];
    _userName = json['user_name'];
    _review = json['review'];
    _rating = json['rating'];
    _academy = json['academy'];
    _createdAt = json['created_at'];
  }
  num? _user;
  String? _userName;
  String? _profilePicture;
  String? _review;
  num? _rating;
  num? _academy;
  String? _createdAt;
  PlayerRating copyWith({
    num? user,
    String? userName,
    String? profilePicture,
    String? review,
    num? rating,
    num? academy,
    String? createdAt,
  }) =>
      PlayerRating(
        user: user ?? _user,
        userName: userName ?? _userName,
        profilePicture: profilePicture ?? _profilePicture,
        review: review ?? _review,
        rating: rating ?? _rating,
        academy: academy ?? _academy,
        createdAt: createdAt ?? _createdAt,
      );
  num? get user => _user;
  String? get userName => _userName;
  String? get profilePicture => _profilePicture;
  String? get review => _review;
  num? get rating => _rating;
  num? get academy => _academy;
  String? get createdAt => _createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user'] = _user;
    map['user_name'] = _userName;
    map['profile_picture'] = _profilePicture;
    map['review'] = _review;
    map['rating'] = _rating;
    map['academy'] = _academy;
    map['created_at'] = _createdAt;
    return map;
  }
}
