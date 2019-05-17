import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:medical/src/blocs/authentication/authentication.dart';

class AuthenticationFailurePage extends StatelessWidget {
  final String errorMessage;

  AuthenticationFailurePage({Key key, this.errorMessage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthenticationBloc bloc =
        BlocProvider.of<AuthenticationBloc>(context);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog<void>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Lỗi xác thực'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text(errorMessage.toString()),
                  ],
                ),
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text('Đăng nhập'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    bloc.dispatch(AuthenticationEvent.loggedOut());
                  },
                ),
              ],
            );
          });
    });
    return Container();
  }
}
