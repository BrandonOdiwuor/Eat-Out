import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'credentials.dart';

class AuthenticationBloc {
  Authentication _authentication = Authentication();

  AuthenticationBloc() {
    _loginController.stream.listen(_handleLogin);
    _logoutController.stream.listen(_handleLogout);
    _registerController.stream.listen(_handleRegister);
  }
  final _loginController = StreamController<Credentials>();
  Sink get login => _loginController.sink;

  final _registerController = StreamController<Credentials>();
  Sink get register => _registerController.sink;

  final _logoutController = StreamController<bool>();
  Sink get logout => _logoutController.sink;

  final _currentUserBS = BehaviorSubject<FirebaseUser>();
  Stream get currentUser => _currentUserBS.stream;

  final _isLoggedInBS = BehaviorSubject.seeded(false);
  Stream<bool> get isLoggedIn => _isLoggedInBS.stream;

  void _handleLogin(Credentials credentials) async {
    _authentication.login(
      email: credentials.email,
      password: credentials.password,
    ).then((isSuccessful) {
      if(isSuccessful) {
        _isLoggedInBS.add(true);
        _currentUserBS.add(_authentication.currentUser);
      }
    });
  }

  void _handleLogout(bool logout) async {
    _authentication.logout().then((_){
      _isLoggedInBS.add(false);
    });
  }

  void _handleRegister(Credentials credentials) async {
    _authentication.register(
      email: credentials.email,
      password: credentials.password,
    ).then((isSuccessful){
      if(isSuccessful) {
        _isLoggedInBS.add(true);
        _currentUserBS.add(_authentication.currentUser);
      }
    });
  }

  dispose() {
    _loginController.close();
    _registerController.close();
    _logoutController.close();
    _currentUserBS.close();
    _isLoggedInBS.close();
  }
}