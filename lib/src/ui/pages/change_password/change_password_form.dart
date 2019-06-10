import 'package:flutter/material.dart';

class ChangePasswordForm extends StatefulWidget {
  final TextEditingController oldPasswordController;
  final TextEditingController newPasswordController;
  final TextEditingController confirmPasswordController;

  ChangePasswordForm({
    Key key,
    @required this.oldPasswordController,
    @required this.newPasswordController,
    @required this.confirmPasswordController,
  }) : super(key: key);

  @override
  _ChangePasswordFormState createState() => _ChangePasswordFormState();
}

class _ChangePasswordFormState extends State<ChangePasswordForm> {

  bool isConfirmed;

  @override
  void initState() {
    super.initState();
    isConfirmed = true;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 30),
          children: <Widget>[
            SizedBox(
              height: 30,
            ),
            Container(
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _buildPasswordTextField(),
                  SizedBox(
                    height: 10,
                  ),
                  _buildNewPasswordTextField(),
                  SizedBox(
                    height: 10,
                  ),
                  _buildConfirmPasswordTextField()
                ],
              ),
            ),
          ],
        )
    );
  }

  Widget _buildConfirmPasswordTextField() {
    return TextField(
      onChanged: (String value) {
        setState(() {
          isConfirmed = widget.newPasswordController.text == value;
        });
      },
      controller: widget.confirmPasswordController,
      obscureText: true,
      style: TextStyle(
          fontSize: 16, fontWeight: FontWeight.bold, color: isConfirmed ? Colors.black54 : Colors.redAccent),
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.lock_outline),
        hintText: "Nhập lại mật khẩu mới",
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey[350], width: 1)),
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      ),
    );
  }

  Widget _buildNewPasswordTextField() {
    return TextFormField(
      controller: widget.newPasswordController,
      obscureText: true,
      style: TextStyle(
          fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black54),
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.lock_outline),
        hintText: "Mật khẩu mới",
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey[350], width: 1)),
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      ),
    );
  }

  Widget _buildPasswordTextField() {
    return TextFormField(
      controller: widget.oldPasswordController,
      obscureText: true,
      style: TextStyle(
          fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black54),
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.lock_outline),
        hintText: "Mật khẩu cũ",
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey[350], width: 1)),
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      ),
    );
  }
}
