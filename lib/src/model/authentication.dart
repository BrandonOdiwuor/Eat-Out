import 'package:firebase_auth/firebase_auth.dart';

class Authentication {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser currentUser;

  Future<bool> login({String email, String password}) async {
    final FirebaseUser user = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    currentUser = user;
    return currentUser == null ? false : true;
  }

  Future<bool> register({String email, String password}) async {
    final FirebaseUser user = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    currentUser = user;
    return currentUser == null ? false : true;
  }

  Future<void> logout() async {
    _auth.signOut();
  }
}