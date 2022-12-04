import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../model/weather.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherInitial()) {
    // on<WeatherEvent>((event, emit) {
    //   // TODO: implement event handler
    // });

    on<GetWeather>(_getWeather);
  }

  _getWeather(GetWeather event, Emitter<WeatherState> emit) async {
    emit(WeatherLoading());
    var weather = await _fetchFakeCityWeather(event.cityName);
    emit(WeatherLoaded(weather));
  }

  Future<Weather> _fetchFakeCityWeather(String cityName) {
    return Future.delayed(const Duration(seconds: 1), (() {
      return Weather(
          cityName: cityName,
          temp: 10 + Random().nextInt(25) + Random().nextDouble());
    }));
  }
}
