import 'package:flutter/material.dart';
import 'home_page.dart';
import 'partials/colors.dart';
import 'model/user.dart';
import 'login_register_page.dart';

class EatOutApp extends StatelessWidget {
  final User user = User();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Eat Out',
      home: HomePage(),
      debugShowCheckedModeBanner: false,
      theme: _buildTheme(),
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginRegisterPage(user: user),
      },
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