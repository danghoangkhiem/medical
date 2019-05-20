import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';

class AttendanceHistoryPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return new AttendanceHistoryPageState();
  }
}
class AttendanceHistoryPageState extends State<AttendanceHistoryPage>{
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  DateTime starDay;
  DateTime endDay;


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.blueAccent,
        title: new Text("Lịch sử chấm công"),
      ),
      body: new Container(
        child: new Column(
          children: <Widget>[
            new Expanded(
                flex: 3,
                child: new Form(
                    key: _formKey,
                    child: new ListView(
                      children: <Widget>[
                        new Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          child: new Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              new SizedBox(height: 20,),
                              new Row(
                                children: <Widget>[
                                  new Text("Từ ngày ", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black54),),
                                  new SizedBox(width: 30,),
                                  new Flexible(
                                    child: DateTimePickerFormField(
                                      inputType: InputType.date,
                                      format: DateFormat("dd-MM-yyyy"),
                                      initialDate: DateTime.now(),
                                      editable: false,
                                      decoration: InputDecoration(
                                        labelText: 'Chọn ngày bắt đầu',
                                        labelStyle: new TextStyle(fontWeight: FontWeight.normal, color: Colors.grey),
                                        hasFloatingPlaceholder: false,
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.blueAccent, width: 2)
                                        ),
                                        border: OutlineInputBorder(),
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 10),
                                      ),
                                      style: new TextStyle(fontSize: 18, color: Colors.blueAccent, fontWeight: FontWeight.bold),
                                      onChanged: (dt) {
                                        if(dt != null){
                                          setState(() {
                                            starDay = dt;
                                          });
                                        }
                                      },
                                    ),
                                  )
                                ],
                              ),
                              new SizedBox(height: 10,),
                              new Row(
                                children: <Widget>[
                                  new Text("Đến ngày ", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black54),),
                                  new SizedBox(width: 20,),
                                  new Flexible(
                                    child: DateTimePickerFormField(
                                      inputType: InputType.date,
                                      format: DateFormat("dd-MM-yyyy"),
                                      initialDate: DateTime.now(),
                                      editable: false,
                                      decoration: InputDecoration(
                                        labelText: 'Chọn ngày kết thúc',
                                        labelStyle: new TextStyle(fontWeight: FontWeight.normal, color: Colors.grey),
                                        hasFloatingPlaceholder: false,
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.blueAccent, width: 2)
                                        ),
                                        border: OutlineInputBorder(),
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 10),
                                      ),
                                      style: new TextStyle(fontSize: 18, color: Colors.blueAccent, fontWeight: FontWeight.bold),
                                      onChanged: (dt) {
                                        if(dt != null){
                                          setState(() {
                                            endDay = dt;
                                          });
                                        }
                                      },
                                    ),
                                  )
                                ],
                              ),
                              new SizedBox(
                                height: 10,
                              ),
                              new Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.blueAccent,
                                ),
                                height: 42,
                                child: FlatButton(
                                    onPressed: (){
                                      if(starDay !=null && endDay!=null){
                                        print("tìm $starDay - $endDay");
                                      }
                                      else{
                                        print("Chua du dieu kien tim");
                                      }
                                    },
                                    child: new Text("Tìm", style: new TextStyle(fontSize: 18, color: Colors.white),)
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    )
                )
            ),
            new Expanded(
                flex: 6,
                child: new Container(
                  child: new SingleChildScrollView(
                    child: new Column(
                      children: <Widget>[
                        new Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          height: 100,
                          color: Colors.white,
                          child: new Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              new Text("Bệnh viện bình dân", style: new TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                              new SizedBox(height: 10,),
                              new Container(
                                margin: EdgeInsets.only(left: 20),
                                child: new Row(
                                  children: <Widget>[
                                    new Container(
                                      margin: EdgeInsets.only(right: 15),
                                      child: new Icon(Icons.check_circle, color: Colors.green,),
                                    ),
                                    new Container(
                                      child: new Text("7:29 29/4/2019", style: new TextStyle(fontSize: 16, color: Colors.black54),),
                                    )
                                  ],
                                ),
                              ),
                              new SizedBox(height: 3,),
                              new Container(
                                margin: EdgeInsets.only(left: 20),
                                child: new Row(
                                  children: <Widget>[
                                    new Container(
                                      margin: EdgeInsets.only(right: 15),
                                      child: new Icon(Icons.check_circle, color: Colors.deepOrange,),
                                    ),
                                    new Container(
                                      child: new Text("7:29 29/4/2019", style: new TextStyle(fontSize: 16, color: Colors.black54),),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        new Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          height: 100,
                          color: Colors.white,
                          child: new Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              new Text("Bệnh viện bình dân", style: new TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                              new SizedBox(height: 10,),
                              new Container(
                                margin: EdgeInsets.only(left: 20),
                                child: new Row(
                                  children: <Widget>[
                                    new Container(
                                      margin: EdgeInsets.only(right: 15),
                                      child: new Icon(Icons.check_circle, color: Colors.green,),
                                    ),
                                    new Container(
                                      child: new Text("7:29 29/4/2019", style: new TextStyle(fontSize: 16, color: Colors.black54),),
                                    )
                                  ],
                                ),
                              ),
                              new SizedBox(height: 3,),
                              new Container(
                                margin: EdgeInsets.only(left: 20),
                                child: new Row(
                                  children: <Widget>[
                                    new Container(
                                      margin: EdgeInsets.only(right: 15),
                                      child: new Icon(Icons.check_circle, color: Colors.deepOrange,),
                                    ),
                                    new Container(
                                      child: new Text("7:29 29/4/2019", style: new TextStyle(fontSize: 16, color: Colors.black54),),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        new Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          height: 100,
                          color: Colors.white,
                          child: new Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              new Text("Bệnh viện bình dân", style: new TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                              new SizedBox(height: 10,),
                              new Container(
                                margin: EdgeInsets.only(left: 20),
                                child: new Row(
                                  children: <Widget>[
                                    new Container(
                                      margin: EdgeInsets.only(right: 15),
                                      child: new Icon(Icons.check_circle, color: Colors.green,),
                                    ),
                                    new Container(
                                      child: new Text("7:29 29/4/2019", style: new TextStyle(fontSize: 16, color: Colors.black54),),
                                    )
                                  ],
                                ),
                              ),
                              new SizedBox(height: 3,),
                              new Container(
                                margin: EdgeInsets.only(left: 20),
                                child: new Row(
                                  children: <Widget>[
                                    new Container(
                                      margin: EdgeInsets.only(right: 15),
                                      child: new Icon(Icons.check_circle, color: Colors.deepOrange,),
                                    ),
                                    new Container(
                                      child: new Text("7:29 29/4/2019", style: new TextStyle(fontSize: 16, color: Colors.black54),),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        new Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          height: 100,
                          color: Colors.white,
                          child: new Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              new Text("Bệnh viện bình dân", style: new TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                              new SizedBox(height: 10,),
                              new Container(
                                margin: EdgeInsets.only(left: 20),
                                child: new Row(
                                  children: <Widget>[
                                    new Container(
                                      margin: EdgeInsets.only(right: 15),
                                      child: new Icon(Icons.check_circle, color: Colors.green,),
                                    ),
                                    new Container(
                                      child: new Text("7:29 29/4/2019", style: new TextStyle(fontSize: 16, color: Colors.black54),),
                                    )
                                  ],
                                ),
                              ),
                              new SizedBox(height: 3,),
                              new Container(
                                margin: EdgeInsets.only(left: 20),
                                child: new Row(
                                  children: <Widget>[
                                    new Container(
                                      margin: EdgeInsets.only(right: 15),
                                      child: new Icon(Icons.check_circle, color: Colors.deepOrange,),
                                    ),
                                    new Container(
                                      child: new Text("7:29 29/4/2019", style: new TextStyle(fontSize: 16, color: Colors.black54),),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        new Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          height: 100,
                          color: Colors.white,
                          child: new Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              new Text("Bệnh viện bình dân", style: new TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                              new SizedBox(height: 10,),
                              new Container(
                                margin: EdgeInsets.only(left: 20),
                                child: new Row(
                                  children: <Widget>[
                                    new Container(
                                      margin: EdgeInsets.only(right: 15),
                                      child: new Icon(Icons.check_circle, color: Colors.green,),
                                    ),
                                    new Container(
                                      child: new Text("7:29 29/4/2019", style: new TextStyle(fontSize: 16, color: Colors.black54),),
                                    )
                                  ],
                                ),
                              ),
                              new SizedBox(height: 3,),
                              new Container(
                                margin: EdgeInsets.only(left: 20),
                                child: new Row(
                                  children: <Widget>[
                                    new Container(
                                      margin: EdgeInsets.only(right: 15),
                                      child: new Icon(Icons.check_circle, color: Colors.deepOrange,),
                                    ),
                                    new Container(
                                      child: new Text("7:29 29/4/2019", style: new TextStyle(fontSize: 16, color: Colors.black54),),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        new Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          height: 100,
                          color: Colors.white,
                          child: new Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              new Text("Bệnh viện bình dân", style: new TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                              new SizedBox(height: 10,),
                              new Container(
                                margin: EdgeInsets.only(left: 20),
                                child: new Row(
                                  children: <Widget>[
                                    new Container(
                                      margin: EdgeInsets.only(right: 15),
                                      child: new Icon(Icons.check_circle, color: Colors.green,),
                                    ),
                                    new Container(
                                      child: new Text("7:29 29/4/2019", style: new TextStyle(fontSize: 16, color: Colors.black54),),
                                    )
                                  ],
                                ),
                              ),
                              new SizedBox(height: 3,),
                              new Container(
                                margin: EdgeInsets.only(left: 20),
                                child: new Row(
                                  children: <Widget>[
                                    new Container(
                                      margin: EdgeInsets.only(right: 15),
                                      child: new Icon(Icons.check_circle, color: Colors.deepOrange,),
                                    ),
                                    new Container(
                                      child: new Text("7:29 29/4/2019", style: new TextStyle(fontSize: 16, color: Colors.black54),),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),

                      ],
                    ),
                  ),
                )
            )
          ],
        ),
      ),
    );
  }
}

