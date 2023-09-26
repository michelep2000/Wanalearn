import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wanalearn/features/onboarding/data/datasources/onboarding_local_data_source.dart';
import 'package:wanalearn/features/onboarding/data/repositories/onboarding_repository_impl.dart';
import 'package:wanalearn/features/onboarding/domain/repositories/onboarding_repository.dart';
import 'package:wanalearn/features/onboarding/domain/usecases/cache_user_first_time.dart';
import 'package:wanalearn/features/onboarding/domain/usecases/check_if_user_first_time.dart';
import 'package:wanalearn/features/onboarding/presentation/bloc/onboarding_bloc.dart';

final sl = GetIt.instance;

Future<void> injectDependencies() async {
  final sharedPreferences = await SharedPreferences.getInstance();

  sl
    // Bloc - App logic
    ..registerFactory(
      () => OnboardingBloc(
        cacheUserFirstTime: sl(),
        checkIfUserFirstTime: sl(),
      ),
    )
    // Usecases
    ..registerLazySingleton(() => CacheUserFirstTime(sl()))
    ..registerLazySingleton(() => CheckIfUserFirstTime(sl()))
    // Repository
    ..registerLazySingleton<OnboardingRepository>(
      () => OnboardingRepositoryImpl(sl()),
    )
    // Data Source
    ..registerLazySingleton<OnboardingLocalDataSource>(
      () => OnboardingLocalDataSourceImpl(sl()),
    )
    // External Libraries
    ..registerLazySingleton(() => sharedPreferences);
}
