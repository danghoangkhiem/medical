import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _username?.dispose();
    _password?.dispose();
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
                  child: Column(
                    children: <Widget>[
                      Spacer(),
                      Image.asset('assets/images/logo.png', width: 200),
                      SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                )),
            Expanded(
                flex: 7,
                child: Form(
                    key: _formKey,
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
                      ],
                    ))),
            Expanded(
                flex: 1,
                child: Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  child: Text(
                    'Version: 1.1',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ))
          ],
        ),
      ),
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
            controller: _password,
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
            controller: _username,
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
          onPressed: () {},
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
          onPressed: () {},
          child: Text(
            'HỦY',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),
          )),
    );
  }
}
