import 'package:open_weather_example_flutter/src/features/weather/domain/general/temperature.dart';
import 'package:open_weather_example_flutter/src/features/weather/domain/weather/weather.dart';

class WeatherData {
  WeatherData({
    required this.temp,
    required this.minTemp,
    required this.maxTemp,
  });

  factory WeatherData.from(Weather weather) {
    return WeatherData(
      temp: Temperature.celsius(weather.weatherParams.temp),
      minTemp: Temperature.celsius(weather.weatherParams.tempMin),
      maxTemp: Temperature.celsius(weather.weatherParams.tempMax),
    );
  }

  final Temperature temp;
  final Temperature minTemp;
  final Temperature maxTemp;
}
