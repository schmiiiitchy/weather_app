import 'package:open_weather_example_flutter/src/features/weather/domain/forecast/forecast.dart';
import 'package:open_weather_example_flutter/src/features/weather/domain/weather/derived/weather_data.dart';
import 'package:open_weather_example_flutter/src/features/weather/domain/weather/weather.dart';

const String weatherResponse = '''{
  "coord": {"lon": 28.1878, "lat": -25.7449},
  "weather": [
    {"id": 800, "main": "Clear", "description": "clear sky", "icon": "01n"}
  ],
  "base": "stations",
  "main": {
    "temp": 15.75,
    "feels_like": 14.24,
    "temp_min": 15.32,
    "temp_max": 16.53,
    "pressure": 1020,
    "humidity": 33,
    "sea_level": 1020,
    "grnd_level": 873
  },
  "visibility": 10000,
  "wind": {"speed": 1.91, "deg": 235, "gust": 2.29},
  "clouds": {"all": 0},
  "dt": 1720978789,
  "sys": {
    "type": 2,
    "id": 2037341,
    "country": "ZA",
    "sunrise": 1720932778,
    "sunset": 1720971172
  },
  "timezone": 7200,
  "id": 964137,
  "name": "Pretoria",
  "cod": 200
}''';

const String forecastResponse = '''{
  "cod": "200",
  "message": 0,
  "cnt": 30,
  "list": [
    {
      "dt": 1720980000,
      "main": {
        "temp": 15.75,
        "feels_like": 14.24,
        "temp_min": 15.75,
        "temp_max": 15.89,
        "pressure": 1020,
        "sea_level": 1020,
        "grnd_level": 873,
        "humidity": 33,
        "temp_kf": -0.14
      },
      "weather": [
        {"id": 800, "main": "Clear", "description": "clear sky", "icon": "01n"}
      ],
      "clouds": {"all": 0},
      "wind": {"speed": 1.91, "deg": 235, "gust": 2.29},
      "visibility": 10000,
      "pop": 0,
      "sys": {"pod": "n"},
      "dt_txt": "2024-07-14 18:00:00"
    },
    {
      "dt": 1721293200,
      "main": {
        "temp": 20.74,
        "feels_like": 19.29,
        "temp_min": 20.74,
        "temp_max": 20.74,
        "pressure": 1020,
        "sea_level": 1020,
        "grnd_level": 875,
        "humidity": 16,
        "temp_kf": 0
      },
      "weather": [
        {"id": 800, "main": "Clear", "description": "clear sky", "icon": "01d"}
      ],
      "clouds": {"all": 0},
      "wind": {"speed": 2.89, "deg": 341, "gust": 5.01},
      "visibility": 10000,
      "pop": 0,
      "sys": {"pod": "d"},
      "dt_txt": "2024-07-18 09:00:00"
    }
  ],
  "city": {
    "id": 964137,
    "name": "Pretoria",
    "coord": {"lat": -25.7449, "lon": 28.1878},
    "country": "ZA",
    "population": 1619438,
    "timezone": 7200,
    "sunrise": 1720932778,
    "sunset": 1720971172
  }
}''';

final expectedWeatherFromJson = Weather(
  weatherParams: WeatherParams(
    temp: 282.55,
    tempMin: 280.37,
    tempMax: 284.26,
  ),
  weatherInfo: [
    WeatherInfo(
      description: 'clear sky',
      icon: '01d',
      main: 'Clear',
    )
  ],
  dt: 1560350645,
);

final weatherDataMock = WeatherData.from(
  Weather(
    weatherParams: WeatherParams(
      temp: 15.75,
      tempMin: 15.32,
      tempMax: 16.53,
    ),
    weatherInfo: [
      WeatherInfo(
        main: "Clear",
        description: "clear sky",
        icon: "01n",
      ),
    ],
    dt: 1720978789,
  ),
);

final Forecast forecastDataMock = Forecast(
  list: [
    Weather(
      weatherParams: WeatherParams(
        temp: 15.75,
        tempMin: 15.75,
        tempMax: 15.89,
      ),
      weatherInfo: [
        WeatherInfo(
          main: "Clear",
          description: "clear sky",
          icon: "01n",
        ),
      ],
      dt: 1720980000,
    ),
    Weather(
      weatherParams: WeatherParams(
        temp: 20.74,
        tempMin: 20.74,
        tempMax: 20.74,
      ),
      weatherInfo: [
        WeatherInfo(
          main: "Clear",
          description: "clear sky",
          icon: "01d",
        ),
      ],
      dt: 1721293200,
    ),
  ],
);
