import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wanalearn/core/enums/update_user_action.dart';
import 'package:wanalearn/core/errors/failure.dart';
import 'package:wanalearn/features/authentication/domain/entities/user.dart';
import 'package:wanalearn/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:wanalearn/features/authentication/domain/usecases/sign_in.dart';
import 'package:wanalearn/features/authentication/domain/usecases/update_user.dart';

import 'authentication_repository.mock.dart';

void main() {
  late AuthenticationRepository repository;
  late UpdateUser usecase;
  const tUserData = LocalUser.empty();
  const tUpdateUserAction = UpdateUserAction.name;

  setUp(() {
    repository = MockAuthenticacionRepository();
    usecase = UpdateUser(repository);
    registerFallbackValue(tUpdateUserAction);
  });

  test(
      'Should call [AuthenticationRepository.updateUser] '
      'and return [Right(null)] when is successful', () async {
    // Arrange: means to setup variables to implement the test (mock answer)

    when(
      () => repository.updateUser(
        userData: any<dynamic>(named: 'userData'),
        action: any(named: 'action'),
      ),
    ).thenAnswer(
      (invocation) async => const Right(null),
    );

    // Act: means to do an action (implementation) for the test
    final result = await usecase(
      const UpdateUserParams(
        userData: tUserData,
        action: tUpdateUserAction,
      ),
    );

    // Assert: means to check code expectations to pass the test
    expect(result, const Right<dynamic, void>(null));
    verify(
      () => repository.updateUser(
        userData: tUserData,
        action: tUpdateUserAction,
      ),
    ).called(1);
    verifyNoMoreInteractions(repository);
  });

  test(
      'Should call [AuthenticationRepository.updateUser] '
      'and return [Right<Failure, dynamic>] when is a failure', () async {
    // Arrange: means to setup the variables to implement the test (mock answer)
    final tServerFailure = ServerFailure(
      message: 'Unknown Error',
      statusCode: 500,
    );

    when(
      () => repository.updateUser(
        userData: any<dynamic>(named: 'userData'),
        action: any(named: 'action'),
      ),
    ).thenAnswer(
      (_) async => Left(tServerFailure),
    );

    // Act: means to do an action (implementation) for the test
    final result = await usecase(
      const UpdateUserParams(
        userData: tUserData,
        action: tUpdateUserAction,
      ),
    );
    // Assert: means to check code expectations to pass the test
    expect(result, Left<Failure, dynamic>(tServerFailure));

    verify(
      () => repository.updateUser(
        userData: tUserData,
        action: tUpdateUserAction,
      ),
    ).called(1);
    verifyNoMoreInteractions(repository);
  });
}
