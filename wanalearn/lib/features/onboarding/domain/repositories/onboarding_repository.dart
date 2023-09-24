import 'package:wanalearn/core/utils/typedef.dart';

abstract class OnboardingRepository {

  const OnboardingRepository();

  ResultFuture<void> cacheUserFirstTime();
  ResultFuture<bool> checkIfUserFirstTime();
}
