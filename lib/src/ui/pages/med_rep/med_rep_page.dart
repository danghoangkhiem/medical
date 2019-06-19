import 'package:flutter/material.dart';

class MedRepPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {

    return new MedRepPageState();
  }
}
class MedRepPageState extends State<MedRepPage>{
  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Quản lý địa bàn trong ngày"),
      ),
      body: new Container(
        child: new Column(
          children: <Widget>[
            InkWell(
              onTap: (){

              },
              child: ListTile(
                title: new Text("Trịnh Quốc Thông"),
                subtitle: new Text("Mã số nhân viên"),
                trailing: new Icon(Icons.assignment_ind, color: Colors.blueAccent,),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: new MedRepPage(),
    );
  }
}