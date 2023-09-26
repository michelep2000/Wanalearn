import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wanalearn/core/errors/failure.dart';
import 'package:wanalearn/features/authentication/domain/entities/user.dart';
import 'package:wanalearn/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:wanalearn/features/authentication/domain/usecases/sign_in.dart';

import 'authentication_repository.mock.dart';

void main() {
  late AuthenticationRepository repository;
  late SignIn usecase;
  const tEmail = 'test.email@example.com';
  const tPassword = '123456';
  const tUser = LocalUser.empty();

  setUp(() {
    repository = MockAuthenticacionRepository();
    usecase = SignIn(repository);
  });

  test(
      'Should call [AuthenticationRepository.signIn] '
      'and return [Right(LocalUser)] when is successful', () async {
    // Arrange: means to setup variables to implement the test (mock answer)

    when(
      () => repository.signIn(
        email: any(named: 'email'),
        password: any(named: 'password'),
      ),
    ).thenAnswer(
      (invocation) async => const Right(tUser),
    );

    // Act: means to do an action (implementation) for the test
    final result = await usecase(
      const SignInParams(
        email: tEmail,
        password: tPassword,
      ),
    );

    // Assert: means to check code expectations to pass the test
    expect(result, const Right<dynamic, LocalUser>(tUser));
    verify(
      () => repository.signIn(
        email: tEmail,
        password: tPassword,
      ),
    ).called(1);
    verifyNoMoreInteractions(repository);
  });

  test(
      'Should call [AuthenticationRepository.signIn] '
      'and return [Right<Failure, dynamic>] when is a failure', () async {
    // Arrange: means to setup the variables to implement the test (mock answer)
    final tServerFailure = ServerFailure(
      message: 'Unknown Error',
      statusCode: 500,
    );

    when(
      () => repository.signIn(
        email: any(named: 'email'),
        password: any(named: 'password'),
      ),
    ).thenAnswer(
      (_) async => Left(tServerFailure),
    );

    // Act: means to do an action (implementation) for the test
    final result = await usecase(
      const SignInParams(
        email: tEmail,
        password: tPassword,
      ),
    );
    // Assert: means to check code expectations to pass the test
    expect(result, Left<Failure, dynamic>(tServerFailure));

    verify(
      () => repository.signIn(
        email: tEmail,
        password: tPassword,
      ),
    ).called(1);
    verifyNoMoreInteractions(repository);
  });
}
