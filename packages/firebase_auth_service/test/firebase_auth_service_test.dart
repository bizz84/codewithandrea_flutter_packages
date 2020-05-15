import 'package:flutter_test/flutter_test.dart';

import 'package:firebase_auth_service/firebase_auth_service.dart';

void main() {
  group('User', () {
    test('null uid throws exception', () {
      expect(User(uid: null), throwsAssertionError);
    }, skip: true);
  });
}
