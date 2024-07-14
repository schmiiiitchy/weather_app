import 'package:flutter/material.dart';
import 'package:open_weather_example_flutter/src/features/weather/application/providers.dart';
import 'package:open_weather_example_flutter/src/features/weather/domain/weather/derived/weather_data.dart';
import 'package:open_weather_example_flutter/src/features/weather/presentation/weather_icon_image.dart';
import 'package:provider/provider.dart';

import 'loading_indicator.dart';

class CurrentWeather extends StatelessWidget {
  const CurrentWeather({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<WeatherProvider>(
      builder: (context, weatherProvider, _) {
        if (weatherProvider.isLoading) {
          return const LoadingIndicator(size: 60);
        } else if (weatherProvider.currentWeatherErrorMessage != null) {
          return Text('Error: ${weatherProvider.currentWeatherErrorMessage}');
        } else if (weatherProvider.currentWeatherProvider == null) {
          return const Text('No data available');
        } else {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                weatherProvider.city,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              CurrentWeatherContents(
                data: weatherProvider.currentWeatherProvider!,
              ),
            ],
          );
        }
      },
    );
  }
}

class CurrentWeatherContents extends StatelessWidget {
  final WeatherData data;

  const CurrentWeatherContents({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final temp = data.temp.celsius.toInt().toString();
    final minTemp = data.minTemp.celsius.toInt().toString();
    final maxTemp = data.maxTemp.celsius.toInt().toString();
    final highAndLow = 'H:$maxTemp° L:$minTemp°';

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        WeatherIconImage(
          iconUrl: data.iconUrl,
          size: 120,
        ),
        Text('$temp°', style: textTheme.displayMedium),
        Text(highAndLow, style: textTheme.bodyMedium),
      ],
    );
  }
}
