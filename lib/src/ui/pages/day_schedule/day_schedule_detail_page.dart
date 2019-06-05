import 'package:flutter/material.dart';

import 'package:medical/src/models/day_schedule_model.dart';
import 'package:medical/src/blocs/day_schedule_detail/day_schedule_detail.dart';

class DayScheduleDetailPage extends StatefulWidget {
  final DayScheduleModel daySchedule;

  DayScheduleDetailPage({Key key, @required this.daySchedule})
      : super(key: key);

  @override
  _DayScheduleDetailPageState createState() {
    return new _DayScheduleDetailPageState();
  }
}

class _DayScheduleDetailPageState extends State<DayScheduleDetailPage> {
  TextEditingController _descriptionController = TextEditingController();

  TimeOfDay _time = TimeOfDay.now();

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay picked =
        await showTimePicker(context: context, initialTime: _time);

    if (picked != null && picked != _time) {
      setState(() {
        _time = picked;
      });
      print("${_time.hour}:${_time.minute}");
    }
  }

  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  DayScheduleDetailBloc _dayScheduleDetailBloc;

  DayScheduleModel get _daySchedule => widget.daySchedule;

  @override
  void initState() {
    _dayScheduleDetailBloc = DayScheduleDetailBloc();
    super.initState();
  }

  @override
  void dispose() {
    _dayScheduleDetailBloc?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.blueAccent,
        title: new Text("Nhập kết quả cuộc hẹn"),
      ),
      body: new Container(
        child: new Column(
          children: <Widget>[
            new Expanded(
                flex: 12,
                child: new Form(
                    key: _formKey,
                    child: new Container(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: new ListView(
                        children: <Widget>[
                          new SizedBox(
                            height: 30,
                          ),
                          new Container(
                            child: new Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                new Container(
                                  child: new Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      new Text(
                                        "Địa điểm",
                                        style: new TextStyle(
                                            color: Colors.black54,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                      new SizedBox(
                                        height: 5,
                                      ),
                                      new Container(
                                        height: 40,
                                        child: new Row(
                                          children: <Widget>[
                                            new Expanded(
                                                child: new Container(
                                              padding:
                                                  EdgeInsets.only(left: 10),
                                              alignment: Alignment.centerLeft,
                                              height: double.infinity,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.grey[400],
                                                      width: 1,
                                                      style: BorderStyle.solid),
                                                  borderRadius:
                                                      BorderRadius.circular(4)),
                                              child: new Text(
                                                _daySchedule.addressType,
                                                style: new TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            )),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                new SizedBox(
                                  height: 17,
                                ),
                                new Container(
                                  child: new Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      new Text(
                                        "Tên địa điểm",
                                        style: new TextStyle(
                                            color: Colors.black54,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                      new SizedBox(
                                        height: 5,
                                      ),
                                      new Container(
                                        height: 40,
                                        child: new Row(
                                          children: <Widget>[
                                            new Expanded(
                                                child: new Container(
                                              padding:
                                                  EdgeInsets.only(left: 10),
                                              alignment: Alignment.centerLeft,
                                              height: double.infinity,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.grey[400],
                                                      width: 1,
                                                      style: BorderStyle.solid),
                                                  borderRadius:
                                                      BorderRadius.circular(4)),
                                              child: new Text(
                                                _daySchedule.addressName,
                                                style: new TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            )),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                new SizedBox(
                                  height: 17,
                                ),
                                new Container(
                                  child: new Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      new Text(
                                        "Tên khách hàng",
                                        style: new TextStyle(
                                            color: Colors.black54,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                      new SizedBox(
                                        height: 5,
                                      ),
                                      new Container(
                                        height: 40,
                                        child: new Row(
                                          children: <Widget>[
                                            new Expanded(
                                              child: new Container(
                                                padding:
                                                    EdgeInsets.only(left: 10),
                                                alignment: Alignment.centerLeft,
                                                height: double.infinity,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors.grey[400],
                                                        width: 1,
                                                        style:
                                                            BorderStyle.solid),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4)),
                                                child: new Text(
                                                  _daySchedule.doctorName,
                                                  style: new TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                new SizedBox(
                                  height: 17,
                                ),
                                new Container(
                                  child: new Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      new Text(
                                        "Thời gian dự kiến",
                                        style: new TextStyle(
                                            color: Colors.black54,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
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
                                              padding:
                                                  EdgeInsets.only(right: 5),
                                              child: new Container(
                                                alignment: Alignment.center,
                                                height: double.infinity,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors.grey[400],
                                                        width: 1,
                                                        style:
                                                            BorderStyle.solid),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4)),
                                                child: new Text(
                                                  "10:20 AM",
                                                  style: new TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            )),
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
                                                        style:
                                                            BorderStyle.solid),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4)),
                                                child: new Text(
                                                  "11:00 PM",
                                                  style: new TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ))
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                new SizedBox(
                                  height: 17,
                                ),
                                new Container(
                                  child: new Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      new Text(
                                        "Chọn thời gian thực tế",
                                        style: new TextStyle(
                                            color: Colors.black54,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
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
                                              padding:
                                                  EdgeInsets.only(right: 5),
                                              child: InkWell(
                                                onTap: () {
                                                  _selectTime(context);
                                                },
                                                child: new Container(
                                                  alignment: Alignment.center,
                                                  height: double.infinity,
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color:
                                                              Colors.grey[400],
                                                          width: 1,
                                                          style: BorderStyle
                                                              .solid),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4)),
                                                  child: new Text(
                                                    _time.toString(),
                                                    style: new TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                            )),
                                            new Expanded(
                                                child: Padding(
                                              padding: EdgeInsets.only(left: 5),
                                              child: InkWell(
                                                onTap: () {
                                                  _selectTime(context);
                                                },
                                                child: new Container(
                                                  alignment: Alignment.center,
                                                  height: double.infinity,
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color:
                                                              Colors.grey[400],
                                                          width: 1,
                                                          style: BorderStyle
                                                              .solid),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4)),
                                                  child: new Text(
                                                    _time.toString(),
                                                    style: new TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                            ))
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                new SizedBox(
                                  height: 17,
                                ),
                                new Container(
                                  child: new Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      new Text(
                                        "Mục tiêu cuộc hẹn",
                                        style: new TextStyle(
                                            color: Colors.black54,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                      new SizedBox(
                                        height: 5,
                                      ),
                                      new TextFormField(
                                        controller: _descriptionController
                                          ..text = _daySchedule.purpose,
                                        style: new TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                        keyboardType: TextInputType.multiline,
                                        decoration: InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey[350],
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
                                new Container(
                                  child: new Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      new Text(
                                        "Chọn trạng thái",
                                        style: new TextStyle(
                                            color: Colors.black54,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                      new SizedBox(
                                        height: 5,
                                      ),
                                      new Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        height: 40,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.grey[400],
                                                width: 1,
                                                style: BorderStyle.solid),
                                            borderRadius:
                                                BorderRadius.circular(4)),
                                        child: DropdownButtonHideUnderline(
                                          child: new DropdownButton(
                                            isExpanded: true,
                                            value: _daySchedule.status,
                                            items: [
                                              DropdownMenuItem(
                                                child: new Text("Đã gặp"),
                                                value: DayScheduleStatus.met,
                                              ),
                                              DropdownMenuItem(
                                                child: new Text("Chưa gặp"),
                                                value: DayScheduleStatus.notMet,
                                              ),
                                              DropdownMenuItem(
                                                child:
                                                    new Text("Hẹn gặp lần sau"),
                                                value: DayScheduleStatus.later,
                                              )
                                            ],
                                            onChanged: (value) {
                                              setState(() {});
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
                                new SizedBox(
                                  height: 17,
                                ),
                                new Container(
                                  child: new Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      new Text(
                                        "Kết quả đạt được",
                                        style: new TextStyle(
                                            color: Colors.black54,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                      new SizedBox(
                                        height: 5,
                                      ),
                                      new TextFormField(
                                        controller: _descriptionController
                                          ..text = _daySchedule.description,
                                        style: new TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                        maxLines: 4,
                                        keyboardType: TextInputType.multiline,
                                        decoration: InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey[350],
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
              flex: 2,
              child: new Container(
                color: Colors.grey.withOpacity(0.1),
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: new Row(
                  children: <Widget>[
                    new Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius: BorderRadius.circular(4)),
                        child: new FlatButton(
                            padding: EdgeInsets.symmetric(vertical: 13),
                            onPressed: () {
                              print(_descriptionController.text);
                              print(_daySchedule.status);
                              _dayScheduleDetailBloc.dispatch(ButtonPressed(
                                id: _daySchedule.id,
                                dayScheduleStatus: null,
                              ));
                            },
                            child: new Text(
                              "Cập nhật",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            )),
                      ),
                    )
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
