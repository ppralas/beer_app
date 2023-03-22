import 'package:beers/domain/providers/entities/beer.dart';
import 'package:beers/domain/providers/entities/failure.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'beer_state.freezed.dart';

@freezed
class BeerState with _$BeerState {
  //definirat koje cu imati stateove,
  const factory BeerState.initial() = _Initial;
  const factory BeerState.loading(List<Beer> beers) = _Loading;
  const factory BeerState.failure(Failure failure) = _Failure;
  const factory BeerState.loaded(List<Beer> beers) = _Loaded;
}

//nakon sto ovo napisem build runner pokrenuti kako bi se izgenerirao .freezed dart 
