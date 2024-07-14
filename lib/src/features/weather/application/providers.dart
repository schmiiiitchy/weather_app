import 'package:flutter/cupertino.dart';
import 'package:open_weather_example_flutter/src/api/api.dart';
import 'package:open_weather_example_flutter/src/app_setup.dart';
import 'package:open_weather_example_flutter/src/constants/constants.dart';
import 'package:open_weather_example_flutter/src/features/weather/data/weather_repository.dart';
import 'package:http/http.dart' as http;
import 'package:open_weather_example_flutter/src/features/weather/domain/forecast/derived/forecast_data.dart';
import 'package:open_weather_example_flutter/src/features/weather/domain/weather/derived/weather_data.dart';
import 'package:open_weather_example_flutter/src/utils/general_helper.dart';

class WeatherProvider extends ChangeNotifier {
  HttpWeatherRepository repository = HttpWeatherRepository(
    api: OpenWeatherMapAPI(sl<String>(instanceName: apiKeyInstanceName)),
    client: http.Client(),
  );

  WeatherData? currentWeatherProvider;
  ForecastData? forecastedWeatherProvider;

  String city = 'Pretoria';
  bool isLoading = false;
  String? currentWeatherErrorMessage;
  String? forecastWeatherErrorMessage;

  Future<void> getWeather({String? city}) async {
    _notifyLoading();

    if (city?.isNotEmpty ?? false) {
      this.city = city!;
    }

    await Future.wait([
      getWeatherData(),
      getForecastData(),
    ]);

    _notifyStoppedLoading();
  }

  Future<void> getWeatherData() async {
    try {
      final weather = await repository.getCityWeather(city);
      currentWeatherProvider = WeatherData.from(weather);
      currentWeatherErrorMessage = null;
    } catch (error) {
      currentWeatherErrorMessage = sl<GeneralHelper>().getAPIExceptionMessage(
        error,
      );
    }
  }

  Future<void> getForecastData() async {
    try {
      final forecast = await repository.getCityForecast(city);
      forecastedWeatherProvider = ForecastData.from(forecast).byDay();
      forecastWeatherErrorMessage = null;
    } catch (error) {
      forecastWeatherErrorMessage = sl<GeneralHelper>().getAPIExceptionMessage(
        error,
      );
    }
  }

  void _notifyLoading() {
    isLoading = true;
    currentWeatherErrorMessage = null;
    notifyListeners();
  }

  void _notifyStoppedLoading() {
    isLoading = false;
    notifyListeners();
  }
}
