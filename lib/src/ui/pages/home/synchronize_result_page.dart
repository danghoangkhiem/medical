import 'package:flutter/material.dart';

class SynchronizeResultPage extends StatefulWidget {
  @override
  _SynchronizeResultPageState createState() => _SynchronizeResultPageState();
}

class _SynchronizeResultPageState extends State<SynchronizeResultPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text("Đồng bộ dữ liệu"),
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
                      Icons.check_circle_outline,
                      color: Colors.blueAccent,
                      size: 100,
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 5, top: 20),
                      child: Text(
                        'Đồng bộ dữ liệu thành công',
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: 22,
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
                      onPressed: () {},
                      child: Text(
                        'Trang chủ',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      )),
                ))
          ],
        ),
      ),
    );
  }
}
