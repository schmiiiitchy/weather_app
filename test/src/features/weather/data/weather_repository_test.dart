import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:open_weather_example_flutter/src/api/api.dart';
import 'package:open_weather_example_flutter/src/features/weather/data/weather_repository.dart';
import 'package:open_weather_example_flutter/src/utils/api_exception.dart';

import '../mocks/mocks.dart';

class MockHttpClient extends Mock implements http.Client {}

const encodedWeatherJsonResponse = """
{
  "coord": {
    "lon": -122.08,
    "lat": 37.39
  },
  "weather": [
    {
      "id": 800,
      "main": "Clear",
      "description": "clear sky",
      "icon": "01d"
    }
  ],
  "base": "stations",
  "main": {
    "temp": 282.55,
    "feels_like": 281.86,
    "temp_min": 280.37,
    "temp_max": 284.26,
    "pressure": 1023,
    "humidity": 100
  },
  "visibility": 16093,
  "wind": {
    "speed": 1.5,
    "deg": 350
  },
  "clouds": {
    "all": 1
  },
  "dt": 1560350645,
  "sys": {
    "type": 1,
    "id": 5122,
    "message": 0.0139,
    "country": "US",
    "sunrise": 1560343627,
    "sunset": 1560396563
  },
  "timezone": -25200,
  "id": 420006353,
  "name": "Mountain View",
  "cod": 200
  }  
""";

void main() {
  group('Weather repository tests', () {
    late OpenWeatherMapAPI api;
    late HttpWeatherRepository weatherRepository;
    late http.Client mockHttpClient;

    setUp(() {
      mockHttpClient = MockHttpClient();
      api = OpenWeatherMapAPI('apiKey');
      weatherRepository = HttpWeatherRepository(
        api: api,
        client: mockHttpClient,
      );
    });

    test('mocked http client, 200 success', () async {
      when(() => mockHttpClient.get(api.weather('Pretoria'))).thenAnswer(
        (_) => Future.value(
          http.Response(
            encodedWeatherJsonResponse,
            200,
          ),
        ),
      );

      final weather = await weatherRepository.getCityWeather('Pretoria');

      expect(
        weather,
        expectedWeatherFromJson,
      );
    });

    test('mocked http client, 404 failure', () async {
      when(() => mockHttpClient.get(api.weather('Pretoria'))).thenAnswer(
        (_) => Future.value(
          http.Response(
            '{}',
            404,
          ),
        ),
      );

      expect(
        () => weatherRepository.getCityWeather('Pretoria'),
        throwsA(
          isA<CityNotFoundException>(),
        ),
      );
    });
  });
}
