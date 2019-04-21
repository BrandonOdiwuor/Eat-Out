import 'package:flutter/material.dart';
import 'partials/colors.dart';
import 'model/authentication.dart';
import 'login_register_page.dart';

class EatOutApp extends StatelessWidget {
  final Authentication authentication = Authentication();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Eat Out',
      home: LoginRegisterPage(authentication: authentication),
      debugShowCheckedModeBanner: false,
      theme: _buildTheme(),
    );
  }

  ThemeData _buildTheme() {
    final base = ThemeData.light();
    return base.copyWith(
      primaryColor: cranePurple800,
      accentColor: craneRed700,
      errorColor: craneErrorOrange,
      buttonTheme: base.buttonTheme.copyWith(
        buttonColor: cranePurple800,
      ),
      textTheme: _buildTextTheme(base.textTheme),
      primaryTextTheme: _buildTextTheme(base.primaryTextTheme),
      accentTextTheme: _buildTextTheme(base.accentTextTheme),
    );
  }

  TextTheme _buildTextTheme(TextTheme base) {
    return base.apply(
        fontFamily: 'Raleway'
    );
  }
}