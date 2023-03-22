import 'package:beers/data/model/model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:riverpod/riverpod.dart';

part 'beer_values.g.dart';

final apiClient = Provider((ref) => BeerValuesApiClient(Dio()));

@RestApi(baseUrl: "https://random-data-api.com/api/v2")
abstract class BeerValuesApiClient {
  factory BeerValuesApiClient(Dio dio, {String baseUrl}) = _BeerValuesApiClient;

  @GET('/beers?size=3')
  Future<List<BeerResponse>> getBeer();
}
