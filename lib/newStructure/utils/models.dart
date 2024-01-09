class DocumentModel {
  int? documentImageId;
  String? documentName;
  String? licenceNumber;
  String? expiryDate;
  String? address;
  double? lat;
  double? long;
  String? country;
  DocumentModel(
      {this.documentImageId,
      this.address,
      this.documentName,
      this.expiryDate,
      this.lat,
      this.long,
      this.licenceNumber,
      this.country});
}

class PitchDetailModel {
  List<dynamic>? pitchImageId;
  String? pitchName;
  String? pitchNameAr;
  String? description;
  String? descriptionAr;
  String? code;
  String? gamePlay;
  String? facility;
  PitchDetailModel(
      {this.pitchImageId,
      this.description,
      this.code,
      this.descriptionAr,
      this.facility,
      this.gamePlay,
      this.pitchName,
      this.pitchNameAr});
}

class SportsList {
  final String? name;
  final String? nameArabic;
  final String? image;
  final String? bannerImage;
  final String? slug;
  SportsList(
      {this.name, this.nameArabic, this.image, this.slug, this.bannerImage});
}

class SignUpDetail {
  String? email;
  String? firstName;
  String? lastName;
  String? password;
  String? phoneNumber;
  String? fcmToken;
  String? countryCode;
  String? deviceType;
  String? dob;
  String? gender;
  String? id;

  SignUpDetail(
      {this.email,
      this.password,
      this.firstName,
      this.lastName,
      this.phoneNumber,
      this.deviceType,
      this.fcmToken,
      this.dob,
      this.id,
      this.gender = "Male",
      this.countryCode = "+971"});
}
