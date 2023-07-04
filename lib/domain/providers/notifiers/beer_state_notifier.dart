import 'package:beers/data/repository.dart';
import 'package:beers/domain/providers/entities/beer.dart';
import 'package:beers/domain/providers/notifiers/beer_state.dart';
import 'package:riverpod/riverpod.dart';

//Tu kazem koji notifier koristim i koji state koristim
final beerValueProvider = StateNotifierProvider<BeerStateNotifier, BeerState>(
    // .. posebno u Dartu, kao da sam napravio 2 linije koda returnam BeerStateNotifier zajedno sa metodom getBeer(); tj. vracam i objekt i metodu kad imam 2 tocke  s
    // code secer, nemaju to svi jezici
    (ref) => BeerStateNotifier(ref.watch(beerRepositoryProvider))..getBeers());
//tu se prvi put pozove

//tip state notifiera je je beer state
class BeerStateNotifier extends StateNotifier<BeerState> {
  final BeerRepository _beerRepository;
  List<Beer> _cachedBeers = [];

  BeerStateNotifier(this._beerRepository) : super(BeerState.initial());

  void getBeers() async {
    if (state.whenOrNull(loading: (_) => true) == true) {
      return;
    }

    state = BeerState.loading(_cachedBeers);

    final result = await _beerRepository.getBeers();

    result.fold(
      (error) => state = BeerState.failure(error),
      (newBeers) {
        _cachedBeers.addAll(newBeers);
        state = BeerState.loaded(_cachedBeers);
      },
    );
  }
}
