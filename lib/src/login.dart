import 'package:flutter/material.dart';
import 'colors.dart';
import 'register.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordControlelr = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: cranePurple800,
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            SizedBox(height: 80.0),
            Column(
              children: <Widget>[
                Text(
                  'Eat Out',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 24.0,
                    color: cranePurple700,
                  ),
                ),
              ],
            ),
            SizedBox(height: 120.0),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
                labelStyle: TextStyle(
                  color: cranePurple700,
                ),
              ),
            ),
            SizedBox(height: 12.0),
            TextField(
              controller: _passwordControlelr,
              decoration: InputDecoration(
                labelText: 'Password',
                labelStyle: TextStyle(
                  color: cranePurple700,
                ),
              ),
              obscureText: true,
            ),
            ButtonBar(
              children: <Widget>[
                FlatButton(
                  child: Text(
                    'CANCEL',
                    style: TextStyle(
                      color: cranePurple700,
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4.0))
                  ),
                  onPressed: () {
                    _usernameController.clear();
                    _passwordControlelr.clear();
                  },
                ),
                RaisedButton(
                  color: cranePurple700,
                  child: Text(
                    'LOGIN',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  elevation: 8.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4.0))
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    _handleSignIn();
                  },
                ),
              ],
            ),
            SizedBox(height: 12.0),
            Center(
              child: GestureDetector(
                child: Text(
                  'No account yet? Create one',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16.0,
                    color: cranePurple700,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Register(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleSignIn() {
    // TODO: Implement Sign In Function
  }
}