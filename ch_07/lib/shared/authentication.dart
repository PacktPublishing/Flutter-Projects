import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

class Authentication {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<String> login(String email, String password) async {
    AuthResult authResult = await _firebaseAuth.signInWithEmailAndPassword(
      email: email, password: password
    );
    FirebaseUser user = authResult.user;
    return user.uid;
  }
  Future<String> signUp(String email, String password) async {
    AuthResult authResult = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email, password: password
    );
    FirebaseUser user = authResult.user;
    return user.uid;
  }

  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }

  Future<FirebaseUser> getUser() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user;
  }
}