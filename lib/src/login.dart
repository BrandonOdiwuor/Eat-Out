import 'package:flutter/material.dart';
import 'authentication_form.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthenticationForm(
        type: 'Login',
        handler: handler,
      ),
    );
  }

  void handler({String email, String password}) {

  }
}