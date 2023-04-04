import 'package:beers/data/repository.dart';
import 'package:beers/domain/providers/notifiers/beer_state.dart';
import 'package:riverpod/riverpod.dart';

//Tu kazem koji notifier koristim i koji state koristim
final beerValueProvider = StateNotifierProvider<BeerStateNotifier, BeerState>(
    // .. posebno u Dartu, kao da sam napravio 2 linije koda returnam BeerStateNotifier zajedno sa metodom getBeer(); tj. vracam i objekt i metodu kad imam 2 tocke  s
    // code secer, nemaju to svi jezici
    (ref) => BeerStateNotifier(ref.watch(beerRepositoryProvider))..getBeer());
//tu se prvi put pozove

//tip state notifiera je je beer state
class BeerStateNotifier extends StateNotifier<BeerState> {
  final BeerRepository _beerRepository;

  BeerStateNotifier(this._beerRepository) : super(BeerState.initial());
  //prilikom kreiranja dajem mu pocetni state
  //dodavanje repozitorija, potreban dependency za api klijent
  //notifier dohvaca podatke s apija il bilo cega i to postavlja u state i on slusa UI

  //napraviti metodu - getBeer(); i notifier ne smije znati od kud sljedece dolazi
  //repo se brine od kud podatak dolazi a notifier se brine da podatak dode
  void getBeer() async {
    if (state.whenOrNull(
          //state se mora uspredivati na ovaj nacin jer dolazi iz izgeneriranog file-a
          loading: (_) => true,
        ) ==
        true) {
      return;
    }
    //ako se korisit first fetch onda predajem kao parametar, a ako se zove iz scroll controlera onda ce vrijednost biti false
    //await koristim zbog futurea
    //korstim loading da se pokaze loading dok se podaci ucitavaju!

    state = BeerState.loading(state.maybeWhen(
      loaded: (beers) => beers,
      orElse: () {
        return List.empty();
      },
    ));
    //moram spremiti dodatni state u drugu varijablu u notifieru il beerstate.loading dodati parametar koji sadrzi listu i zbrojim liste
    final result = await _beerRepository.getBeer();
    //raspakiravanje rezultata
    result.fold(
      (error) => state = BeerState.failure(error),
      (beer) => state = BeerState.loaded(
        state.maybeWhen(
          loading: (beers) => beers + beer,
          orElse: () {
            return beer;
          },
        ),
      ),
    );
  }
  //uz listu koju imam trebam dodati novu listu s apija
  // u get beer trebam predati flag jel se zove prvi put il ne
  //ovo se radi (either) da se ne moramo baviti lovljenjem exceptiona ne moram imati try catch i cisci je kod :D koji god se desi error onda ce bit ulovljen i pretvorit ce se u left i ne mora se hendlat puno previse slucajeva
}
