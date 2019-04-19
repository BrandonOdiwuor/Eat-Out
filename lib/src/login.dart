import 'package:flutter/material.dart';
import 'authentication_form.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthenticationForm(
        type: 'LOGIN',
        handler: handler,
      ),
    );
  }

  void handler({String email, String password}) {

  }
}