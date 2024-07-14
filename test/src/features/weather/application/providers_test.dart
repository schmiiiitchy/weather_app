
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;
import 'package:open_weather_example_flutter/src/api/api.dart';
import 'package:open_weather_example_flutter/src/app_setup.dart';
import 'package:open_weather_example_flutter/src/constants/constants.dart';
import 'package:open_weather_example_flutter/src/features/weather/application/providers.dart';
import 'package:open_weather_example_flutter/src/features/weather/data/weather_repository.dart';

import '../mocks/mocks.dart';

class MockHttpClient extends Mock implements http.Client {}
class MockHttpWeatherRepository extends Mock implements HttpWeatherRepository {}


void main() {

  setUpAll(() async {
    await setupConfig();
    setupServiceInjection();
    setupAPIKeyInjection();
  });

  group('WeatherProvider tests', () {
    late WeatherProvider weatherProvider;
    late OpenWeatherMapAPI api;
    late HttpWeatherRepository weatherRepository;
    late http.Client mockHttpClient;

    setUp(() async {
      mockHttpClient = MockHttpClient();
      api = OpenWeatherMapAPI(sl<String>(instanceName: apiKeyInstanceName));
      weatherRepository = HttpWeatherRepository(
        api: api,
        client: mockHttpClient,
      );

      weatherProvider = WeatherProvider();
      weatherProvider.repository = weatherRepository;
    });

    test('provider, mocked http client, currentWeatherProvider success',
        () async {
      const city = 'Pretoria';
      weatherProvider.city = city;
      when(() => mockHttpClient.get(api.weather(city))).thenAnswer(
        (_) async => Future.value(
          http.Response(
            weatherResponse,
            200,
          ),
        ),
      );

      await weatherProvider.getWeatherData();

      expect(
        weatherProvider.currentWeatherProvider?.temp.celsius,
        weatherDataMock.temp.celsius,
      );
    });

    test('provider, mocked http client, forecastedWeatherProvider success',
        () async {
      const city = 'Pretoria';
      weatherProvider.city = city;
      when(() => mockHttpClient.get(api.forecast(city))).thenAnswer(
        (_) async => Future.value(
          http.Response(
            forecastResponse,
            200,
          ),
        ),
      );

      await weatherProvider.getForecastData();

      expect(
        weatherProvider.forecastedWeatherProvider?.list.length,
        greaterThan(0),
      );

      expect(
        weatherProvider.forecastedWeatherProvider?.list.first.date,
        forecastDataMock.list.first.dt,
      );
    });

    test('provider, mocked http client, getWeather success', () async {
      const city = 'Pretoria';
      weatherProvider.city = city;
      when(() => mockHttpClient.get(api.weather(city))).thenAnswer(
        (_) async => Future.value(
          http.Response(
            weatherResponse,
            200,
          ),
        ),
      );
      when(() => mockHttpClient.get(api.forecast(city))).thenAnswer(
        (_) async => Future.value(
          http.Response(
            forecastResponse,
            200,
          ),
        ),
      );

      await weatherProvider.getWeather();

      expect(weatherProvider.isLoading, false);
      expect(weatherProvider.currentWeatherErrorMessage, isNull);
    });

    test('provider, mocked http client, getWeather error', () async {
      const city = 'Pretoria';
      weatherProvider.city = city;
      when(() => mockHttpClient.get(api.weather(city))).thenAnswer(
            (_) async => Future.value(
          http.Response(
            '{}',
            401,
          ),
        ),
      );
      when(() => mockHttpClient.get(api.forecast(city))).thenAnswer(
            (_) async => Future.value(
          http.Response(
            '{}',
            401,
          ),
        ),
      );

      await weatherProvider.getWeather();

      expect(weatherProvider.isLoading, false);
      expect(weatherProvider.currentWeatherErrorMessage, 'Invalid API key');
    });
  });
}
