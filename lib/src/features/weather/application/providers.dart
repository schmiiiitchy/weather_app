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
  String? errorMessage;

  Future<void> getWeather({String? city}) async {
    try {
      _notifyLoading();

      if (city?.isNotEmpty ?? false) {
        this.city = city!;
      }

      await Future.wait([
        getWeatherData(),
        getForecastData(),
      ]);
    } catch (error) {
      _handleError(error);
    } finally {
      _notifyStoppedLoading();
    }
  }

  Future<void> getWeatherData() async {
    final weather = await repository.getWeather(city: city);
    currentWeatherProvider = WeatherData.from(weather);
  }

  Future<void> getForecastData() async {
    final forecast = await repository.getForecast(city: city);
    forecastedWeatherProvider = ForecastData.from(forecast).byDay();
  }

  void _notifyLoading() {
    isLoading = true;
    errorMessage = null;
    notifyListeners();
  }

  void _notifyStoppedLoading() {
    isLoading = false;
    notifyListeners();
  }

  void _handleError(Object error) =>
      errorMessage = sl<GeneralHelper>().getAPIExceptionMessage(error);
}
