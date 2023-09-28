import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wanalearn/core/enums/update_user_action.dart';
import 'package:wanalearn/core/errors/exceptions.dart';
import 'package:wanalearn/core/errors/failure.dart';
import 'package:wanalearn/features/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:wanalearn/features/authentication/data/models/user_model.dart';
import 'package:wanalearn/features/authentication/data/repositories/authentication_repository_impl.dart';

class MockAuthenticationRemoteDataSource extends Mock
    implements AuthenticationRemoteDataSource {}

void main() {
  late AuthenticationRemoteDataSource remoteDataSource;
  late AuthenticactionRepositoryImpl repositoryImpl;
  
  const tEmail = 'test.email@example.com';
  const tPassword = 'test.password1234';
  const tFullname = 'test.fullname';
  final tServerException = ServerException(
    message: 'Servcer Exception',
    statusCode: 500,
  );
  const tUpdateUserAction = UpdateUserAction.displayName;
  const tUserModel = LocalUserModel.empty();

  setUp(() {
    remoteDataSource = MockAuthenticationRemoteDataSource();
    repositoryImpl = AuthenticactionRepositoryImpl(remoteDataSource);
    registerFallbackValue(tUpdateUserAction);
  });

  group('forgotPassword', () {
    test(
        'Should call [remoteDataSource.forgotPassword] and return a '
        '[Right(null)] when the call to the remote source its successful',
        () async {
      // Arrange: means to setup variables to implement the test (mock answer)
      when(() => remoteDataSource.forgotPassword(any())).thenAnswer(
        (_) async => Future.value(),
      );

      // Act: means to do an action (implementation) for the test
      final result = await repositoryImpl.forgotPassword(tEmail);

      // Assert: means to check code expectations to pass the test
      expect(result, const Right<dynamic, void>(null));
      verify(() => remoteDataSource.forgotPassword(tEmail)).called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });

    test(
        'Should return [Left(ServerFailure)] when the call to '
        'the remote source its unsuccessful', () async {
      // Arrange: means to setup variables to implement the test (mock answer)
      when(() => remoteDataSource.forgotPassword(tEmail))
          .thenThrow(tServerException);

      // Act: means to do an action (implementation) for the test
      final result = await repositoryImpl.forgotPassword(tEmail);

      // Assert: means to check code expectations to pass the test
      expect(
        result,
        Left<Failure, dynamic>(
          ServerFailure.fromException(tServerException),
        ),
      );

      verify(() => remoteDataSource.forgotPassword(tEmail)).called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });
  });

  group('signIn', () {
    test(
        'Should call [remoteDataSource.signIn] and return a '
        '[Right(LocalUser)] when the call to the remote source its successful',
        () async {
      // Arrange: means to setup variables to implement the test (mock answer)
      when(
        () => remoteDataSource.signIn(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenAnswer(
        (_) async => Future.value(tUserModel),
      );

      // Act: means to do an action (implementation) for the test
      final result = await repositoryImpl.signIn(
        email: tEmail,
        password: tPassword,
      );

      // Assert: means to check code expectations to pass the test
      expect(result, const Right<dynamic, LocalUserModel>(tUserModel));

      verify(
        () => remoteDataSource.signIn(
          email: tEmail,
          password: tPassword,
        ),
      ).called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });

    test(
        'Should return [Left(ServerFailure)] when the call to '
        'the remote source its unsuccessful', () async {
      // Arrange: means to setup variables to implement the test (mock answer)
      when(
        () => remoteDataSource.signIn(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenThrow(tServerException);

      // Act: means to do an action (implementation) for the test
      final result = await repositoryImpl.signIn(
        email: tEmail,
        password: tPassword,
      );

      // Assert: means to check code expectations to pass the test
      expect(
        result,
        Left<Failure, dynamic>(ServerFailure.fromException(tServerException)),
      );

      verify(
        () => remoteDataSource.signIn(
          email: tEmail,
          password: tPassword,
        ),
      ).called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });
  });

  group('signUp', () {
    test(
        'Should call [remoteDataSource.signUp] and return a '
        '[Right(null)] when the call to the remote source its successful',
        () async {
      // Arrange: means to setup variables to implement the test (mock answer)
      when(
        () => remoteDataSource.signUp(
          email: any(named: 'email'),
          fullname: any(named: 'fullname'),
          password: any(named: 'password'),
        ),
      ).thenAnswer((_) => Future.value());

      // Act: means to do an action (implementation) for the test
      final result = await repositoryImpl.signUp(
        email: tEmail,
        fullname: tFullname,
        password: tPassword,
      );

      // Assert: means to check code expectations to pass the test
      expect(result, const Right<dynamic, void>(null));

      verify(
        () => remoteDataSource.signUp(
          email: tEmail,
          fullname: tFullname,
          password: tPassword,
        ),
      ).called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });

    test(
        'Should return [Left(ServerFailure)] when the call to '
        'the remote source its unsuccessful', () async {
      // Arrange: means to setup variables to implement the test (mock answer)
      when(
        () => remoteDataSource.signUp(
          email: any(named: 'email'),
          fullname: any(named: 'fullname'),
          password: any(named: 'password'),
        ),
      ).thenThrow(tServerException);

      // Act: means to do an action (implementation) for the test
      final result = await repositoryImpl.signUp(
        email: tEmail,
        fullname: tFullname,
        password: tPassword,
      );

      // Assert: means to check code expectations to pass the test
      expect(
        result,
        Left<Failure, dynamic>(ServerFailure.fromException(tServerException)),
      );

      verify(
        () => remoteDataSource.signUp(
          email: tEmail,
          fullname: tFullname,
          password: tPassword,
        ),
      ).called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });
  });
  group('updateUser', () {
    test(
        'Should call [remoteDataSource.updateUser] and return a '
        '[Right(null)] when the call to the remote source its successful',
        () async {
      // Arrange: means to setup variables to implement the test (mock answer)
      when(
        () => remoteDataSource.updateUser(
          userData: any<dynamic>(named: 'userData'),
          action: any(named: 'action'),
        ),
      ).thenAnswer((_) async => Future.value());

      // Act: means to do an action (implementation) for the test
      final result = await repositoryImpl.updateUser(
        userData: tUserModel,
        action: tUpdateUserAction,
      );

      // Assert: means to check code expectations to pass the test
      expect(result, const Right<dynamic, void>(null));

      verify(
        () => remoteDataSource.updateUser(
          userData: tUserModel,
          action: tUpdateUserAction,
        ),
      ).called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });

    test(
        'Should return [Left(ServerFailure)] when the call to '
        'the remote source its unsuccessful', () async {
      // Arrange: means to setup variables to implement the test (mock answer)
      when(
        () => remoteDataSource.updateUser(
          userData: any<dynamic>(named: 'userData'),
          action: any(named: 'action'),
        ),
      ).thenThrow(tServerException);

      // Act: means to do an action (implementation) for the test
      final result = await repositoryImpl.updateUser(
        userData: tUserModel,
        action: tUpdateUserAction,
      );

      // Assert: means to check code expectations to pass the test
      expect(
        result,
        Left<Failure, dynamic>(ServerFailure.fromException(tServerException)),
      );

      verify(
        () => remoteDataSource.updateUser(
          userData: tUserModel,
          action: tUpdateUserAction,
        ),
      ).called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });
  });
}
