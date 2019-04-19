import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'colors.dart';
import 'register.dart';

class AuthenticationForm extends StatefulWidget {
  final Function handler;
  final String type;

  AuthenticationForm({@required this.type, @required this.handler})
    : assert(type != null),
      assert(handler != null);

  @override
  _AuthenticationFormState createState() => _AuthenticationFormState();
}

class _AuthenticationFormState extends State<AuthenticationForm> {
  final _emailController = TextEditingController();
  final _passwordControlelr = TextEditingController();
  String text;
  Function onTap;

  @override
  void initState() {
    if(widget.type.toUpperCase() == 'LOGIN') {
      text = 'No account yet? Create one';
      onTap = () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Register(),
          ),
        );
      };
    } else {
      text = 'Already have an Acoount? Login';
      onTap = () {
        Navigator.pop(context);
      };
    }
    super.initState();
  }

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
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
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
                    _emailController.clear();
                    _passwordControlelr.clear();
                  },
                ),
                RaisedButton(
                  color: cranePurple700,
                  child: Text(
                    widget.type.toUpperCase(),
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
                    _handler;
                  },
                ),
              ],
            ),
            SizedBox(height: 12.0),
            Center(
              child: GestureDetector(
                child: Text(
                  text,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16.0,
                    color: cranePurple700,
                  ),
                ),
                onTap: onTap,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handler() {
    widget.handler(
      email: _emailController.text,
      password: _passwordControlelr.text,
    );
  }
}