import 'package:flutter/material.dart';
import 'partials/authentication_form.dart';
import 'model/authentication.dart';

class LoginRegisterPage extends StatelessWidget {
  final Authentication authentication;

  LoginRegisterPage({this.authentication});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthenticationForm(authentication: authentication),
    );
  }

}