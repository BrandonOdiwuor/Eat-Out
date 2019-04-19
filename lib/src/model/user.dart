import 'package:firebase_auth/firebase_auth.dart';

class User {
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
    print('Invoked');
    final FirebaseUser user = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    currentUser = user;
    return currentUser == null ? false : true;
  }

  void logout() async {
    await _auth.signOut();
  }
}