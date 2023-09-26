import 'package:equatable/equatable.dart';
import 'package:wanalearn/core/usecases/usecase.dart';
import 'package:wanalearn/core/utils/typedef.dart';
import 'package:wanalearn/features/authentication/domain/entities/user.dart';
import 'package:wanalearn/features/authentication/domain/repositories/authentication_repository.dart';

class SignIn extends UsecaseWithParams<LocalUser, SignInParams> {
  const SignIn(this._repository);

  final AuthenticationRepository _repository;
  @override
  ResultFuture<LocalUser> call(SignInParams params) async => _repository.signIn(
        email: params.email,
        password: params.password,
      );
}

class SignInParams extends Equatable {
  const SignInParams({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;

  @override
  List<Object?> get props => [email, password];
}
