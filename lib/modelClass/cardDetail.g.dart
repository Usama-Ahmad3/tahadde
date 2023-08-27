// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cardDetail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CardDetail _$CardDetailFromJson(Map<String, dynamic> json) {
  return CardDetail(
    data: (json['data'] as List)
        ?.map(
            (e) => e == null ? null : Files.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$CardDetailToJson(CardDetail instance) =>
    <String, dynamic>{
      'data': instance.data?.map((e) => e?.toJson())?.toList(),
    };

Files _$FilesFromJson(Map<String, dynamic> json) {
  return Files(
    id: json['id'] as String,
    brand: json['brand'] as String,
    country: json['country'] as String,
    customer: json['customer'] as String,
    exp_month: json['exp_month'] as int,
    exp_year: json['exp_year'] as int,
    fingerprint: json['fingerprint'] as String,
    last4: json['last4'] as String,
    name: json['name'] as String,
  );
}

Map<String, dynamic> _$FilesToJson(Files instance) => <String, dynamic>{
      'id': instance.id,
      'brand': instance.brand,
      'country': instance.country,
      'customer': instance.customer,
      'last4': instance.last4,
      'exp_month': instance.exp_month,
      'exp_year': instance.exp_year,
      'fingerprint': instance.fingerprint,
      'name': instance.name,
    };
