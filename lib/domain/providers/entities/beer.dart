import 'package:equatable/equatable.dart';

class Beer extends Equatable {
  final String brands;
  final String alcohol;
  final String name;

  Beer(this.brands, this.alcohol, this.name);

  @override
  List<Object?> get props => [brands, alcohol, name];
}
