import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:medical/src/models/day_coaching_model.dart';
import 'package:medical/src/blocs/day_coaching_detail/day_coaching_detail.dart';

class DayCoachingDetailPage extends StatefulWidget {
  final DayCoachingModel dayCoaching;

  DayCoachingDetailPage({Key key, @required this.dayCoaching})
      : super(key: key);

  @override
  _DayCoachingDetailPageState createState() {
    return new _DayCoachingDetailPageState();
  }
}

class _DayCoachingDetailPageState extends State<DayCoachingDetailPage> {
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

  DayCoachingDetailBloc _dayCoachingDetailBloc;

  DayCoachingModel get _dayCoaching => widget.dayCoaching;

  @override
  void initState() {
    _dayCoachingDetailBloc = DayCoachingDetailBloc();
    super.initState();
  }

  @override
  void dispose() {
    _dayCoachingDetailBloc?.dispose();
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
                    infoText('Loại địa điểm', _dayCoaching.addressType),
                    SizedBox(
                      height: 17,
                    ),
                    infoText('Tên địa điểm', _dayCoaching.addressName),
                    SizedBox(
                      height: 17,
                    ),
                    infoText('Tên khách hàng', _dayCoaching.doctorName),
                    SizedBox(
                      height: 17,
                    ),
                    timeText(_dayCoaching.startTime, _dayCoaching.endTime),
                    SizedBox(
                      height: 17,
                    ),
                    realTimeInput(_dayCoaching.startTime, _dayCoaching.endTime,
                        _dayCoaching.realStartTime, _dayCoaching.realEndTime),
                    SizedBox(
                      height: 17,
                    ),
                    descriptionInput(),
                    SizedBox(
                      height: 17,
                    ),
                    evaluateInput(),
                    SizedBox(
                      height: 17,
                    ),
                    feedbackInput(),
                    SizedBox(
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

  Widget infoText(String title, String value) {
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
                      value,
                      style: new TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
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
            controller: _descriptionController..text = _dayCoaching.description,
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
            controller: _evaluateController..text = _dayCoaching.evaluate,
            style: new TextStyle(
                fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
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
            controller: _feedbackController..text = _dayCoaching.feedback,
            style: new TextStyle(
                fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
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
                    print(_realEndDate);
                    _dayCoachingDetailBloc.dispatch(
                      ButtonPressed(
                          id: _dayCoaching.id,
                          realStartTime: _realStartDay == null
                              ? _dayCoaching.realStartTime
                              : _realStartDay,
                          realEndTime: _realEndDate == null
                              ? _dayCoaching.realEndTime
                              : _realEndDate,
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
      ),
    );
  }
}
