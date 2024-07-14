import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:open_weather_example_flutter/src/features/weather/presentation/loading_indicator.dart';

class WeatherIconImage extends StatelessWidget {
  final String iconUrl;
  final double size;

  const WeatherIconImage({
    super.key,
    required this.iconUrl,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: iconUrl,
      width: size,
      height: size,
      progressIndicatorBuilder: (
        _,
        __,
        ___,
      ) =>
          LoadingIndicator(size: size / 2),
    );
  }
}
