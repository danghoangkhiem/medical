import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:medical/src/models/schedule_coaching_model.dart';
import 'package:medical/src/blocs/schedule_coaching_detail/schedule_coaching_detail.dart';

class ScheduleCoachingDetailPage extends StatefulWidget {
  final ScheduleCoachingModel scheduleCoaching;

  ScheduleCoachingDetailPage({Key key, @required this.scheduleCoaching})
      : super(key: key);

  @override
  _ScheduleCoachingDetailPageState createState() {
    return new _ScheduleCoachingDetailPageState();
  }
}

class _ScheduleCoachingDetailPageState extends State<ScheduleCoachingDetailPage> {
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _evaluateController = TextEditingController();
  TextEditingController _feedbackController = TextEditingController();
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

      //print(DateFormat("yyyy-MM-dd hh:mm:ss a").format(time));
      //print("${_time.hour}:${_time.minute}");
      //print(_time);
    }
  }

  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  ScheduleCoachingDetailBloc _scheduleCoachingDetailBloc;

  ScheduleCoachingModel get _scheduleCoaching => widget.scheduleCoaching;

  @override
  void initState() {
    _scheduleCoachingDetailBloc = ScheduleCoachingDetailBloc();
    _descriptionController.text = _scheduleCoaching.description;
    _evaluateController.text = _scheduleCoaching.evaluation;
    _feedbackController.text =_scheduleCoaching.feedback;
    _realStartDay = _scheduleCoaching.realHours.from == null ? _scheduleCoaching.hours.from : _scheduleCoaching.realHours.from;
    _realEndDate = _scheduleCoaching.realHours.to == null ? _scheduleCoaching.hours.to : _scheduleCoaching.realHours.to;
    super.initState();
  }

  @override
  void dispose() {
    _scheduleCoachingDetailBloc?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.blueAccent,
        title: new Text("Nhập kết quả Coaching"),
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
                    outputInfo('Địa điểm', _scheduleCoaching.partner.place.name),
                    SizedBox(
                      height: 16,
                    ),
                    outputInfo('Tên khách hàng', _scheduleCoaching.partner.name),
                    SizedBox(
                      height: 16,
                    ),
                    outputTime(_scheduleCoaching.hours.from, _scheduleCoaching.hours.to),
                    SizedBox(
                      height: 16,
                    ),
                    inputRealTime(_scheduleCoaching.realHours.from, _scheduleCoaching.realHours.to),
                    SizedBox(
                      height: 16,
                    ),
                    descriptionInput(),
                    SizedBox(
                      height: 16,
                    ),
                    evaluateInput(),
                    SizedBox(
                      height: 16,
                    ),
                    feedbackInput(),
                    SizedBox(
                      height: 16,
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

  Widget outputInfo(String title, String content) {
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
            height: 4,
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
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget outputTime(DateTime startDay, DateTime endDate) {
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
                        child: new Text(convertTime(startDay),
                          style: new TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
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
                        child: new Text(convertTime(endDate),
                          style: new TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
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

  String convertTime(DateTime time) {
    return time.hour > 12
        ? "${time.hour - 12}:${time.minute} PM"
        : "${time.hour}:${time.minute.toString()} AM";
  }

  Widget inputRealTime(DateTime realStartDate, DateTime realEndDate) {
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
                              ? Text(
                            convertTime(realStartDate),
                            style: new TextStyle(
                                fontSize: 16,
                                color: Colors.blueAccent,
                                fontWeight: FontWeight.bold),
                          )
                              : Text(
                            convertTime(_realStartDay),
                            style: new TextStyle(
                                fontSize: 16,
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
                          convertTime(realEndDate),
                          style: new TextStyle(
                              fontSize: 16,
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.bold),
                        )
                            : new Text(
                          convertTime(_realEndDate),
                          style: new TextStyle(
                              fontSize: 16,
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
            "Nội dung Coaching",
            style: new TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.bold,
                fontSize: 16),
          ),
          new SizedBox(
            height: 5,
          ),
          new TextFormField(
            controller: _descriptionController,
            style: new TextStyle(
                fontSize: 16, color: Colors.blueAccent, fontWeight: FontWeight.bold),
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

  Widget evaluateInput() {
    return Container(
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Text(
            "Đánh giá",
            style: new TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.bold,
                fontSize: 16),
          ),
          new SizedBox(
            height: 5,
          ),
          new TextFormField(
            controller: _evaluateController,
            style: new TextStyle(
                fontSize: 16, color: Colors.blueAccent, fontWeight: FontWeight.bold),
            //maxLines: 4,
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

  Widget feedbackInput() {
    return Container(
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Text(
            "Góp ý",
            style: new TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.bold,
                fontSize: 16),
          ),
          new SizedBox(
            height: 5,
          ),
          new TextFormField(
            controller: _feedbackController,
            style: new TextStyle(
                fontSize: 16, color: Colors.blueAccent, fontWeight: FontWeight.bold),
            //maxLines: 4,
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
    return Container(
      height: 60,
      color: Colors.white,
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
                  if (!_realEndDate.isAfter(_realStartDay)) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Thành công'),
                          content: Container(
                            child: Text('Thời gian bắt đầu sau thời gian kết thúc!'),
                          ),
                          actions: <Widget>[
                            FlatButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                    return;
                  }
                  _scheduleCoachingDetailBloc.dispatch(
                    ButtonPressed(
                        id: _scheduleCoaching.id,
                        realStartTime: _realStartDay,
                        realEndTime: _realEndDate,
                        description: _descriptionController.text,
                        evaluate: _evaluateController.text,
                        feedback: _feedbackController.text),
                  );
                },
                child: new Text(
                  "Cập nhật",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
