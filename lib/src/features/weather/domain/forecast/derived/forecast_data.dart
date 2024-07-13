import 'package:open_weather_example_flutter/src/features/weather/domain/forecast/forecast.dart';
import 'package:open_weather_example_flutter/src/features/weather/domain/weather/derived/weather_data.dart';

class ForecastData {
  const ForecastData(this.list);

  factory ForecastData.from(Forecast forecast) {
    return ForecastData(
      forecast.list
          .map((item) => WeatherData.from(
                item,
              ))
          .toList(),
    );
  }

  final List<WeatherData> list;
}
