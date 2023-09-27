import 'package:dartz/dartz.dart';
import 'package:wanalearn/core/enums/update_user_action.dart';
import 'package:wanalearn/core/errors/exceptions.dart';
import 'package:wanalearn/core/errors/failure.dart';
import 'package:wanalearn/core/utils/typedef.dart';
import 'package:wanalearn/features/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:wanalearn/features/authentication/domain/entities/user.dart';
import 'package:wanalearn/features/authentication/domain/repositories/authentication_repository.dart';

class AuthenticactionRepositoryImpl implements AuthenticationRepository {
  const AuthenticactionRepositoryImpl(this._remoteDataSource);

  final AuthenticationRemoteDataSource _remoteDataSource;

  @override
  ResultFuture<void> forgotPassword(String email) async {
    try {
      await _remoteDataSource.forgotPassword(email);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<LocalUser> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final result = await _remoteDataSource.signIn(
        email: email,
        password: password,
      );

      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<void> signUp({
    required String email,
    required String fullname,
    required String password,
  }) async {
    try {
      await _remoteDataSource.signUp(
        email: email,
        fullname: fullname,
        password: password,
      );

      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<void> updateUser({
    required UpdateUserAction action,
    required dynamic userData,
  }) async {
    try {
      await _remoteDataSource.updateUser(userData: userData, action: action);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }
}
