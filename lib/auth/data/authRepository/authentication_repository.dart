import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepository {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<String> signInWithGoogle() async {
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final user = await _auth.signInWithCredential(credential);

        if (user == null) {
          return "AuthCancelled";
        }
        return "";
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          // handle the error here
          return e.toString();
        } else if (e.code == 'invalid-credential') {
          // handle the error here
          return e.toString();
        }
      } catch (e) {
        // handle the error here
        return e.toString();
      }
    }

    return "AuthCancelled";
  }

  Future<String> registerUser(String email, String password) async {
    try {
      final userC = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      return "";
    } catch (e) {
      debugPrint(e.toString());
      return e.toString();
    }
  }

  Future<dynamic> signInUser(String email, String password) async {
    try {
      final userC = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return userC;
    } catch (e) {
      debugPrint(e.toString());
      return e.toString();
    }
  }

  Future<void> signOut() async {
    try {
      await googleSignIn.disconnect();
    } catch (e) {
      debugPrint(e.toString());
    }

    try {
      await _auth.signOut();
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
