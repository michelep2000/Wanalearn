import 'package:equatable/equatable.dart';
import 'package:wanalearn/core/errors/exceptions.dart';

class Failure extends Equatable {
  Failure({required this.message, required this.statusCode})
      : assert(
          statusCode is String || statusCode is int,
          'Status code cannot be a: ${statusCode.runtimeType}',
        );

  final String message;
  final dynamic statusCode;

  String get errorMessage => '$statusCode ERROR: $message';

  @override
  List<Object?> get props => [message, statusCode];
}

class CacheFailure extends Failure {
  CacheFailure({required super.message, required super.statusCode});
}

class ServerFailure extends Failure {
  ServerFailure({required super.message, required super.statusCode});

  ServerFailure.fromException(ServerException exception)
      : this(
          message: exception.message,
          statusCode: exception.statusCode,
        );
}
