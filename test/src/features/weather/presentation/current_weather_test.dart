import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:open_weather_example_flutter/src/app_setup.dart';
import 'package:open_weather_example_flutter/src/features/weather/application/providers.dart';
import 'package:open_weather_example_flutter/src/features/weather/presentation/current_weather.dart';
import 'package:open_weather_example_flutter/src/features/weather/presentation/loading_indicator.dart';
import 'package:provider/provider.dart';


void main() {

  setUpAll(() async {
    await setupConfig();
    setupServiceInjection();
    setupAPIKeyInjection();
  });

  group('CurrentWeather widget', () {

    testWidgets('renders LoadingIndicator when isLoading is true', (WidgetTester tester) async {
      final provider = WeatherProvider();
      provider.isLoading = true;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ChangeNotifierProvider.value(
              value: provider,
              child: const CurrentWeather(),
            ),
          ),
        ),
      );

      expect(find.byType(LoadingIndicator), findsOneWidget);
    });

    testWidgets('displays error message when errorMessage is not null', (WidgetTester tester) async {
      final provider = WeatherProvider();
      const errorMessage = 'An unknown error occurred';

      provider.currentWeatherErrorMessage = errorMessage;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ChangeNotifierProvider.value(
              value: provider,
              child: const CurrentWeather(),
            ),
          ),
        ),
      );

      expect(find.text('Error: $errorMessage'), findsOneWidget);
    });
  });
}
