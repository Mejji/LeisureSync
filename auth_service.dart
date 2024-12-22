import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;

  // Create a new user account with email and password
  Future<User?> createUserWithEmailAndPassword(String email, String password) async {
    try {
      final cred = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return cred.user;
    } on FirebaseAuthException catch (e) {
      // Log specific Firebase error messages for better debugging
      log("Firebase Error during signup: ${e.message}");
      // You can rethrow the exception or return null and handle the error in the UI
      rethrow; // This will rethrow the exception to be caught in the UI
    } catch (e) {
      log("Something went wrong during signup: $e");
      return null;
    }
  }

  // Sign in a user with email and password
  Future<User?> loginUserWithEmailAndPassword(String email, String password) async {
    try {
      final cred = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return cred.user;
    } on FirebaseAuthException catch (e) {
      // Log specific Firebase error messages for better debugging
      log("Firebase Error during login: ${e.message}");
      // You can rethrow the exception or return null and handle the error in the UI
      rethrow; // This will rethrow the exception to be caught in the UI
    } catch (e) {
      log("Something went wrong during login: $e");
      return null;
    }
  }

  // Sign out the current user
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      log("Something went wrong during signout: $e");
    }
  }
}