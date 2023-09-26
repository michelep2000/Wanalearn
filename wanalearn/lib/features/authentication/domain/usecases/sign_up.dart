import 'package:equatable/equatable.dart';
import 'package:wanalearn/core/usecases/usecase.dart';
import 'package:wanalearn/core/utils/typedef.dart';
import 'package:wanalearn/features/authentication/domain/repositories/authentication_repository.dart';

class SignUp extends UsecaseWithParams<void, SignUpParams> {
  const SignUp(this._repository);

  final AuthenticationRepository _repository;
  @override
  ResultFuture<void> call(SignUpParams params) => _repository.signUp(
        email: params.email,
        fullname: params.fullname,
        password: params.password,
      );
}

class SignUpParams extends Equatable {
  const SignUpParams({
    required this.email,
    required this.fullname,
    required this.password,
  });

  final String email;
  final String fullname;
  final String password;

  @override
  List<Object?> get props => [email, fullname, password];
}
