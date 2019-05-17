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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text("Xác thực người dùng"),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
                flex: 6,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.error,
                      color: Colors.redAccent,
                      size: 100,
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 5, top: 20),
                      child: Text(
                        errorMessage.toString(),
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                )),
            Expanded(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.blueAccent,
                  ),
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: FlatButton(
                      onPressed: () {
                        bloc.dispatch(AuthenticationEvent.loggedOut());
                      },
                      child: Text(
                        'Đăng nhập',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      )),
                ))
          ],
        ),
      ),
    );
  }
}
