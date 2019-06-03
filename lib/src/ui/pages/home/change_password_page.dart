import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:medical/src/blocs/authentication/authentication.dart';
import 'package:medical/src/blocs/password/password.dart';

import 'change_password_form.dart';

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
              Expanded(
                  flex: 1,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Colors.blueAccent,
                    ),
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: FlatButton(
                        onPressed: _onButtonSubmitted,
                        child: Text(
                          'Đổi mật khẩu',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        )),
                  ))
            ],
          );
        });
  }
}
