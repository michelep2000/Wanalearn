import 'package:shared_preferences/shared_preferences.dart';
import 'package:wanalearn/core/errors/exceptions.dart';

abstract class OnboardingLocalDataSource {
  const OnboardingLocalDataSource();

  Future<void> cacheUserFirstTime();
  Future<bool> checkIfUserFirstTime();
}

const kUserFirstTime = 'user_first_time';

class OnboardingLocalDataSourceImpl implements OnboardingLocalDataSource {
  OnboardingLocalDataSourceImpl(this._sharedPreferences);

  final SharedPreferences _sharedPreferences;

  @override
  Future<void> cacheUserFirstTime() async {
    try {
      await _sharedPreferences.setBool(kUserFirstTime, false);
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }

  @override
  Future<bool> checkIfUserFirstTime() async {
    try {
      return _sharedPreferences.getBool(kUserFirstTime) ?? true;
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }
}
