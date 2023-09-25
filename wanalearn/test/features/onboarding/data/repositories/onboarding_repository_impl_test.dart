import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wanalearn/core/errors/exceptions.dart';
import 'package:wanalearn/core/errors/failure.dart';
import 'package:wanalearn/features/onboarding/data/datasources/onboarding_local_data_source.dart';
import 'package:wanalearn/features/onboarding/data/repositories/onboarding_repository_impl.dart';
import 'package:wanalearn/features/onboarding/domain/repositories/onboarding_repository.dart';

class MockOnboardingLocalDataSource extends Mock
    implements OnboardingLocalDataSource {}

void main() {
  late OnboardingLocalDataSource localDataSource;
  late OnboardingRepositoryImpl repositoryImpl;
  late CacheException tCacheException;

  setUp(() {
    localDataSource = MockOnboardingLocalDataSource();
    repositoryImpl = OnboardingRepositoryImpl(localDataSource);
    tCacheException = const CacheException(
      message: 'Insufficient storage',
    );
  });

  test('Should be a subclass of [OnboardingRepository]', () {
    expect(repositoryImpl, isA<OnboardingRepository>());
  });
  group('cacheUserFirstTime', () {
    test(
        'Should call [localDataSource.cacheUserFirstTime] and complete '
        'successfully when the call to the local source its successful',
        () async {
      // Arrange: means to setup variables to implement the test (mock answer)
      when(
        () => localDataSource.cacheUserFirstTime(),
      ).thenAnswer(
        (_) async => Future.value(),
      );

      // Act: means to do an action (implementation) for the test
      final result = await repositoryImpl.cacheUserFirstTime();

      // Assert: means to check code expectations to pass the test
      expect(result, equals(const Right<dynamic, void>(null)));

      verify(() => localDataSource.cacheUserFirstTime()).called(1);
      verifyNoMoreInteractions(localDataSource);
    });

    test(
        'Should return [Left(CacheFailure)] when the call to '
        'the remote source its unsuccessful', () async {
      // Arrange: means to setup variables to implement the test (mock answer)
      when(() => localDataSource.cacheUserFirstTime())
          .thenThrow(tCacheException);

      // Act: means to do an action (implementation) for the test
      final result = await repositoryImpl.cacheUserFirstTime();

      // Assert: means to check code expectations to pass the test
      expect(
        result,
        equals(
          Left<Failure, dynamic>(CacheFailure.fromException(tCacheException)),
        ),
      );
      verify(() => localDataSource.cacheUserFirstTime()).called(1);
      verifyNoMoreInteractions(localDataSource);
    });
  });

  group('checkIfUserFirstTime', () {
    test(
        'Should call [localDataSource.checkIfUserFirstTime] and return a '
        '[Right(bool)] when the call to the local source its successful',
        () async {
      // Arrange: means to setup variables to implement the test (mock answer)
      when(
        () => localDataSource.checkIfUserFirstTime(),
      ).thenAnswer(
        (_) async => Future.value(true),
      );

      // Act: means to do an action (implementation) for the test
      final result = await repositoryImpl.checkIfUserFirstTime();

      // Assert: means to check code expectations to pass the test
      expect(result, equals(const Right<dynamic, bool>(true)));

      verify(() => localDataSource.checkIfUserFirstTime()).called(1);
      verifyNoMoreInteractions(localDataSource);
    });

    test(
        'Should return [Left(CacheFailure)] when the call to '
        'the remote source its unsuccessful', () async {
      // Arrange: means to setup variables to implement the test (mock answer)
      when(() => localDataSource.checkIfUserFirstTime())
          .thenThrow(tCacheException);

      // Act: means to do an action (implementation) for the test
      final result = await repositoryImpl.checkIfUserFirstTime();

      // Assert: means to check code expectations to pass the test
      expect(
        result,
        equals(
          Left<Failure, dynamic>(CacheFailure.fromException(tCacheException)),
        ),
      );
      verify(() => localDataSource.checkIfUserFirstTime()).called(1);
      verifyNoMoreInteractions(localDataSource);
    });
  });
}
