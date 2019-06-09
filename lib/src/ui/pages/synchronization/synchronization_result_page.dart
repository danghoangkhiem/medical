import 'package:flutter/material.dart';

class SynchronizationResultPage extends StatefulWidget {
  @override
  _SynchronizationResultPageState createState() =>
      _SynchronizationResultPageState();
}

class _SynchronizationResultPageState extends State<SynchronizationResultPage> {
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
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                )),
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
                                Navigator.of(context).pop();
                              },
                              child: new Text(
                                "Trang chủ",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white),
                              )),
                        ))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
