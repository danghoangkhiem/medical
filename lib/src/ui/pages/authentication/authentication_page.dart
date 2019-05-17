import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:medical/src/blocs/authentication/authentication.dart';

import 'package:medical/src/ui/pages/login/login_page.dart';

class AuthenticationPage extends StatefulWidget {
  @override
  _AuthenticationPageState createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {

  AuthenticationBloc _authenticationBloc;

  @override
  void initState() {
    _authenticationBloc = AuthenticationBloc();
    _authenticationBloc.dispatch(AuthenticationEvent.identified());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder(
        bloc: _authenticationBloc,
        builder: (BuildContext context, AuthenticationState state) {
          return LoginPage();
          return Container();
        },
      ),
    );
  }
}