import 'package:wanalearn/core/enums/update_user_action.dart';
import 'package:wanalearn/features/authentication/data/models/user_model.dart';

abstract class AuthenticationRemoteDataSource {
  const AuthenticationRemoteDataSource();

  Future<void> forgotPassword(String email);
  
  Future<LocalUserModel> signIn({
    required String email,
    required String password,
  });

  Future<void> signUp({
    required String email,
    required String fullname,
    required String password,
  });

  Future<void> updateUser({
    required dynamic userData,
    required UpdateUserAction action,
  });
}
