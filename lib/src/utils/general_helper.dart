import 'dart:io';

import 'api_exception.dart';

class GeneralHelper {
  String getAPIExceptionMessage(dynamic error) {
    switch (error) {
      case InvalidApiKeyException _:
      case NoInternetConnectionException _:
      case CityNotFoundException _:
      case UnknownException _:
        return error.message;
    }

    if (error is SocketException) {
      return 'Network error. Please try again later';
    } else {
      return 'An unknown error occurred';
    }
  }
}
