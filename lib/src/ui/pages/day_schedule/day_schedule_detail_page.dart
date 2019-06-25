import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:medical/src/models/day_schedule_model.dart';
import 'package:medical/src/blocs/day_schedule_detail/day_schedule_detail.dart';
import 'package:medical/src/ui/widgets/loading_indicator.dart';

import 'package:medical/src/ui/pages/day_schedule/day_schedule_page.dart';

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

  DayScheduleStatus status;
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
    _purposeController.text = widget.daySchedule.purpose;
    _descriptionController.text = widget.daySchedule.description;
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
        child: BlocListener(
            bloc: _dayScheduleDetailBloc,
            listener: (BuildContext context, DayScheduleDetailState state) {
              Scaffold.of(context).removeCurrentSnackBar();
              if (state is Failure) {
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text(state.errorMessage),
                  backgroundColor: Colors.redAccent,
                ));
              }
              if (state is Loaded) {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text("Thông báo"),
                      content: Text("Đã cập nhật thành công!"),
                      actions: <Widget>[
                        FlatButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("OK"),
                        )
                      ],
                    );
                  },
                );
              }
            },
            child: BlocBuilder(
              bloc: _dayScheduleDetailBloc,
              builder: (BuildContext context, DayScheduleDetailState state) {
                if (state is Loading) {
                  return LoadingIndicator();
                }
                return Column(
                  children: <Widget>[updateForm(), updateButton()],
                );
              },
            )),
        /*child: new Column(
          children: <Widget>[updateForm(), updateButton()],
        ),*/
      ),
    );
  }

  Widget updateForm() {
    return Expanded(
      flex: 6,
      child: new Form(
        key: _formKey,
        child: new Container(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: new ListView(
            children: <Widget>[
              new SizedBox(
                height: 16,
              ),
              new Container(
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    outputInfo("Địa điểm", _daySchedule.location),
                    new SizedBox(
                      height: 16,
                    ),
                    outputInfo("Tên khách hàng", _daySchedule.doctorName),
                    new SizedBox(
                      height: 16,
                    ),
                    outputTime(_daySchedule.startTime, _daySchedule.endTime),
                    new SizedBox(
                      height: 16,
                    ),
                    inputRealTime(
                        _daySchedule.realStartTime, _daySchedule.realEndTime),
                    new SizedBox(
                      height: 16,
                    ),
                    purposeInput(),
                    new SizedBox(
                      height: 16,
                    ),
                    statusInput(),
                    new SizedBox(
                      height: 16,
                    ),
                    descriptionInput(),
                    new SizedBox(
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
                    child: new Text(
                      convertTime(startDay),
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
                    child: new Text(
                      convertTime(endDate),
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
            controller: _descriptionController,
            style: new TextStyle(
                fontSize: 16,
                color: Colors.blueAccent,
                fontWeight: FontWeight.bold),
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
                value: status == null ? _daySchedule.status : status,
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
                    fontSize: 16,
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
            //initialValue: _daySchedule.purpose,
            controller: _purposeController,
            style: new TextStyle(
                fontSize: 16,
                color: Colors.blueAccent,
                fontWeight: FontWeight.bold),
            keyboardType: TextInputType.multiline,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey[350], width: 1)),
              border: OutlineInputBorder(),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            ),
            onSaved: (value) {
              _purposeController.text = value;
            },
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
                    _dayScheduleDetailBloc.dispatch(ButtonPressed(
                        scheduleId: _daySchedule.id,
                        realStartTime: _realStartDay == null
                            ? _daySchedule.startTime
                            : _realStartDay,
                        realEndTime: _realEndDate == null
                            ? _daySchedule.endTime
                            : _realEndDate,
                        purpose: _purposeController.text,
                        dayScheduleStatus:
                            status == null ? _daySchedule.status : status,
                        description: _descriptionController.text));
                  },
                  child: new Text(
                    "Cập nhật",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  )),
            ),
          )
        ],
      ),
    );
  }
}
