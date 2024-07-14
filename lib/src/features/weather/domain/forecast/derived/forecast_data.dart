import 'package:flutter/foundation.dart';
import 'package:open_weather_example_flutter/src/features/weather/domain/forecast/forecast.dart';
import 'package:open_weather_example_flutter/src/features/weather/domain/weather/derived/weather_data.dart';

class ForecastData {
  final List<WeatherData> list;

  const ForecastData(
    this.list,
  );

  factory ForecastData.from(Forecast forecast) {
    return ForecastData(
      forecast.list
          .map((item) => WeatherData.from(
                item,
              ))
          .toList(),
    );
  }
}

extension ForecastDataExtension on ForecastData {
  ForecastData byDay() {
    final groupedByDay = <int, List<WeatherData>>{};
    final List<WeatherData> selectedData = [];

    // Group by day
    try {
      for (var weatherData in list) {
        int day = weatherData.dateTime.day;

        if (!groupedByDay.containsKey(day)) {
          groupedByDay[day] = [];
        }
        groupedByDay[day]!.add(weatherData);
      }

      // Take the first item if `day` is today
      // Otherwise take the item correlating to midday if it exists, and
      // default to the last available item
      groupedByDay.forEach((day, data) {
        if (data.isNotEmpty) {
          if (day == DateTime.now().day) {
            selectedData.add(data.first);
          } else {
            final itemToAdd = data.length >= 5 ? data[4] : data.last;

            if (!selectedData.contains(itemToAdd)) {
              selectedData.add(itemToAdd);
            }
          }
        }
      });
    } catch (_) {
      if (kDebugMode) {
        print('ForecastData Error: $_');
      }
    }

    return ForecastData(selectedData);
  }
}
