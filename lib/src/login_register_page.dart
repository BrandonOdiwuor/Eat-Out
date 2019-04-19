import 'package:flutter/material.dart';
import 'partials/authentication_form.dart';
import 'model/user.dart';

class LoginRegisterPage extends StatelessWidget {
  final User user;

  LoginRegisterPage({this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthenticationForm(user: user),
    );
  }

}