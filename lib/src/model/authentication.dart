import 'package:firebase_auth/firebase_auth.dart';

class Authentication {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  void signIn(String email, String password) async {
    final FirebaseUser user = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    if(user != null) {

    } else {

    }
  }

  void signUp(String email, String password) async {
    final FirebaseUser user = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    if(user != null) {

    } else {

    }
  }
}