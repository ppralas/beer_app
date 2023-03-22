import 'package:json_annotation/json_annotation.dart';

part 'model.g.dart';

@JsonSerializable()
class BeerResponse {
  final String brand;
  final String alcohol;
  final String name;

  BeerResponse(this.brand, this.alcohol, this.name);

  factory BeerResponse.fromJson(Map<String, dynamic> json) =>
      _$BeerResponseFromJson(json);
}
