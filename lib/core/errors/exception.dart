import 'package:equatable/equatable.dart';

class ServerException extends Equatable implements Exception {
  const ServerException({required this.message, this.statusCode = 500});

  final String message;
  final Object statusCode;

  @override
  List<Object?> get props => [message, statusCode];
}

class CacheException extends Equatable implements Exception {
  const CacheException({required this.message, this.statusCode = 500});

  final String message;
  final Object statusCode;

  @override
  List<Object?> get props => [message, statusCode];
}

class UserNotFoundException extends Equatable implements Exception {
  const UserNotFoundException({
    required this.message,
    this.statusCode = 'user-not-found',
  });

  final String message;
  final Object statusCode;

  @override
  List<Object?> get props => [message, statusCode];
}

class UnknownException extends Equatable implements Exception {
  const UnknownException({
    required this.message,
    this.statusCode = 'unknown-exception',
  });

  final String message;
  final Object statusCode;

  @override
  List<Object?> get props => [message, statusCode];
}
