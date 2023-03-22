import 'package:beers/data/beer_values.dart';
import 'package:beers/data/mappers/mapper.dart';
import 'package:beers/data/model/model.dart';
import 'package:beers/domain/providers/entities/beer.dart';
import 'package:beers/domain/providers/entities/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:riverpod/riverpod.dart';

final beerRepositoryProvider = Provider(((ref) => BeerRepositoryImpl(
      ref.watch(apiClient),
      ref.watch(beersEntityMapperProvider),
    )));

abstract class BeerRepository {
  Future<Either<Failure, List<Beer>>>getBeer();
}

class BeerRepositoryImpl implements BeerRepository {
  final BeerValuesApiClient beerApi;
  final EntityMapper<Beer, BeerResponse> mapper;

  BeerRepositoryImpl(this.beerApi, this.mapper);

  @override
  Future<Either<Failure, List<Beer>>> getBeer() async {
    try {
      final beers = await beerApi.getBeer();
      return right(beers.map((e) => mapper(e)).toList());
    } catch (error, StackTrace) {
      return left(Failure(error, StackTrace));
    }
  }
}
