import 'package:equatable/equatable.dart';

class ServerException extends Equatable implements Exception {
  ServerException({required this.message, required this.statusCode})
      : assert(
          statusCode is String || statusCode is int,
          'Status code cannot be a: ${statusCode.runtimeType}',
        );

  final String message;
  final dynamic statusCode;

  @override
  List<Object?> get props => [message, statusCode];
}

class CacheException extends Equatable implements Exception {
  const CacheException({required this.message, this.statusCode = 500});

  final String message;
  final int statusCode;

  @override
  List<Object?> get props => [message, statusCode];
}
