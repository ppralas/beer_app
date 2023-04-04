import 'dart:developer';

import 'package:beers/domain/providers/entities/beer.dart';
import 'package:beers/domain/providers/notifiers/beer_state_notifier.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//probati na ovom primjeru napisati repozitorij koji ce imati samo
class BeerListView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(beerValueProvider);

// ne treba mi cijeli scroll controller jer postoji notification lisener
    return Scaffold(
      //tu raspakiravam liniju 11
      body: state.when(
        loaded: (data) => BeerView(
          beers: data,
          isLoading: false,
        ),
        failure: (failure) {
          log(failure.trace.toString());
          return Text(failure.error.toString());
        },
        initial: () {
          return SizedBox();
        },
        loading: (List<Beer> beers) => BeerView(beers: beers, isLoading: true),
      ),
    );
  }
}

class BeerView extends ConsumerWidget {
  final List<Beer> beers;
  final bool isLoading;
  const BeerView({
    required this.beers,
    required this.isLoading,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification.metrics.pixels ==
            notification.metrics.maxScrollExtent) {
          ref.read(beerValueProvider.notifier).getBeer();
        }
        return true;
      },
      child: ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          //zadnji index u listi
          if (index == beers.length) {
            return Center(child: CircularProgressIndicator());
          }
          final item = beers[index];
          return Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                        'assets/images/beer-foam-bubbles-background_186921-100.jpeg'),
                  ),
                ),
                alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/images/beer-bottle.svg',
                      height: MediaQuery.of(context).size.height * 0.2,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      item.brands,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      textAlign: TextAlign.center,
                      item.name,
                      style: TextStyle(
                        fontSize: 10,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      item.alcohol,
                      style: TextStyle(
                        fontSize: 8,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    FloatingActionButton(
                      onPressed: () =>
                          ref.read(beerValueProvider.notifier).getBeer(),
                      child: Icon(Icons.refresh),
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.green,
                    ),
                  ],
                ),
              ),
            ],
          );
        },
        itemCount: beers.length + (isLoading ? 1 : 0),
        separatorBuilder: (BuildContext context, int index) => Divider(),
      ),
    );
  }
}
