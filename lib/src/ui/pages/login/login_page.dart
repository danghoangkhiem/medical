import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:medical/src/blocs/authentication/authentication.dart';
import 'package:medical/src/blocs/login/login.dart';

import 'login_form.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginBloc _loginBloc;
  AuthenticationBloc _authenticationBloc;

  @override
  void initState() {
    _authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
    _loginBloc = LoginBloc(authenticationBloc: _authenticationBloc);
    super.initState();
  }

  @override
  void dispose() {
    _loginBloc?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blueAccent,
        child: Column(
          children: <Widget>[
            Expanded(
                flex: 4,
                child: Container(
                  alignment: Alignment.bottomCenter,
                  width: double.infinity,
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Image.asset('assets/images/logo.png', width: 200),
                        SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                  ),
                )),
            Expanded(
                flex: 7,
                child: LoginForm(
                    loginBloc: _loginBloc,
                    authenticationBloc: _authenticationBloc
                )
            ),
            Expanded(
                flex: 1,
                child: Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  child: Text(
                    'Version: 1.1',
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
