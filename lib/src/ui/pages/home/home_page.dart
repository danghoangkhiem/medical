import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:medical/src/blocs/authentication/authentication.dart';

import 'change_password_page.dart';
import 'synchronize_page.dart';
import 'package:medical/src/ui/pages/check_in/check_in_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _logout() {
    final AuthenticationBloc bloc =
        BlocProvider.of<AuthenticationBloc>(context);
    bloc.dispatch(AuthenticationEvent.loggedOut());
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        color: Colors.grey[300],
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              buildUserInfo(),
              buildAttendance(),
              buildConsumer(),
              buildInventory(),
              buildInvoice(),
              buildSynchronize(),
              buildChangePassword(),
              buildLogout(),
              buildExit()
            ],
          ),
        ),
      ),
    );
  }

  Widget buildUserInfo() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      width: double.infinity,
      height: 100,
      color: Colors.blueAccent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 15,
          ),
          Text(
            'Tên: Nguyễn Thùy Trang',
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            'Mã số NV: HCM12345',
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Container buildAttendance() {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, top: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
        color: Colors.white,
      ),
      height: 60,
      child: FlatButton(
          padding: EdgeInsets.symmetric(horizontal: 0),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) => CheckInPage(),
              ),
            );
          },
          child: ListTile(
            title: Text(
              'Chấm công',
              style: TextStyle(
                  color: Colors.black54,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            leading: Icon(
              Icons.access_alarms,
              size: 35,
              color: Colors.blueAccent,
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 15,
            ),
          )),
    );
  }

  Widget buildConsumer() {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, top: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
        color: Colors.white,
      ),
      height: 60,
      child: FlatButton(
          padding: EdgeInsets.symmetric(horizontal: 0),
          onPressed: () {},
          child: ListTile(
            title: Text(
              'Quản lý khách hàng',
              style: TextStyle(
                  color: Colors.black54,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            leading: Icon(
              Icons.people,
              size: 35,
              color: Colors.blueAccent,
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 15,
            ),
          )),
    );
  }

  Widget buildInventory() {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, top: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
        color: Colors.white,
      ),
      height: 60,
      child: FlatButton(
          padding: EdgeInsets.symmetric(horizontal: 0),
          onPressed: () {},
          child: ListTile(
            title: Text(
              'Quản lý xuất nhập tồn',
              style: TextStyle(
                  color: Colors.black54,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            leading: Icon(
              Icons.shopping_cart,
              size: 35,
              color: Colors.blueAccent,
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 15,
            ),
          )),
    );
  }

  Widget buildInvoice() {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, top: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
        color: Colors.white,
      ),
      height: 60,
      child: FlatButton(
          padding: EdgeInsets.symmetric(horizontal: 0),
          onPressed: () {},
          child: ListTile(
            title: Text(
              'Phiếu xuất nhập hàng',
              style: TextStyle(
                  color: Colors.black54,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            leading: Icon(
              Icons.assignment,
              size: 35,
              color: Colors.blueAccent,
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 15,
            ),
          )),
    );
  }

  Widget buildSynchronize() {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, top: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
        color: Colors.white,
      ),
      height: 60,
      child: FlatButton(
          padding: EdgeInsets.symmetric(horizontal: 0),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => SynchronizePage()));
          },
          child: ListTile(
            title: Text(
              'Đồng bộ dữ liệu',
              style: TextStyle(
                  color: Colors.black54,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            leading: Icon(
              Icons.cloud_upload,
              size: 35,
              color: Colors.blueAccent,
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 15,
            ),
          )),
    );
  }

  Widget buildChangePassword() {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, top: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
        color: Colors.white,
      ),
      height: 60,
      child: FlatButton(
          padding: EdgeInsets.symmetric(horizontal: 0),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => ChangePasswordPage()));
          },
          child: ListTile(
            title: Text(
              'Đổi mật khẩu',
              style: TextStyle(
                  color: Colors.black54,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            leading: Icon(
              Icons.lock_outline,
              size: 35,
              color: Colors.blueAccent,
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 15,
            ),
          )),
    );
  }

  Widget buildLogout() {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, top: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
        color: Colors.white,
      ),
      height: 60,
      child: FlatButton(
          padding: EdgeInsets.symmetric(horizontal: 0),
          onPressed: _logout,
          child: ListTile(
            title: Text(
              'Đăng xuất',
              style: TextStyle(
                  color: Colors.black54,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            leading: Icon(
              Icons.input,
              size: 35,
              color: Colors.blueAccent,
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 15,
            ),
          )),
    );
  }

  Widget buildExit() {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, top: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
        color: Colors.white,
      ),
      height: 60,
      child: FlatButton(
          padding: EdgeInsets.symmetric(horizontal: 0),
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
          child: ListTile(
            title: Text(
              'Thoát',
              style: TextStyle(
                  color: Colors.black54,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            leading: Icon(
              Icons.close,
              size: 35,
              color: Colors.blueAccent,
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 15,
            ),
          )),
    );
  }
}
