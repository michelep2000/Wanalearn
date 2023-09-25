import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wanalearn/features/onboarding/domain/usecases/cache_user_first_time.dart';
import 'package:wanalearn/features/onboarding/domain/usecases/check_if_user_first_time.dart';

part 'onboarding_event.dart';
part 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  OnboardingBloc({
    required CacheUserFirstTime cacheUserFirstTime,
    required CheckIfUserFirstTime checkIfUserFirstTime,
  })  : _cacheUserFirstTime = cacheUserFirstTime,
        _checkIfUserFirstTime = checkIfUserFirstTime,
        super(const OnboardingInitialState()) {
    on<CacheUserFirstTimeEvent>(_cacheUserFirstTimeHandler);
    on<CheckIfUserFirstTimeEvent>(_checkIfUserFirstTimeHandler);
  }

  final CacheUserFirstTime _cacheUserFirstTime;
  final CheckIfUserFirstTime _checkIfUserFirstTime;

  FutureOr<void> _cacheUserFirstTimeHandler(
    OnboardingEvent event,
    Emitter<OnboardingState> emit,
  ) async {
    emit(const CacheUserFirstTimeLoadingState());

    final result = await _cacheUserFirstTime();

    result.fold(
      (failure) => emit(OnboardingErrorState(message: failure.errorMessage)),
      (_) => emit(const CacheUserFirstTimeSuccessState()),
    );
  }

  FutureOr<void> _checkIfUserFirstTimeHandler(
    OnboardingEvent event,
    Emitter<OnboardingState> emit,
  ) async {
    emit(const CheckIfUserFirstTimeLoadingState());

    final result = await _checkIfUserFirstTime();

    result.fold(
      (failure) => emit(
        const CheckIfUserFirstTimeSuccessState(isUserFirstTime: true),
      ),
      (isUserFirstTime) => emit(
        CheckIfUserFirstTimeSuccessState(isUserFirstTime: isUserFirstTime),
      ),
    );
  }
}
