import 'package:flutter/material.dart';
import 'authentication_form.dart';

class Register extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthenticationForm(
        type: 'REGISTER',
        handler: handler,
      ),
    );
  }

  void handler({String email, String password}) {

  }
}