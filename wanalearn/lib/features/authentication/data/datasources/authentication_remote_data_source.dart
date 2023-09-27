import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
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

class AuthenticationRemoteDataSourceImpl
    implements AuthenticationRemoteDataSource {
  const AuthenticationRemoteDataSourceImpl({
    required FirebaseAuth authClient,
    required FirebaseFirestore cloudStorageClient,
    required FirebaseStorage dbClient,
  })  : _authClient = authClient,
        _cloudStorageClient = cloudStorageClient,
        _dbClient = dbClient;

  final FirebaseAuth _authClient;
  final FirebaseFirestore _cloudStorageClient;
  final FirebaseStorage _dbClient;

  @override
  Future<void> forgotPassword(String email) {
    // TODO: implement forgotPassword
    throw UnimplementedError();
  }

  @override
  Future<LocalUserModel> signIn(
      {required String email, required String password}) {
    // TODO: implement signIn
    throw UnimplementedError();
  }

  @override
  Future<void> signUp(
      {required String email,
      required String fullname,
      required String password}) {
    // TODO: implement signUp
    throw UnimplementedError();
  }

  @override
  Future<void> updateUser(
      {required userData, required UpdateUserAction action}) {
    // TODO: implement updateUser
    throw UnimplementedError();
  }
}
