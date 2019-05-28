import 'package:flutter/material.dart';

class AddCustomerStep1Page extends StatefulWidget {
  @override
  _AddCustomerStep1PageState createState() => _AddCustomerStep1PageState();
}

class _AddCustomerStep1PageState extends State<AddCustomerStep1Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text("Thêm mới khách hàng"),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
                flex: 6,
                child: Form(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: ListView(
                        children: <Widget>[
                          SizedBox(
                            height: 30,
                          ),
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Thông tin sampling",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Colors.blueAccent),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                CheckboxListTile(
                                  value: false,
                                  onChanged: (bool value) {},
                                  title: Text(
                                    "Anmum Concentrate 4X Vanilla",
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  controlAffinity:
                                  ListTileControlAffinity.leading,
                                ),
                                CheckboxListTile(
                                  value: false,
                                  onChanged: (bool value) {},
                                  title: Text(
                                    "Anmum Concentrate 4X Chocolate",
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  controlAffinity:
                                  ListTileControlAffinity.leading,
                                ),
                                CheckboxListTile(
                                  value: false,
                                  onChanged: (bool value) {},
                                  title: Text(
                                    "Anmum Sachet - Chocolate",
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  controlAffinity:
                                  ListTileControlAffinity.leading,
                                ),
                                CheckboxListTile(
                                  value: false,
                                  onChanged: (bool value) {},
                                  title: Text(
                                    "Anmum Sachet - Vanilla",
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  controlAffinity:
                                  ListTileControlAffinity.leading,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ))),
            Expanded(
                flex: 1,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          child: Container(
                            margin: EdgeInsets.only(left: 5),
                            decoration: BoxDecoration(
                                color: Colors.blueAccent,
                                borderRadius: BorderRadius.circular(4)),
                            child: FlatButton(
                                padding: EdgeInsets.symmetric(vertical: 13),
                                onPressed: () {},
                                child: Text(
                                  "TIẾP TỤC",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                )),
                          ))
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}