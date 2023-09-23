import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wanalearn/core/errors/failure.dart';
import 'package:wanalearn/features/onboarding/presentation/domain/repositories/onboarding_repository.dart';
import 'package:wanalearn/features/onboarding/presentation/domain/usecases/check_if_user_first_time.dart';

import 'onboarding_repository.mock.dart';

void main() {
  late OnboardingRepository repository;
  late CheckIfUserFirstTime usecase;

  setUp(() {
    repository = MockOnboardingRepository();
    usecase = CheckIfUserFirstTime(repository);
  });

  test(
      'Should call [OnboardingRepository.checkIfUserFirstTime]'
      ' and return [Right<dynamic, bool>]', () async {
    // Arrange: means to setup the variables to implement the test (mock answer)
    when(() => repository.checkIfUserFirstTime()).thenAnswer(
      (invocation) async => const Right(true),
    );

    // Act: means to do an action (implementation) for the test
    final result = await usecase();

    // Assert: means to check code expectations to pass the test
    expect(
      result,
      equals(const Right<dynamic, bool>(true)),
    );

    verify(() => repository.checkIfUserFirstTime()).called(1);
    verifyNoMoreInteractions(repository);
  });

  test(
      'Should call [OnboardingRepository.checkIfUserFirstTime]'
      ' and return [Right<Failure, dynamic>]', () async {
    // Arrange: means to setup the variables to implement the test (mock answer)
    final tServerFailure = ServerFailure(
      message: 'Unknown Error',
      statusCode: 500,
    );

    when(
      () => repository.checkIfUserFirstTime(),
    ).thenAnswer(
      (_) async => Left(tServerFailure),
    );

    // Act: means to do an action (implementation) for the test
    final result = await usecase();

    // Assert: means to check code expectations to pass the test
    expect(result, Left<Failure, dynamic>(tServerFailure));

    verify(() => repository.checkIfUserFirstTime()).called(1);
    verifyNoMoreInteractions(repository);
  });
}
