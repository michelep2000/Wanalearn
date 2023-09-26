import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wanalearn/core/errors/failure.dart';
import 'package:wanalearn/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:wanalearn/features/authentication/domain/usecases/forgot_password.dart';

import 'authentication_repository.mock.dart';

void main() {
  late AuthenticationRepository repository;
  late ForgotPassword usecase;
  const tEmail = 'test.email@example.com';

  setUp(() {
    repository = MockAuthenticacionRepository();
    usecase = ForgotPassword(repository);
  });

  test(
      'Should call [AuthenticationRepository.forgotPassword] '
      'and return [Right(null)] when is successful', () async {
    // Arrange: means to setup variables to implement the test (mock answer)

    when(() => repository.forgotPassword(any())).thenAnswer(
      (invocation) async => const Right(null),
    );

    // Act: means to do an action (implementation) for the test
    final result = await usecase(tEmail);

    // Assert: means to check code expectations to pass the test
    expect(result, const Right<dynamic, void>(null));
    verify(() => repository.forgotPassword(tEmail)).called(1);
    verifyNoMoreInteractions(repository);
  });

  test(
      'Should call [AuthenticationRepository.forgotPassword] '
      'and return [Right<Failure, dynamic>] when is a failure', () async {
    // Arrange: means to setup the variables to implement the test (mock answer)
    final tServerFailure = ServerFailure(
      message: 'Unknown Error',
      statusCode: 500,
    );

    when(
      () => repository.forgotPassword(any()),
    ).thenAnswer(
      (_) async => Left(tServerFailure),
    );

    // Act: means to do an action (implementation) for the test
    final result = await usecase(tEmail);

    // Assert: means to check code expectations to pass the test
    expect(result, Left<Failure, dynamic>(tServerFailure));

    verify(() => repository.forgotPassword(tEmail)).called(1);
    verifyNoMoreInteractions(repository);
  });
}
