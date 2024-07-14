import 'dart:io';

sealed class APIException implements Exception {
  final String message;

  APIException(this.message);
}

class InvalidApiKeyException extends APIException {
  InvalidApiKeyException() : super('Invalid API key');
}

class NoInternetConnectionException extends APIException {
  NoInternetConnectionException() : super('No Internet connection');
}

class CityNotFoundException extends APIException {
  CityNotFoundException() : super('City not found');
}

class ServerErrorException extends APIException {
  ServerErrorException() : super('Internal server error');
}

class UnknownException implements Exception {
  UnknownException();
}
