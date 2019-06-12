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
  TextEditingController _purposeController = TextEditingController();

  String status;
  DateTime _realStartDay;
  DateTime _realEndDate;
  bool isStartDate = false;

  TimeOfDay _time = TimeOfDay.now();
  DateTime time;
  bool isLonHon12 = false;

  final now = new DateTime.now();

  Future<Null> _selectTime(BuildContext context, bool isStartDate) async {
    final TimeOfDay picked =
        await showTimePicker(context: context, initialTime: _time);
    //&& picked != _time
    if (picked != null) {
      if (picked.hour > 12) {
        setState(() {
          isLonHon12 = true;
          if (isStartDate == true) {
            _realStartDay = new DateTime(now.year, now.month, now.day,
                (picked.hour).toInt(), picked.minute);
          } else {
            _realEndDate = new DateTime(now.year, now.month, now.day,
                (picked.hour).toInt(), picked.minute);
          }
        });
      } else {
        setState(() {
          isLonHon12 = false;
          if (isStartDate == true) {
            _realStartDay = new DateTime(
                now.year, now.month, now.day, picked.hour, picked.minute);
          } else {
            _realEndDate = new DateTime(
                now.year, now.month, now.day, picked.hour, picked.minute);
          }
        });
      }
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
          children: <Widget>[updateForm(), updateButton()],
        ),
      ),
    );
  }

  Widget updateForm() {
    return Expanded(
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
                    infoText("Địa điểm", _daySchedule.addressType),
                    new SizedBox(
                      height: 17,
                    ),
                    infoText("Tên địa điểm", _daySchedule.addressName),
                    new SizedBox(
                      height: 17,
                    ),
                    infoText("Tên khách hàng", _daySchedule.doctorName),
                    new SizedBox(
                      height: 17,
                    ),
                    timeText(_daySchedule.startTime, _daySchedule.endTime),
                    new SizedBox(
                      height: 17,
                    ),
                    realTimeInput(_daySchedule.startTime, _daySchedule.endTime,
                        _daySchedule.realStartTime, _daySchedule.realEndTime),
                    new SizedBox(
                      height: 17,
                    ),
                    purposeInput(),
                    new SizedBox(
                      height: 17,
                    ),
                    statusInput(),
                    new SizedBox(
                      height: 17,
                    ),
                    descriptionInput(),
                    new SizedBox(
                      height: 17,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget infoText(String title, String content) {
    return Container(
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Text(
            title,
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
                  padding: EdgeInsets.only(left: 10),
                  alignment: Alignment.centerLeft,
                  height: double.infinity,
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.grey[400],
                          width: 1,
                          style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(4)),
                  child: new Text(
                    content,
                    style: new TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                )),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget timeText(DateTime startDay, DateTime endDate) {
    return Container(
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                    child: new Text(
                      startDay.hour > 12
                          ? "${startDay.hour - 12}:${startDay.minute} PM"
                          : "${startDay.hour}:${startDay.minute.toString()} AM",
                      style: new TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
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
                            style: BorderStyle.solid),
                        borderRadius: BorderRadius.circular(4)),
                    child: new Text(
                      endDate.hour > 12
                          ? "${endDate.hour - 12}:${endDate.minute} PM"
                          : "${endDate.hour}:${endDate.minute.toString()} AM",
                      style: new TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ))
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget realTimeInput(DateTime startDay, DateTime endDate,
      DateTime realStartDate, DateTime realEndDate) {
    return Container(
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                  padding: EdgeInsets.only(right: 5),
                  child: InkWell(
                    onTap: () {
                      _selectTime(context, isStartDate = true);
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
                      child: _realStartDay == null
                          ? new Text(
                              realStartDate.hour > 12
                                  ? "${realStartDate.hour - 12}:${realStartDate.minute} PM"
                                  : "${realStartDate.hour}:${realStartDate.minute.toString()} AM",
                              style: new TextStyle(
                                  fontSize: 18,
                                  color: Colors.blueAccent,
                                  fontWeight: FontWeight.bold),
                            )
                          : new Text(
                              _realStartDay.hour > 12
                                  ? "${(_realStartDay.hour - 12).toInt()}:${_realStartDay.minute} PM"
                                  : "${_realStartDay.hour}:${_realStartDay.minute} AM",
                              style: new TextStyle(
                                  fontSize: 18,
                                  color: Colors.blueAccent,
                                  fontWeight: FontWeight.bold),
                            ),
                    ),
                  ),
                )),
                new Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 5),
                    child: InkWell(
                      onTap: () {
                        _selectTime(context, isStartDate = false);
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
                        child: _realEndDate == null
                            ? new Text(
                                realEndDate.hour > 12
                                    ? "${realEndDate.hour - 12}:${realEndDate.minute} PM"
                                    : "${realEndDate.hour}:${realEndDate.minute.toString()} AM",
                                style: new TextStyle(
                                    fontSize: 18,
                                    color: Colors.blueAccent,
                                    fontWeight: FontWeight.bold),
                              )
                            : new Text(
                                _realEndDate.hour > 12
                                    ? "${(_realEndDate.hour - 12).toInt()}:${_realEndDate.minute} PM"
                                    : "${_realEndDate.hour}:${_realEndDate.minute} AM",
                                style: new TextStyle(
                                    fontSize: 18,
                                    color: Colors.blueAccent,
                                    fontWeight: FontWeight.bold),
                              ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget descriptionInput() {
    return Container(
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
            controller: _descriptionController..text = _daySchedule.description,
            style: new TextStyle(
                fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
            maxLines: 4,
            keyboardType: TextInputType.multiline,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey[350], width: 1)),
              border: OutlineInputBorder(),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            ),
          )
        ],
      ),
    );
  }

  Widget statusInput() {
    return Container(
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                    child: new Text("Hẹn gặp lần sau"),
                    value: DayScheduleStatus.later,
                  )
                ],
                onChanged: (value) {
                  setState(() {
                    status = value;
                  });
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
    );
  }

  Widget purposeInput() {
    return Container(
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
            controller: _purposeController..text = _daySchedule.purpose,
            style: new TextStyle(
                fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
            keyboardType: TextInputType.multiline,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey[350], width: 1)),
              border: OutlineInputBorder(),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            ),
          )
        ],
      ),
    );
  }

  Widget updateButton() {
    return Expanded(
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
                      _dayScheduleDetailBloc.dispatch(ButtonPressed(
                        scheduleId: _daySchedule.id,
                        realStartTime: _realStartDay == null ? _daySchedule.startTime : _realStartDay,
                        realEndTime: _realEndDate == null ? _daySchedule.endTime : _realEndDate,
                        purpose: _purposeController.toString(),
                        dayScheduleStatus: status == null ? _daySchedule.status : status,
                        description: _descriptionController.text
                      ));
                    },
                    child: new Text(
                      "Cập nhật",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
