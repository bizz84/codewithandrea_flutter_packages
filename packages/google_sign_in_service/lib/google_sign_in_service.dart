library google_sign_in_service;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_service/firebase_auth_service.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInService {
  Future<AppUser> signInWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount googleUser = await googleSignIn.signIn();

    if (googleUser != null) {
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      if (googleAuth.idToken != null) {
        final userCredential = await FirebaseAuth.instance
            .signInWithCredential(GoogleAuthProvider.credential(
          idToken: googleAuth.idToken,
          // Note: Access token is null when running on web, so we don't check for it above
          accessToken: googleAuth.accessToken,
        ));
        return AppUser.fromFirebaseUser(userCredential.user);
      } else {
        // TODO: Some kind of FirebaseException
        throw FirebaseException(
          plugin: 'GoogleSignInService',
          message: 'Missing Google ID Token',
          code: 'ERROR_MISSING_GOOGLE_ID_TOKEN',
        );
      }
    } else {
      throw PlatformException(
          code: 'ERROR_ABORTED_BY_USER', message: 'Sign in aborted by user');
    }
  }
}
