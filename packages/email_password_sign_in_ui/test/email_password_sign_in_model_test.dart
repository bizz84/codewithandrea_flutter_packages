import 'package:email_password_sign_in_ui/email_password_sign_in_ui.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

class MockAuthService extends Mock implements FirebaseAuth {}

void main() {
  MockAuthService mockAuthService;
  EmailPasswordSignInModel model;

  setUp(() {
    mockAuthService = MockAuthService();
    model = EmailPasswordSignInModel(firebaseAuth: mockAuthService);
  });

  tearDown(() {
    model.dispose();
  });

  test('updateEmail', () async {
    const sampleEmail = 'email@email.com';
    var didNotifyListeners = false;
    model.addListener(() => didNotifyListeners = true);

    model.updateEmail(sampleEmail);
    expect(model.email, sampleEmail);
    expect(didNotifyListeners, true);
  });
}
