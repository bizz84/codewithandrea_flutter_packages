import 'package:flutter_test/flutter_test.dart';

import 'package:firebase_auth_wrapper/firebase_auth_wrapper.dart';

void main() {
  group('User', () {
    test('null uid throws exception', () {
      expect(User(uid: null), throwsAssertionError);
    }, skip: true);
  });
}
