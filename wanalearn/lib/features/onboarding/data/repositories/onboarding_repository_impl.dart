import 'package:dartz/dartz.dart';
import 'package:wanalearn/core/errors/exceptions.dart';
import 'package:wanalearn/core/errors/failure.dart';
import 'package:wanalearn/core/utils/typedef.dart';
import 'package:wanalearn/features/onboarding/data/datasources/onboarding_local_data_source.dart';
import 'package:wanalearn/features/onboarding/domain/repositories/onboarding_repository.dart';

class OnboardingRepositoryImpl implements OnboardingRepository {
  OnboardingRepositoryImpl(this._localDataSource);

  final OnboardingLocalDataSource _localDataSource;

  @override
  ResultFuture<void> cacheUserFirstTime() async {
    try {
      await _localDataSource.cacheUserFirstTime();
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure.fromException(e));
    }
  }

  @override
  ResultFuture<bool> checkIfUserFirstTime() async {
    try {
      final result = await _localDataSource.checkIfUserFirstTime();
      return Right(result);
    } on CacheException catch (e) {
      return Left(CacheFailure.fromException(e));
    }
  }
}
