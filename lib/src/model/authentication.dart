import 'package:firebase_auth/firebase_auth.dart';
import 'user_model.dart';

class Authentication {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser currentUser;
  final userModel = UserModel();

  Future<bool> login({String email, String password}) async {
    final FirebaseUser user = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    currentUser = user;
    if(currentUser != null){userModel.fetch(currentUser.uid);}
    return currentUser == null ? false : true;
  }

  Future<bool> register({String email, String password, String username}) async {
    final FirebaseUser user = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    currentUser = user;
    if(currentUser != null){userModel.upload(currentUser.uid, username);}
    return currentUser == null ? false : true;
  }

  Future<void> logout() async {
    _auth.signOut();
  }
}