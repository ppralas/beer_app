// import 'dart:developer';

// import 'package:beers/domain/providers/notifiers/beer_state_notifier.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// //probati na ovom primjeru napisati repozitorij koji ce imati samo

// class BeerPresentation extends ConsumerWidget {
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final state = ref.watch(beerValueProvider);

//     return Scaffold(
//       //tu raspakiravam liniju 11
//       body: state.when(
//         loaded: (data) => Stack(
//           children: <Widget>[
//             Container(
//               decoration: BoxDecoration(
//                 image: DecorationImage(
//                   fit: BoxFit.cover,
//                   image: AssetImage(
//                       'assets/images/beer-foam-bubbles-background_186921-100.jpeg'),
//                 ),
//               ),
//               alignment: Alignment.center,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   SvgPicture.asset(
//                     'assets/images/beer-bottle.svg',
//                     height: MediaQuery.of(context).size.height * 0.2,
//                   ),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   Text(
//                     data.brands,
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   Text(
//                     textAlign: TextAlign.center,
//                     data.name,
//                     style: TextStyle(
//                       fontSize: 10,
//                     ),
//                   ),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   Text(
//                     data.alcohol,
//                     style: TextStyle(
//                       fontSize: 8,
//                     ),
//                   ),
//                   SizedBox(
//                     height: 30,
//                   ),
//                   FloatingActionButton(
//                     onPressed: () =>
//                         ref.read(beerValueProvider.notifier).getBeer(),
//                     child: Icon(Icons.refresh),
//                     backgroundColor: Colors.white,
//                     foregroundColor: Colors.green,
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//         failure: (failure) {
//           log(failure.trace.toString());
//           return Text(failure.error.toString());
//         },
//         loading: (() => Center(child: CircularProgressIndicator())),
//         initial: () {
//           return SizedBox();
//         },
//       ),
//     );
//   }
// }
