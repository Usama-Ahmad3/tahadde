import 'package:json_annotation/json_annotation.dart';
part 'cardDetail.g.dart';

@JsonSerializable(explicitToJson: true)
class CardDetail {
  final List<Files?>? data;
  CardDetail({
    this.data,
  });

  factory CardDetail.fromJson(Map<String, dynamic> json) =>
      _$CardDetailFromJson(json);
  Map<String, dynamic> toJson() => _$CardDetailToJson(this);
}

@JsonSerializable()
class Files {
  final String? id;
  final String? brand;
  final String? country;
  final String? customer;
  final String? last4;
  final int? exp_month;
  final int? exp_year;
  final String? fingerprint;
  final String? name;
  Files(
      {this.id,
      this.brand,
      this.country,
      this.customer,
      this.exp_month,
      this.exp_year,
      this.fingerprint,
      this.last4,
      this.name});
  factory Files.fromJson(Map<String, dynamic> json) => _$FilesFromJson(json);
  Map<String, dynamic> toJson() => _$FilesToJson(this);
}
