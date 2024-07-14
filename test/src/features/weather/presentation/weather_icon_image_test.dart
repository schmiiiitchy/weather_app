import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:open_weather_example_flutter/src/features/weather/presentation/loading_indicator.dart';
import 'package:open_weather_example_flutter/src/features/weather/presentation/weather_icon_image.dart';

void main() {
  group('WeatherIconImage widget', () {
    testWidgets('renders CachedNetworkImage with correct parameters', (WidgetTester tester) async {
      const iconUrl = 'https://openweathermap.org/img/wn/01n@2x.png';
      const size = 100.0;

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: WeatherIconImage(
              iconUrl: iconUrl,
              size: size,
            ),
          ),
        ),
      );

      expect(find.byType(CachedNetworkImage), findsOneWidget);

      final cachedNetworkImage = find.byType(CachedNetworkImage).evaluate().first.widget as CachedNetworkImage;
      expect(cachedNetworkImage.imageUrl, iconUrl);
      expect(cachedNetworkImage.width, size);
      expect(cachedNetworkImage.height, size);
    });

    testWidgets('displays LoadingIndicator while image is loading', (WidgetTester tester) async {
      const iconUrl = 'https://openweathermap.org/img/wn/01n@2x.png';
      const size = 100.0;

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: WeatherIconImage(
              iconUrl: iconUrl,
              size: size,
            ),
          ),
        ),
      );

      expect(find.byType(LoadingIndicator), findsOneWidget);
    });
  });
}
