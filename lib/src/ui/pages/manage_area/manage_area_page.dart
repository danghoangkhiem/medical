import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ManageArea extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {

    return new ManageAreaState();
  }
}

class ManageAreaState extends State<ManageArea> {

  TimeOfDay _time = TimeOfDay.now();
  DateTime time;
  bool isLonHon12 = false;

  final now = new DateTime.now();



  Future<Null> _selectTime(BuildContext context) async{
    final TimeOfDay picked = await showTimePicker(
        context: context,
        initialTime: _time
    );
    //&& picked != _time
    if(picked !=null){
      if(picked.hour > 12){
        setState(() {
          isLonHon12 = true;
          time = new DateTime(now.year, now.month, now.day, (picked.hour - 12).toInt(), picked.minute);
        });
      }
      else{
        setState(() {
          isLonHon12 = false;
          time = new DateTime(now.year, now.month, now.day, picked.hour, picked.minute);
        });
      }

      //print(DateFormat("yyyy-MM-dd hh:mm:ss a").format(time));
      //print("${_time.hour}:${_time.minute}");
      //print(_time);
    }
  }

  @override
  void initState() {
    super.initState();
    time  = DateTime.now();

    if(time.hour > 12){
      setState(() {
        isLonHon12 = true;
        time = new DateTime(time.year, time.month, time.day, (time.hour - 12).toInt(), time.minute);
      });
    }
    else{
      setState(() {
        isLonHon12 = false;
        time = new DateTime(time.year, time.month, time.day, time.hour, time.minute);
      });
    }
  }


  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.blueAccent,
        title: new Text("Quản lý địa bàn"),
      ),
      body: new Container(
        child: new Column(
          children: <Widget>[
            new Expanded(
                flex: 6,
                child: new Form(
                    key: _formKey,
                    child: new Container(
                      child: new ListView(
                        children: <Widget>[
                          new SizedBox(
                            height: 15,
                          ),
                          new Container(
                            padding: EdgeInsets.symmetric(horizontal: 30),
                            child: new Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                new Container(
                                  child: new Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      new Text(
                                        "Chọn loại địa điểm",
                                        style: new TextStyle(
                                            color: Colors.black54,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16
                                        ),
                                      ),
                                      new SizedBox(
                                        height: 5,
                                      ),
                                      new Container(
                                        padding: EdgeInsets.symmetric(horizontal: 10),
                                        height: 40,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.grey[400],
                                                width: 1,
                                                style: BorderStyle.solid),
                                            borderRadius: BorderRadius.circular(4)),
                                        child: DropdownButtonHideUnderline(
                                          child: new DropdownButton(
                                            isExpanded: true,
                                            items: [
                                              DropdownMenuItem(
                                                child: new Text("Bệnh viện 115"),
                                                value: 1,
                                              ),
                                              DropdownMenuItem(
                                                child: new Text("Bệnh viện 116"),
                                                value: 1,
                                              ),
                                              DropdownMenuItem(
                                                child: new Text("Bệnh viện 117"),
                                                value: 1,
                                              )
                                            ],
                                            onChanged: (value){

                                            },
                                            style: new TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.blueAccent),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                new SizedBox(height: 17,),
                                new Container(
                                  child: new Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      new Text(
                                        "Thời gian dự kiến",
                                        style: new TextStyle(
                                            color: Colors.black54,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16
                                        ),
                                      ),
                                      new SizedBox(
                                        height: 5,
                                      ),
                                      new Container(
                                        height: 40,
                                        child: new Row(
                                          children: <Widget>[
                                            new Expanded(
                                                child: Padding(
                                                  padding: EdgeInsets.only(right: 5),
                                                  child: new Container(
                                                    alignment: Alignment.center,
                                                    height: double.infinity,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: Colors.grey[400],
                                                            width: 1,
                                                            style: BorderStyle.solid),
                                                        borderRadius: BorderRadius.circular(4)),
                                                    child: new Text("10:20 AM", style: new TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                                                  ),
                                                )
                                            ),
                                            new Expanded(
                                                child: Padding(
                                                  padding: EdgeInsets.only(left: 5),
                                                  child: new Container(
                                                    alignment: Alignment.center,
                                                    height: double.infinity,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: Colors.grey[400],
                                                            width: 1,
                                                            style: BorderStyle.solid),
                                                        borderRadius: BorderRadius.circular(4)),
                                                    child: new Text("11:00 PM", style: new TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                                                  ),
                                                )
                                            )
                                          ],
                                        ),

                                      )
                                    ],
                                  ),
                                ),
                                new SizedBox(height: 17,),
                                new Container(
                                  child: new Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      new Text(
                                        "Thời gian thực tế",
                                        style: new TextStyle(
                                            color: Colors.black54,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16
                                        ),
                                      ),
                                      new SizedBox(
                                        height: 5,
                                      ),
                                      new Container(
                                        height: 40,
                                        child: new Row(
                                          children: <Widget>[
                                            new Expanded(
                                                child: Padding(
                                                  padding: EdgeInsets.only(right: 5),
                                                  child: InkWell(
                                                    onTap: (){
                                                      _selectTime(context);
                                                    },
                                                    child: new Container(
                                                      alignment: Alignment.center,
                                                      height: double.infinity,
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                              color: Colors.grey[400],
                                                              width: 1,
                                                              style: BorderStyle.solid),
                                                          borderRadius: BorderRadius.circular(4)),
                                                      child: !isLonHon12 ? new Text("${time.hour.toString()}:${time.minute.toString()} AM", style: new TextStyle(fontSize: 18, color: Colors.blueAccent,fontWeight: FontWeight.bold),): new Text("${time.hour.toString()}:${time.minute.toString()} PM", style: new TextStyle(fontSize: 18, color: Colors.blueAccent,fontWeight: FontWeight.bold),),
                                                    ),
                                                  ),
                                                )
                                            ),

                                            new Expanded(
                                                child: Padding(
                                                  padding: EdgeInsets.only(left: 5),
                                                  child: InkWell(
                                                    onTap: (){
                                                      _selectTime(context);
                                                    },
                                                    child: new Container(
                                                      alignment: Alignment.center,
                                                      height: double.infinity,
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                              color: Colors.grey[400],
                                                              width: 1,
                                                              style: BorderStyle.solid),
                                                          borderRadius: BorderRadius.circular(4)),
                                                      child: !isLonHon12 ? new Text("${time.hour.toString()}:${time.minute.toString()} AM", style: new TextStyle(fontSize: 18, color: Colors.blueAccent,fontWeight: FontWeight.bold),): new Text("${time.hour.toString()}:${time.minute.toString()} PM", style: new TextStyle(fontSize: 18, color: Colors.blueAccent,fontWeight: FontWeight.bold),),
                                                    ),
                                                  ),
                                                )
                                            )
                                          ],
                                        ),

                                      )
                                    ],
                                  ),
                                ),
                                new SizedBox(height: 17,),
                                new Container(
                                  child: new Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      new Text(
                                        "Tên địa điểm",
                                        style: new TextStyle(
                                            color: Colors.black54,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16
                                        ),
                                      ),
                                      new SizedBox(
                                        height: 5,
                                      ),
                                      new Container(
                                        padding: EdgeInsets.symmetric(horizontal: 10),
                                        height: 40,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.grey[400],
                                                width: 1,
                                                style: BorderStyle.solid),
                                            borderRadius: BorderRadius.circular(4)),
                                        child: DropdownButtonHideUnderline(
                                          child: new DropdownButton(
                                            isExpanded: true,
                                            items: [
                                              DropdownMenuItem(
                                                child: new Text("Bệnh viện 115"),
                                                value: 1,
                                              ),
                                              DropdownMenuItem(
                                                child: new Text("Bệnh viện 116"),
                                                value: 1,
                                              ),
                                              DropdownMenuItem(
                                                child: new Text("Bệnh viện 117"),
                                                value: 1,
                                              )
                                            ],
                                            onChanged: (value){

                                            },
                                            style: new TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.blueAccent),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                new SizedBox(height: 17,),
                                new Container(
                                  child: new Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      new Text(
                                        "Tên khách hàng",
                                        style: new TextStyle(
                                            color: Colors.black54,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16
                                        ),
                                      ),
                                      new SizedBox(
                                        height: 5,
                                      ),
                                      new Container(
                                        padding: EdgeInsets.symmetric(horizontal: 10),
                                        height: 40,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.grey[400],
                                                width: 1,
                                                style: BorderStyle.solid),
                                            borderRadius: BorderRadius.circular(4)),
                                        child: DropdownButtonHideUnderline(
                                          child: new DropdownButton(
                                            isExpanded: true,
                                            items: [
                                              DropdownMenuItem(
                                                child: new Text("Bệnh viện 115"),
                                                value: 1,
                                              ),
                                              DropdownMenuItem(
                                                child: new Text("Bệnh viện 116"),
                                                value: 1,
                                              ),
                                              DropdownMenuItem(
                                                child: new Text("Bệnh viện 117"),
                                                value: 1,
                                              )
                                            ],
                                            onChanged: (value){

                                            },
                                            style: new TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.blueAccent),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                new SizedBox(height: 17,),
                                new Container(
                                  child: new Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      new Text(
                                        "Chọn trạng thái",
                                        style: new TextStyle(
                                            color: Colors.black54,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16
                                        ),
                                      ),
                                      new SizedBox(
                                        height: 5,
                                      ),
                                      new Container(
                                        padding: EdgeInsets.symmetric(horizontal: 10),
                                        height: 40,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.grey[400],
                                                width: 1,
                                                style: BorderStyle.solid),
                                            borderRadius: BorderRadius.circular(4)),
                                        child: DropdownButtonHideUnderline(
                                          child: new DropdownButton(
                                            isExpanded: true,
                                            items: [
                                              DropdownMenuItem(
                                                child: new Text("Bệnh viện 115"),
                                                value: 1,
                                              ),
                                              DropdownMenuItem(
                                                child: new Text("Bệnh viện 116"),
                                                value: 1,
                                              ),
                                              DropdownMenuItem(
                                                child: new Text("Bệnh viện 117"),
                                                value: 1,
                                              )
                                            ],
                                            onChanged: (value){

                                            },
                                            style: new TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.blueAccent),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                new SizedBox(height: 17,),
                                new Container(
                                  child: new Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      new Text(
                                        "Mục tiêu",
                                        style: new TextStyle(
                                            color: Colors.black54,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16
                                        ),
                                      ),
                                      new SizedBox(
                                        height: 5,
                                      ),
                                      new TextFormField(
                                        style: new TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
                                        maxLines: 4,
                                        keyboardType: TextInputType.multiline,
                                        decoration: InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey[400],
                                                  width: 1)),
                                          border: OutlineInputBorder(),
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 10),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                new SizedBox(
                                  height: 17,
                                ),

                              ],
                            ),
                          ),
                        ],
                      ),
                    ))),
            new Expanded(
                flex: 1,
                child: new Container(
                  color: Colors.grey.withOpacity(0.1),
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                  child: new Row(
                    children: <Widget>[
                      new Expanded(
                          child: Container(
                            margin: EdgeInsets.only(left: 5),
                            decoration: BoxDecoration(
                                color: Colors.blueAccent,
                                borderRadius: BorderRadius.circular(4)),
                            child: new FlatButton(
                                padding: EdgeInsets.symmetric(vertical: 13),
                                onPressed: () {},
                                child: new Text(
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