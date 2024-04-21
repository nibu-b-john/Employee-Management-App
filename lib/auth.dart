import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  User? get currentUser => _firebaseAuth.currentUser;
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<List> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return [true, 'Successfully logged In!'];
    } on FirebaseException catch (e) {
      return [false, e.message];
    }
  }

  Future<List> resetEmailLink(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      return [true, 'Password reset link sent! Check your email'];
    } on FirebaseException catch (e) {
      return [false, e.message];
    }
  }

  Future<void> createUserWithEmailAndPassword(
      {required String email, required String password}) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
