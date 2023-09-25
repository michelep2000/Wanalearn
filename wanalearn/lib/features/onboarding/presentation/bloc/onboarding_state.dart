part of 'onboarding_bloc.dart';

sealed class OnboardingState extends Equatable {
  const OnboardingState();

  @override
  List<Object> get props => [];
}

class OnboardingInitialState extends OnboardingState {
  const OnboardingInitialState();
}

class CacheUserFirstTimeLoadingState extends OnboardingState {
  const CacheUserFirstTimeLoadingState();
}

class CheckIfUserFirstTimeLoadingState extends OnboardingState {
  const CheckIfUserFirstTimeLoadingState();
}

class CacheUserFirstTimeSuccessState extends OnboardingState {
  const CacheUserFirstTimeSuccessState();
}

class CheckIfUserFirstTimeSuccessState extends OnboardingState {
  const CheckIfUserFirstTimeSuccessState({
    required this.isUserFirstTime,
  });

  final bool isUserFirstTime;

  @override
  List<bool> get props => [isUserFirstTime];
}

class OnboardingErrorState extends OnboardingState {
  const OnboardingErrorState({required this.message});

  final String message;

  @override
  List<String> get props => [message];
}
