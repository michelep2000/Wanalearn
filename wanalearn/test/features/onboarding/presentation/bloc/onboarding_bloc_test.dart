import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wanalearn/core/errors/exceptions.dart';
import 'package:wanalearn/core/errors/failure.dart';
import 'package:wanalearn/features/onboarding/domain/usecases/cache_user_first_time.dart';
import 'package:wanalearn/features/onboarding/domain/usecases/check_if_user_first_time.dart';
import 'package:wanalearn/features/onboarding/presentation/bloc/onboarding_bloc.dart';

class MockCacheUserFirstTime extends Mock implements CacheUserFirstTime {}

class MockCheckIfUserFirstTime extends Mock implements CheckIfUserFirstTime {}

void main() {
  late CacheUserFirstTime cacheUserFirstTime;
  late CheckIfUserFirstTime checkIfUserFirstTime;
  late OnboardingBloc bloc;

  late CacheFailure tCacheFailure;

  setUp(() {
    cacheUserFirstTime = MockCacheUserFirstTime();
    checkIfUserFirstTime = MockCheckIfUserFirstTime();
    bloc = OnboardingBloc(
      cacheUserFirstTime: cacheUserFirstTime,
      checkIfUserFirstTime: checkIfUserFirstTime,
    );

    tCacheFailure = CacheFailure(
      message: 'Insuficient storage',
      statusCode: 4032,
    );
  });

  test('Initial state should be [OnboardingInitialState]', () {
    expect(bloc.state, const OnboardingInitialState());
  });

  group('CacheUserFirtsTime', () {
    blocTest<OnboardingBloc, OnboardingState>(
      'Should emits [CacheUserFirstTimeLoadingState] and '
      '[CacheUserFirstTimeSuccessState] when '
      '[CacheUserFirtsTimeEvent] added is success',
      build: () {
        when(() => cacheUserFirstTime()).thenAnswer(
          (_) async => const Right(null),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(const CacheUserFirstTimeEvent()),
      expect: () => const <OnboardingState>[
        CacheUserFirstTimeLoadingState(),
        CacheUserFirstTimeSuccessState(),
      ],
      verify: (_) {
        verify(() => cacheUserFirstTime()).called(1);
        verifyNoMoreInteractions(cacheUserFirstTime);
      },
    );

    blocTest<OnboardingBloc, OnboardingState>(
      'Should emit [CacheUserFirstTimeLoadingState, OnboardingErrorState] '
      'when [CacheUserFirtsTimeEvent] added is failure',
      build: () {
        when(() => cacheUserFirstTime()).thenAnswer(
          (_) async => Left(
            tCacheFailure,
          ),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(const CacheUserFirstTimeEvent()),
      expect: () => <OnboardingState>[
        const CacheUserFirstTimeLoadingState(),
        OnboardingErrorState(
          message: tCacheFailure.errorMessage,
        ),
      ],
    );
  });

  group('CheckIfUserFirstTime', () {
    blocTest<OnboardingBloc, OnboardingState>(
      'Should emits [CheckIfUserFirstTimeLoadingState] and '
      '[CheckIfUserFirstTimeSuccessState] when '
      '[CheckIfUserFirstTimeEvent] added is success',
      build: () {
        when(() => checkIfUserFirstTime()).thenAnswer(
          (_) async => const Right(false),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(
        const CheckIfUserFirstTimeEvent(),
      ),
      expect: () => const <OnboardingState>[
        CheckIfUserFirstTimeLoadingState(),
        CheckIfUserFirstTimeSuccessState(isUserFirstTime: false),
      ],
      verify: (_) {
        verify(() => checkIfUserFirstTime()).called(1);
        verifyNoMoreInteractions(checkIfUserFirstTime);
      },
    );
    blocTest<OnboardingBloc, OnboardingState>(
      'Should emit [CheckIfUserFirstTimeLoadingState] and '
      '[CheckIfUserFirstTimeSuccessState(true)] '
      'when [CheckIfUserFirstTimeEvent] added is failure',
      build: () {
        when(() => checkIfUserFirstTime())
            .thenAnswer((_) async => const Right(true));
        return bloc;
      },
      act: (bloc) => bloc.add(const CheckIfUserFirstTimeEvent()),
      expect: () => const <OnboardingState>[
        CheckIfUserFirstTimeLoadingState(),
        CheckIfUserFirstTimeSuccessState(isUserFirstTime: true),
      ],
      verify: (_) {
        verify(() => checkIfUserFirstTime()).called(1);
        verifyNoMoreInteractions(checkIfUserFirstTime);
      },
    );
  });
}
