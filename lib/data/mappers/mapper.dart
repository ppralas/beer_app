import 'package:beers/data/model/model.dart';
import 'package:beers/domain/providers/entities/beer.dart';
import 'package:riverpod/riverpod.dart';

//ovaj Response u Entity Function(Response) je zapravo T
typedef EntityMapper<Entity, Response> = Entity Function(Response);

final beersEntityMapperProvider = Provider<EntityMapper<Beer, BeerResponse>>(
    ((ref) =>
        (response) => Beer(response.brand, response.alcohol, response.name)));


//napraviti paginaciju
