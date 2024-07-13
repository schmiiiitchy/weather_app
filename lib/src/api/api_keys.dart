import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';

/// To get an API key, sign up here:
/// https://home.openweathermap.org/users/sign_up
///

final sl = GetIt.instance;

void setupInjection() => sl.registerSingleton<String>(
      dotenv.env['apiKey']!,
      instanceName: 'api_key',
    );
