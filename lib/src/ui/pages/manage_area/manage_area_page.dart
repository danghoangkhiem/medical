import 'package:flutter/material.dart';
import 'package:medical/src/models/manage_area_model.dart';

// ignore: must_be_immutable
class ManageArea extends StatefulWidget {
  ManageAreaItem item;


  ManageArea(this.item);

  @override
  State<StatefulWidget> createState() {

    return new ManageAreaState(item);
  }
}

class ManageAreaState extends State<ManageArea> {
  //form data
  bool _autoValidate = false;
  final _targetController = TextEditingController();
  final _resultController = TextEditingController();
  int _status;  //vd Đã gặp, chưa gặp...

  ManageAreaItem item;


  ManageAreaState(this.item);





  TimeOfDay _time = TimeOfDay.now();
  DateTime _timeStartTarget;
  DateTime _timeEndTarget;
  //bool isLonHon12 = false;



  final now = new DateTime.now();



  Future<Null> _selectTimeStart(BuildContext context) async{
    final TimeOfDay picked = await showTimePicker(
        context: context,
        initialTime: _time
    );
    //&& picked != _time
    if(picked !=null){
      setState(() {
        //isLonHon12 = true;
        _timeStartTarget = new DateTime(now.year, now.month, now.day, picked.hour, picked.minute);
      });
    }
  }

  //viết 2 hàm cho dễ hiểu
  Future<Null> _selectTimeEnd(BuildContext context) async{
    final TimeOfDay picked = await showTimePicker(
        context: context,
        initialTime: _time
    );
    //&& picked != _time
    if(picked !=null){
      setState(() {
        //isLonHon12 = true;
        _timeEndTarget = new DateTime(now.year, now.month, now.day, picked.hour, picked.minute);
      });
    }
  }




  @override
  void initState() {

//    print("ok thong");
//    print(item.toJson());

    _timeStartTarget = item.startTime;
    _timeEndTarget = item.endTime;


    super.initState();

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
                child: new Form(
                    key: _formKey,
                    autovalidate: _autoValidate,
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
                                        "Loại địa điểm",
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
                                        initialValue: item.addressType,
                                        enabled: false,
                                        style: new TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
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
                                      new TextFormField(
                                        initialValue: item.addressName,
                                        enabled: false,
                                        style: new TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
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
                                                    child:item.endTime.hour > 12 ? new Text("${item.startTime.hour - 12}:${item.startTime.minute} PM", style: new TextStyle(fontSize: 18, fontWeight: FontWeight.bold),) : new Text("${item.startTime.hour}:${item.startTime.minute} AM", style: new TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
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
                                                    child: item.endTime.hour > 12 ? new Text("${item.endTime.hour - 12}:${item.endTime.minute} PM", style: new TextStyle(fontSize: 18, fontWeight: FontWeight.bold),) : new Text("${item.endTime.hour}:${item.endTime.minute} AM", style: new TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
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
                                                      _selectTimeStart(context);
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
                                                      child: _timeStartTarget.hour > 12 ? new Text("${_timeStartTarget.hour - 12}:${_timeStartTarget.minute.toString()} PM", style: new TextStyle(fontSize: 18, color: Colors.blueAccent,fontWeight: FontWeight.bold),): new Text("${_timeStartTarget.hour}:${_timeStartTarget.minute} AM", style: new TextStyle(fontSize: 18, color: Colors.blueAccent,fontWeight: FontWeight.bold),),
                                                    ),
                                                  ),
                                                )
                                            ),

                                            new Expanded(
                                                child: Padding(
                                                  padding: EdgeInsets.only(left: 5),
                                                  child: InkWell(
                                                    onTap: (){
                                                      _selectTimeEnd(context);
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
                                                      child: _timeEndTarget.hour > 12 ? new Text("${_timeEndTarget.hour - 12}:${_timeEndTarget.minute.toString()} PM", style: new TextStyle(fontSize: 18, color: Colors.blueAccent,fontWeight: FontWeight.bold),): new Text("${_timeEndTarget.hour}:${_timeEndTarget.minute.toString()} AM", style: new TextStyle(fontSize: 18, color: Colors.blueAccent,fontWeight: FontWeight.bold),),
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
                                      new TextFormField(
                                        initialValue: item.doctorName,
                                        enabled: false,
                                        style: new TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
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
                                            value: _status,
                                            items: [
                                              DropdownMenuItem(
                                                child: new Text("Đã gặp"),
                                                value: 1,
                                              ),
                                              DropdownMenuItem(
                                                child: new Text("Chưa gặp"),
                                                value: 2,
                                              ),
                                              DropdownMenuItem(
                                                child: new Text("Hẹn lần sau"),
                                                value: 3,
                                              )
                                            ],
                                            onChanged: (int value){
                                              setState(() {
                                                _status = value;
                                              });
                                              print(value);

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
                                        validator: (value){
                                          if(value.isEmpty){
                                            return 'Vui lòng nhập mục tiêu cuộc hẹn';
                                          }
                                          return null;
                                        },
                                        controller: _targetController,

                                        style: new TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
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

                                new SizedBox(height: 17,),
                                new Container(
                                  child: new Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      new Text(
                                        "Kết quả",
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
                                        validator: (value){
                                          if(value.isEmpty){
                                            return "Vui lòng nhập kết quả cuộc hẹn";
                                          }
                                          return null;
                                        },
                                        controller: _resultController,
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
            Material(
              elevation: 15,
              child: new Container(
                height: 65,
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 12),
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
                                if (_formKey.currentState.validate()) {

                                  if(_status != null){

                                    ManageAreaItem manageAreaItem = new ManageAreaItem(
                                      id: item.id,
                                      addressType: item.addressType,
                                      addressName: item.addressName,
                                      doctorName: item.doctorName,
                                      startTime: item.startTime,
                                      endTime: item.startTime,
                                      realStartTime: _timeStartTarget,
                                      realEndTime: _timeEndTarget,
                                      status: _status,
                                      targetBefore: _targetController.text,
                                      targetAfter: _resultController.text
                                    );

                                  }
                                  else{
                                    showDialog(
                                        context: context,
                                      builder: (BuildContext context){
                                          return AlertDialog(
                                            title: new Text("Thiếu thông tin"),
                                            content: new Text("Vui lòng chọn trạng thái cuộc hẹn"),
                                            actions: <Widget>[
                                              new FlatButton(
                                                  onPressed: (){
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: new Text("OK")
                                              )
                                            ],
                                          );
                                      }
                                    );
                                  }
                                }
                                else{
                                  setState(() {
                                    _autoValidate = true;
                                  });
                                }
                              },
                              child: new Text(
                                "Lưu",
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
















