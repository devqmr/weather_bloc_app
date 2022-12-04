
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Weather extends Equatable{
  final String cityName;
  final double temp;

  const Weather({required this.cityName, required this.temp});
  
  @override
  List<Object?> get props => [cityName,temp];
}