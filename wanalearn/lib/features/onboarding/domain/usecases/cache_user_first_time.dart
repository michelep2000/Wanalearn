import 'package:wanalearn/core/usecases/usecase.dart';
import 'package:wanalearn/core/utils/typedef.dart';
import 'package:wanalearn/features/onboarding/presentation/domain/repositories/onboarding_repository.dart';

class CacheUserFirstTime extends UsecaseWithoutParams<void> {
  const CacheUserFirstTime(this._repository);

  final OnboardingRepository _repository;

  @override
  ResultFuture<void> call() async => _repository.cacheUserFirstTime();
}
