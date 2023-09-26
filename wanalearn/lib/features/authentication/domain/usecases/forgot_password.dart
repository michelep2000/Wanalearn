import 'package:wanalearn/core/usecases/usecase.dart';
import 'package:wanalearn/core/utils/typedef.dart';
import 'package:wanalearn/features/authentication/domain/repositories/authentication_repository.dart';

class ForgotPassword extends UsecaseWithParams<void, String> {
  const ForgotPassword(this._repository);

  final AuthenticationRepository _repository;

  @override
  ResultFuture<void> call(String params) async =>
      _repository.forgotPassword(params);
}
