import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:medical/src/blocs/authentication/authentication.dart';
import 'package:medical/src/blocs/password/password.dart';

import 'package:medical/src/ui/pages/change_password/change_password_form.dart';

import 'package:medical/src/ui/widgets/loading_indicator.dart';

class ChangePasswordPage extends StatefulWidget {
  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  AuthenticationBloc _authenticationBloc;
  ChangePasswordBloc _changePasswordBloc;

  TextEditingController _oldPasswordController = TextEditingController();
  TextEditingController _newPasswordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  @override
  void didChangeDependencies() {
    _authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
    _changePasswordBloc =
        ChangePasswordBloc(authenticationBloc: _authenticationBloc);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _changePasswordBloc?.dispose();
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _onButtonSubmitted() {
    _changePasswordBloc.dispatch(ChangePasswordButtonPressed(
        oldPassword: _oldPasswordController.text,
        newPassword: _newPasswordController.text,
        confirmPassword: _confirmPasswordController.text));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text("Đổi mật khẩu"),
      ),
      body: Container(
        child: BlocListener(
          bloc: _changePasswordBloc,
          listener: (BuildContext context, ChangePasswordState state) {
            if (state is ChangePasswordLoading) {
              showDialog(
                  context: context,
                  builder: (BuildContext context) =>
                      LoadingIndicator(willPop: false));
            }
            if (state is! ChangePasswordLoading &&
                state is! ChangePasswordInitial) {
              Navigator.of(context).pop();
            }
            if (state is ChangePasswordSuccess) {
              showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Thành công!'),
                      content: Text('Cập nhật mật khẩu thành công. '
                          'Bạn cần phải đăng nhập lại bằng mật khẩu mới '
                          'để có thể thao tác trên ứng dụng.'),
                      actions: <Widget>[
                        FlatButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                          },
                          child: Text('Đăng nhập'),
                        )
                      ],
                    );
                  });
            }
            if (state is ChangePasswordFailure) {
              Scaffold.of(context).removeCurrentSnackBar();
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text('${state.error}'),
                  backgroundColor: Colors.redAccent,
                ),
              );
            }
          },
          child: buildBlocBuilder(),
        ),
      ),
    );
  }

  BlocBuilder<ChangePasswordEvent, ChangePasswordState> buildBlocBuilder() {
    return BlocBuilder<ChangePasswordEvent, ChangePasswordState>(
        bloc: _changePasswordBloc,
        builder: (BuildContext context, ChangePasswordState state) {
          return Column(
            children: <Widget>[
              Expanded(
                flex: 6,
                child: ChangePasswordForm(
                  oldPasswordController: _oldPasswordController,
                  newPasswordController: _newPasswordController,
                  confirmPasswordController: _confirmPasswordController,
                ),
              ),
              Material(
                elevation: 5,
                child: new Container(
                  height: 65,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  child: new Row(
                    children: <Widget>[
                      new Expanded(
                          child: Container(
                            margin: EdgeInsets.only(left: 5),
                            decoration: BoxDecoration(
                                color: Colors.blueAccent,
                                borderRadius: BorderRadius.circular(4)),
                            child: new FlatButton(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                onPressed: () {
                                  _onButtonSubmitted();
                                },
                                child: new Text(
                                  "Đổi mật khẩu",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white),
                                )),
                          ))
                    ],
                  ),
                ),
              )
            ],
          );
        });
  }
}
