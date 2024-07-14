import 'package:open_weather_example_flutter/src/features/weather/domain/general/temperature.dart';
import 'package:open_weather_example_flutter/src/features/weather/domain/weather/weather.dart';

class WeatherData {
  final Temperature temp;
  final Temperature minTemp;
  final Temperature maxTemp;
  final String icon;
  final int date;

  WeatherData({
    required this.temp,
    required this.minTemp,
    required this.maxTemp,
    required this.icon,
    required this.date,
  });

  factory WeatherData.from(Weather weather) {
    return WeatherData(
      temp: Temperature.celsius(weather.weatherParams.temp),
      minTemp: Temperature.celsius(weather.weatherParams.tempMin),
      maxTemp: Temperature.celsius(weather.weatherParams.tempMax),
      icon: weather.weatherInfo[0].icon,
      date: weather.dt,
    );
  }

  String get iconUrl => "https://openweathermap.org/img/wn/$icon@2x.png";

  DateTime get dateTime => DateTime.fromMillisecondsSinceEpoch(date * 1000);
}
