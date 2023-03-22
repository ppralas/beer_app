// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BeerResponse _$BeerResponseFromJson(Map<String, dynamic> json) => BeerResponse(
      json['brand'] as String,
      json['alcohol'] as String,
      json['name'] as String,
    );

Map<String, dynamic> _$BeerResponseToJson(BeerResponse instance) =>
    <String, dynamic>{
      'brand': instance.brand,
      'alcohol': instance.alcohol,
      'name': instance.name,
    };
