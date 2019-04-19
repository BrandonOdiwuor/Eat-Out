import 'package:flutter/material.dart';
import 'colors.dart';
import '../model/user.dart';

class AuthenticationForm extends StatefulWidget {
  final User user;

  AuthenticationForm({this.user});

  @override
  _AuthenticationFormState createState() => _AuthenticationFormState();
}

class _AuthenticationFormState extends State<AuthenticationForm> {
  FormMode _currentMode;
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _usernameController = TextEditingController();
  String _buttonText;
  String _switchFormText;
  Function _handler;

  @override
  void initState() {
    _currentMode = FormMode.LOGIN;
    _buttonText = 'LOGIN';
    _switchFormText = 'Create an account';
    _handler = _loginHandler();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _form();
  }

  Widget _form() {
    return SafeArea(
      child: Form(
        key: _formKey,
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
            _usernameField(),
            SizedBox(height: 12.0),
            _emailField(),
            SizedBox(height: 12.0),
            _passwordField(),
            _buttonBar(),
            SizedBox(height: 12.0),
            _switchForms(),
          ],
        ),
      ),
    );
  }

  Widget _emailField() {
    return TextFormField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: 'Email',
        labelStyle: TextStyle(
          color: cranePurple700,
        ),
      ),
      validator: (String email) {
        if(email.isEmpty) {
          return '* Email required';
        }
      },
    );
  }

  Widget _passwordField() {
    return TextFormField(
      controller: _passwordController,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: 'Password',
        labelStyle: TextStyle(
          color: cranePurple700,
        ),
      ),
      obscureText: true,
      validator: (String password) {
        if(password.isEmpty) {
          return '* Password required';
        } else if(password.length < 6) {
          return '* Password should be at least 6 characters';
        }
      },
    );
  }

  Widget _usernameField() {
    if(_currentMode == FormMode.REGISTER) {
      return TextFormField(
        controller: _usernameController,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          labelText: 'Username',
          labelStyle: TextStyle(
            color: cranePurple700,
          ),
        ),
        validator: (String username) {
          if(username.isEmpty) {
            return '* Username required';
          }
        },
      );
    } else {
      return Container();
    }
  }

  Widget _buttonBar() {
    return ButtonBar(
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
            _passwordController.clear();
            _usernameController.clear();
            _formKey.currentState.reset();
          },
        ),
        RaisedButton(
          color: cranePurple700,
          child: Text(
            _buttonText,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          elevation: 8.0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(4.0))
          ),
          onPressed: () {
            if(_formKey.currentState.validate()) {
              _handler();
            }
          },
        ),
      ],
    );
  }

  Function _loginHandler() => () async {
    bool isSuccessful = await widget.user.login(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    );
    if(isSuccessful) {
      print('Signed in successfully');
    }
  };

  Function _registerHandler() => () async {
    bool isSuccessful = await widget.user.register(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    );
    if(isSuccessful) {
      print('Signed up successfully');
    }
  };

  Widget _switchForms() {
    return Center(
      child: GestureDetector(
        child: Text(
          _switchFormText,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 16.0,
            color: cranePurple700,
          ),
        ),
        onTap: _switchFormOnTap(),
      ),
    );
  }

  Function _switchFormOnTap() => () {
    if(_currentMode == FormMode.LOGIN) {
      setState(() {
        _currentMode = FormMode.REGISTER;
        _buttonText = 'REGISTER';
        _switchFormText = 'Have an account? Login';
        _handler = _registerHandler();
      });
    } else {
      setState(() {
        _currentMode = FormMode.LOGIN;
        _buttonText = 'LOGIN';
        _switchFormText = 'Create an account';
        _handler = _loginHandler();
      });
    }
  };
}

enum FormMode {
  REGISTER,
  LOGIN,
}