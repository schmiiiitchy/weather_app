import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:open_weather_example_flutter/src/utils/general_helper.dart';

final sl = GetIt.instance;

void setupAPIKeyInjection() {
  sl.registerSingleton<String>(
    dotenv.env['apiKey']!,
    instanceName: 'api_key',
  );
}

Future<void> setupConfig() async {
  await dotenv.load(fileName: ".env");
}

void setupServiceInjection() {
  sl.registerLazySingleton(() => GeneralHelper());
}