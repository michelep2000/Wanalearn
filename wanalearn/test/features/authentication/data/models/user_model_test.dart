import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:wanalearn/core/utils/typedef.dart';
import 'package:wanalearn/features/authentication/data/models/user_model.dart';
import 'package:wanalearn/features/authentication/domain/entities/user.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const tUserModel = LocalUserModel.empty();

  test('Should be a subclass of [LocalUser] entity', () {
    expect(tUserModel, isA<LocalUser>());
  });

  final tJson = fixture('user.json');
  final tMap = jsonDecode(fixture('user.json')) as DataMap;
  group('fromMap', () {
    test('Should return a [LocalUserModel] with the right data', () {
      // Act: means to do an action (implementation) for the test
      final result = LocalUserModel.fromMap(tMap);

      // Assert: means to check code expectations to pass the test
      expect(result, isA<LocalUserModel>());
      expect(result, equals(tUserModel));
    });

    test('Should throw an [Error], when the map is invalid', () {
      // Arrange: means to setup variables to implement the test (mock answer)
      
      final map = DataMap.from(tMap)..remove('uid');
      const call = LocalUserModel.fromMap;

      // Assert: means to check code expectations to pass the test
      expect(() => call(map), throwsA(isA<Error>()));
    });
  });

  group('fromJson', () {
    test('Should return a [LocalUserModel] with the right data', () {
      // Act: means to do an action (implementation) for the test
      final result = LocalUserModel.fromJson(tJson);

      // Assert: means to check code expectations to pass the test
      expect(result, equals(tUserModel));
    });
  });

  group('toMap', () {
    test('Should return a [Map] with the right data', () {
      // Act: means to do an action (implementation) for the test
      final result = tUserModel.toMap();

      // Assert: means to check code expectations to pass the test
      expect(result, equals(tMap));
    });
  });

  group('toJson', () {
    test('Should return a [JSON] string with the right data', () {
      // Act: means to do an action (implementation) for the test
      final result = tUserModel.toJson();

      // Assert: means to check code expectations to pass the test
      expect(result, equals(tJson));
    });
  });

  const tEmail = 'test.email@example.com';
  group('copyWith', () {
    test('Should return a [UserModel] with different data', () {
      // Act: means to do an action (implementation) for the test
      final result = tUserModel.copyWith(email: tEmail);

      // Assert: means to check code expectations to pass the test
      expect(result.email, equals(tEmail));
    });
  });
}
