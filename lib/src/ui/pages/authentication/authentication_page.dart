import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:medical/src/blocs/authentication/authentication.dart';

import 'package:medical/src/ui/pages/authentication/authentication_failure_page.dart';
import 'package:medical/src/ui/pages/login/login_page.dart';
import 'package:medical/src/ui/pages/home/home_page.dart';

import 'package:medical/src/ui/widgets/loading_indicator.dart';

class AuthenticationPage extends StatefulWidget {
  @override
  _AuthenticationPageState createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  Future<bool> _onWillPopScope() async {
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final AuthenticationBloc bloc =
        BlocProvider.of<AuthenticationBloc>(context);
    return WillPopScope(
      onWillPop: _onWillPopScope,
      child: Scaffold(
        body: BlocBuilder(
          bloc: bloc,
          builder: (BuildContext context, AuthenticationState state) {
            if (state.isAuthenticating) {
              return LoadingIndicator();
            }
            if (state.hasFailed) {
              return AuthenticationFailurePage(errorMessage: state.error);
            }
            if (!state.isAuthenticated && !state.isAuthenticating) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.of(context)
                    .popUntil(ModalRoute.withName('/authentication'));
              });
            }
            return state.isAuthenticated ? HomePage() : LoginPage();
          },
        ),
      ),
    );
  }
}
