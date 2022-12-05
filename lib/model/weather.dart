import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Weather extends Equatable {
  final String cityName;
  final int temp;
  final String icon;

  const Weather(
      {required this.cityName, required this.temp, required this.icon});

  @override
  List<Object?> get props => [cityName, temp];
}
