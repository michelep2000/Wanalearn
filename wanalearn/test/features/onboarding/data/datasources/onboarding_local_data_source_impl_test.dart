import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wanalearn/core/errors/exceptions.dart';
import 'package:wanalearn/features/onboarding/data/datasources/onboarding_local_data_source.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late SharedPreferences sharedPreferences;
  late OnboardingLocalDataSourceImpl localDataSourceImpl;
  late CacheException tCacheException;

  setUp(() {
    sharedPreferences = MockSharedPreferences();
    localDataSourceImpl = OnboardingLocalDataSourceImpl(sharedPreferences);
    tCacheException = const CacheException(
      message: 'Insufficient storage',
    );
  });

  group('cacheUserFirstTime', () {
    test(
        'Should call [localDataSource.cacheUserFirstTime] and save'
        ' a bool in the [SharedPreferences]', () async {
      // Arrange: means to setup variables to implement the test (mock answer)
      when(() => sharedPreferences.setBool(any(), any())).thenAnswer(
        (_) async => true,
      );

      // Act: means to do an action (implementation) for the test
      await localDataSourceImpl.cacheUserFirstTime();

      // Assert: means to check code expectations to pass the test
      verify(() => sharedPreferences.setBool(kUserFirstTime, false));
      verifyNoMoreInteractions(sharedPreferences);
    });

    test(
        'Should throw [CacheException] when there is an error caching the data',
        () async {
      // Arrange: means to setup variables to implement the test (mock answer)
      when(
        () => sharedPreferences.setBool(any(), any()),
      ).thenThrow(tCacheException);

      // Act: means to do an action (implementation) for the test
      final methodCall = localDataSourceImpl.cacheUserFirstTime;

      // Assert: means to check code expectations to pass the test
      expect(() async => methodCall(), throwsA(isA<CacheException>()));
      verify(() => sharedPreferences.setBool(kUserFirstTime, false)).called(1);
      verifyNoMoreInteractions(sharedPreferences);
    });
  });

  group('checkIfUserFirstTime', () {
    test(
        'Should check user first time in [SharedPreferences] and return '
        ' a [bool] from storage if the data exists', () async {
      // Arrange: means to setup variables to implement the test (mock answer)
      when(() => sharedPreferences.getBool(any())).thenReturn(false);

      // Act: means to do an action (implementation) for the test
      final result = await localDataSourceImpl.checkIfUserFirstTime();
      // Assert: means to check code expectations to pass the test
      expect(result, equals(false));

      verify(() => sharedPreferences.getBool(kUserFirstTime)).called(1);
      verifyNoMoreInteractions(sharedPreferences);
    });

    test(
        'Should check user first time in [SharedPreferences] and return '
        'a [true] from storage, if the data do not exists', () async {
      // Arrange: means to setup variables to implement the test (mock answer)
      when(() => sharedPreferences.getBool(any())).thenReturn(null);

      // Act: means to do an action (implementation) for the test
      final result = await localDataSourceImpl.checkIfUserFirstTime();
      // Assert: means to check code expectations to pass the test
      expect(result, equals(true));

      verify(() => sharedPreferences.getBool(kUserFirstTime)).called(1);
      verifyNoMoreInteractions(sharedPreferences);
    });

    test(
      'Should throw a [CacheException] when there is an error',
      () async {
    
      // Arrange: means to setup variables to implement the test (mock answer)
      when(() => sharedPreferences.getBool(any())).thenThrow(tCacheException);
    
      // Act: means to do an action (implementation) for the test
      final callMethod = localDataSourceImpl.checkIfUserFirstTime;
    
      // Assert: means to check code expectations to pass the test
      expect(callMethod, throwsA(isA<CacheException>()));

      verify(() => sharedPreferences.getBool(kUserFirstTime)).called(1);
      verifyNoMoreInteractions(sharedPreferences);
    
      }
    );

  });
}
