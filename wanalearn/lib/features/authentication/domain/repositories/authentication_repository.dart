import 'package:wanalearn/core/enums/update_user_action.dart';
import 'package:wanalearn/core/utils/typedef.dart';
import 'package:wanalearn/features/authentication/domain/entities/user.dart';

abstract class AuthenticationRepository {
  const AuthenticationRepository();

  ResultFuture<void> forgotPassword(String email);

  ResultFuture<LocalUser> signIn(
    String email,
    String password,
  );

  ResultFuture<void> signUp(
    String email,
    String fullname,
    String password,
  );

  ResultFuture<void> updateUser({
    required UpdateUserAction action,
    dynamic userData,
  });
}
