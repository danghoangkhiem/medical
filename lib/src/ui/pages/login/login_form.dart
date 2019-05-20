import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:medical/src/blocs/authentication/authentication.dart';
import 'package:medical/src/blocs/login/login.dart';

import 'package:medical/src/ui/widgets/loading_indicator.dart';

class LoginForm extends StatefulWidget {
  final LoginBloc loginBloc;
  final AuthenticationBloc authenticationBloc;

  LoginForm({
    Key key,
    @required this.loginBloc,
    @required this.authenticationBloc,
  }) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  LoginBloc get _loginBloc => widget.loginBloc;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginEvent, LoginState>(
      bloc: _loginBloc,
      builder: (
        BuildContext context,
        LoginState state,
      ) {
        if (state is LoginFailure) {
          _onWidgetDidBuild(() {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text('${state.error}'),
                backgroundColor: Colors.red,
              ),
            );
          });
        }
        if (state is LoginLoading) {
          return LoadingIndicator(
            opacity: 0,
            progressIndicatorColor: Colors.white,
          );
        }
        return Form(
          child: ListView(
            children: <Widget>[
              _buildUsernameTextField(),
              SizedBox(
                height: 10,
              ),
              _buildPasswordTextField(),
              SizedBox(
                height: 15,
              ),
              Container(
                height: 50,
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: <Widget>[
                    Expanded(child: _buildButtonCancel()),
                    Expanded(child: _buildButtonLogin())
                  ],
                ),
              )
            ]
          )
        );
      },
    );
  }

  Widget _buildPasswordTextField() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
      ),
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            controller: _passwordController,
            obscureText: true,
            keyboardType: TextInputType.text,
            style: TextStyle(
                fontSize: 18,
                color: Colors.black54,
                fontWeight: FontWeight.bold),
            decoration: InputDecoration(
              hintText: "Mật khẩu đăng nhập",
              hintStyle: TextStyle(color: Colors.black54),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey[400], width: 1)),
              border: OutlineInputBorder(),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUsernameTextField() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
      ),
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            controller: _usernameController,
            keyboardType: TextInputType.text,
            style: TextStyle(
                fontSize: 18,
                color: Colors.black54,
                fontWeight: FontWeight.bold),
            decoration: InputDecoration(
              hintText: "Tên đăng nhập",
              hintStyle: TextStyle(color: Colors.black54),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey[400], width: 1)),
              border: OutlineInputBorder(),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButtonLogin() {
    return Container(
      margin: EdgeInsets.only(left: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
        color: Colors.lightBlueAccent,
      ),
      child: FlatButton(
          padding: EdgeInsets.symmetric(vertical: 14),
          onPressed: _onLoginButtonPressed,
          child: Text(
            'ĐĂNG NHẬP',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),
          )),
    );
  }

  Widget _buildButtonCancel() {
    return Container(
      margin: EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
        color: Colors.lightBlueAccent,
      ),
      child: FlatButton(
          padding: EdgeInsets.symmetric(vertical: 14),
          onPressed: () async {
            final bool accepted = await showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Xác nhận'),
                    content: Text('Bạn có chắc chắn muốn thoát khỏi ứng dụng?'),
                    actions: <Widget>[
                      FlatButton(
                        child: Text('Đóng lại'),
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                      ),
                      FlatButton(
                        child: Text('Thoát'),
                        onPressed: () {
                          Navigator.of(context).pop(true);
                        },
                      ),
                    ],
                  );
                });
            if (accepted) {
              SystemNavigator.pop();
            }
          },
          child: Text(
            'HỦY',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),
          )),
    );
  }

  void _onWidgetDidBuild(Function callback) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      callback();
    });
  }

  void _onLoginButtonPressed() {
    _loginBloc.dispatch(LoginButtonPressed(
      username: _usernameController.text,
      password: _passwordController.text,
    ));
  }
}
