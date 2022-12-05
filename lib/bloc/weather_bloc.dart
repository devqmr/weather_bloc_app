import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;

import '../PrivateApiKeys.dart';
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
    // var weather = await _fetchFakeCityWeather(event.cityName);
    var weather =  await _fetchCityWeather(event.cityName);
    emit(WeatherLoaded(weather));
  }

  Future<Weather> _fetchFakeCityWeather(String cityName) {
    return Future.delayed(const Duration(seconds: 1), (() {
      return Weather(
          cityName: cityName,
          temp: 10 + Random().nextInt(25),
      icon: "");
    }));
  }

  Future<Weather> _fetchCityWeather(String cityName) async {

    final queryParameter =  {
    'access_key': WEATHER_ACCESS_KEY, //You need to set your access key, you can get one from https://weatherstack.com/quickstart
    'query': cityName,
    'units': 'm'
    };

    var url = Uri.http('api.weatherstack.com', '/current', queryParameter);

    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    final jsonResponse = jsonDecode(response.body)  as Map<String, dynamic>;

    final temperature = jsonResponse['current']['temperature'];
    final icon = jsonResponse['current']['weather_icons'][0];

    final weather = Weather(cityName: cityName, temp: temperature, icon: icon );

    return Future.delayed(const Duration(seconds: 1), (() {
      return weather;
    }));
  }
}
