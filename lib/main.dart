import 'package:beers/presentation/beer_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BeerListView(),
    );
  }
}

//tream watchat provider state.when(ponudeni initial itd iz beerstatea i onda dodajem widgete koji mi trebaju progress il nesesto, falirure greska u nekom textu, za loaded podatak o pivici)




//napravio sam custom state i ako treba vise metoda lakse je za state notifier providerom 