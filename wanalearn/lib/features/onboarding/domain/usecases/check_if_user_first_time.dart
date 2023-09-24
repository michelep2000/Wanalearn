import 'package:wanalearn/core/usecases/usecase.dart';
import 'package:wanalearn/core/utils/typedef.dart';
import 'package:wanalearn/features/onboarding/presentation/domain/repositories/onboarding_repository.dart';

class CheckIfUserFirstTime extends UsecaseWithoutParams<bool> {
  CheckIfUserFirstTime(this._repository);


  final OnboardingRepository _repository;

  @override
  ResultFuture<bool> call() => _repository.checkIfUserFirstTime();
}
