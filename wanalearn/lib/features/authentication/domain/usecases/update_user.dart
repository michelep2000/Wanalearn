import 'package:equatable/equatable.dart';
import 'package:wanalearn/core/enums/update_user_action.dart';
import 'package:wanalearn/core/usecases/usecase.dart';
import 'package:wanalearn/core/utils/typedef.dart';
import 'package:wanalearn/features/authentication/domain/repositories/authentication_repository.dart';

class UpdateUser extends UsecaseWithParams<void, UpdateUserParams> {
  const UpdateUser(this._repository);

  final AuthenticationRepository _repository;
  @override
  ResultFuture<void> call(UpdateUserParams params) async =>
      _repository.updateUser(
        userData: params.userData,
        action: params.action,
      );
}

class UpdateUserParams extends Equatable {
  const UpdateUserParams({
    required this.userData,
    required this.action,
  });

  final dynamic userData;
  final UpdateUserAction action;

  @override
  List<Object?> get props => [userData, action];
}
