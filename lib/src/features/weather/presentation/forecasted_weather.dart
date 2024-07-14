import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:open_weather_example_flutter/src/features/weather/application/providers.dart';
import 'package:open_weather_example_flutter/src/features/weather/domain/weather/derived/weather_data.dart';
import 'package:open_weather_example_flutter/src/features/weather/presentation/weather_icon_image.dart';
import 'package:provider/provider.dart';

import 'loading_indicator.dart';

class ForecastedWeather extends StatelessWidget {
  const ForecastedWeather({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<WeatherProvider>(
      builder: (context, weatherProvider, _) {
        if (weatherProvider.isLoading) {
          return const LoadingIndicator(size: 60);
        } else if (weatherProvider.forecastWeatherErrorMessage != null) {
          return Text('Error: ${weatherProvider.forecastWeatherErrorMessage}');
        } else if (weatherProvider.forecastedWeatherProvider == null ||
            weatherProvider.forecastedWeatherProvider!.list.isEmpty) {
          return const Text('No data available');
        } else {
          return WeatherRow(
            weatherDataItems: weatherProvider.forecastedWeatherProvider!.list,
          );
        }
      },
    );
  }
}

class WeatherRow extends StatelessWidget {
  final List<WeatherData> weatherDataItems;

  const WeatherRow({
    super.key,
    required this.weatherDataItems,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children:
          weatherDataItems.map((data) => WeatherItem(data: data)).toList(),
    );
  }
}

class WeatherItem extends StatelessWidget {
  final WeatherData data;

  const WeatherItem({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    const fontWeight = FontWeight.normal;
    final temp = data.temp.celsius.toInt().toString();
    return Expanded(
      child: Column(
        children: [
          Text(
            DateFormat.E().format(data.dateTime),
            style: textTheme.bodySmall!.copyWith(fontWeight: fontWeight),
          ),
          const SizedBox(height: 8),
          WeatherIconImage(iconUrl: data.iconUrl, size: 48),
          const SizedBox(height: 8),
          Text(
            '$temp°',
            style: textTheme.bodyLarge!.copyWith(fontWeight: fontWeight),
          ),
        ],
      ),
    );
  }
}
