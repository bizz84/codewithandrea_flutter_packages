library firebase_auth_service;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

class AppUser {
  const AppUser({
    @required this.uid,
    this.email,
    this.photoUrl,
    this.displayName,
  }) : assert(uid != null, 'User can only be created with a non-null uid');

  final String uid;
  final String email;
  final String photoUrl;
  final String displayName;

  factory AppUser.fromFirebaseUser(User user) {
    if (user == null) {
      return null;
    }
    return AppUser(
      uid: user.uid,
      email: user.email,
      displayName: user.displayName,
      photoUrl: user.photoURL,
    );
  }

  @override
  String toString() =>
      'uid: $uid, email: $email, photoUrl: $photoUrl, displayName: $displayName';
}

class FirebaseAuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Stream<AppUser> get onAuthStateChanged {
    return _firebaseAuth
        .authStateChanges()
        .map((firebaseUser) => AppUser.fromFirebaseUser(firebaseUser));
  }

  Future<AppUser> signInAnonymously() async {
    final userCredential = await _firebaseAuth.signInAnonymously();
    return AppUser.fromFirebaseUser(userCredential.user);
  }

  Future<AppUser> signInWithEmailAndPassword(
      String email, String password) async {
    final userCredential =
        await _firebaseAuth.signInWithCredential(EmailAuthProvider.credential(
      email: email,
      password: password,
    ));
    return AppUser.fromFirebaseUser(userCredential.user);
  }

  Future<AppUser> createUserWithEmailAndPassword(
      String email, String password) async {
    final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    return AppUser.fromFirebaseUser(userCredential.user);
  }

  Future<void> sendPasswordResetEmail(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  AppUser get currentUser =>
      AppUser.fromFirebaseUser(_firebaseAuth.currentUser);

  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }
}
