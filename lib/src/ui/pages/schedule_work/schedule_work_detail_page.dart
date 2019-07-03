import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical/src/ui/widgets/loading_indicator.dart';

//model schedule
import 'package:medical/src/models/schedule_work_model.dart';

//block schedule detail
import 'package:medical/src/blocs/schedule_work_detail/schedule_work_detail.dart';

//bloc schedule
import 'package:medical/src/blocs/schedule_work/schedule_work.dart';

class ScheduleWorkDetailPage extends StatefulWidget {
  final ScheduleWorkModel scheduleWork;
  final ScheduleWorkBloc scheduleWorkBloc;

  ScheduleWorkDetailPage(
      {Key key, @required this.scheduleWork, @required this.scheduleWorkBloc})
      : super(key: key);

  @override
  _ScheduleWorkDetailPageState createState() {
    return new _ScheduleWorkDetailPageState();
  }
}

class _ScheduleWorkDetailPageState extends State<ScheduleWorkDetailPage> {
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _purposeController = TextEditingController();

  ScheduleWorkType status;
  DateTime _realStartDay;
  DateTime _realEndDate;
  bool isStartDate = false;

  TimeOfDay _time = TimeOfDay.now();
  DateTime time;
  bool isLonHon12 = false;

  Future<Null> _selectTime(BuildContext context, bool isStartDate, DateTime now) async {
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

  ScheduleWorkDetailBloc _scheduleWorkDetailBloc;

  ScheduleWorkBloc get _scheduleWorkBloc => widget.scheduleWorkBloc;

  ScheduleWorkModel get _scheduleWork => widget.scheduleWork;

  @override
  void initState() {
    _scheduleWorkDetailBloc = ScheduleWorkDetailBloc();
    _purposeController.text = widget.scheduleWork.purpose;
    _descriptionController.text = widget.scheduleWork.description;
    _realStartDay = widget.scheduleWork.realHours.from == null
        ? widget.scheduleWork.hours.from
        : widget.scheduleWork.realHours.from;
    _realEndDate = widget.scheduleWork.realHours.to == null
        ? widget.scheduleWork.hours.to
        : widget.scheduleWork.realHours.to;
    super.initState();
  }

  @override
  void dispose() {
    _scheduleWorkDetailBloc?.dispose();
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
            bloc: _scheduleWorkDetailBloc,
            listener: (BuildContext context, ScheduleWorkDetailState state) {
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
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Thành công'),
                      content: Container(
                        child: Text('Cập nhật thành công'),
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
                ).then((_) {
                  _scheduleWorkBloc.dispatch(RefreshEventList());
                  Navigator.of(context)
                      .popUntil(ModalRoute.withName('/schedule_work_page'));
                });
              }
            },
            child: BlocBuilder(
              bloc: _scheduleWorkDetailBloc,
              builder: (BuildContext context, ScheduleWorkDetailState state) {
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
                    outputInfo("Địa điểm", _scheduleWork.partner.place.name),
                    new SizedBox(
                      height: 16,
                    ),
                    outputInfo("Tên khách hàng", _scheduleWork.partner.name),
                    new SizedBox(
                      height: 16,
                    ),
                    outputTime(
                        _scheduleWork.hours.from, _scheduleWork.hours.to),
                    new SizedBox(
                      height: 16,
                    ),
                    inputRealTime(
                        _scheduleWork.realHours.from != null
                            ? _scheduleWork.realHours.from
                            : _scheduleWork.hours.from,
                        _scheduleWork.realHours.to != null
                            ? _scheduleWork.realHours.to
                            : _scheduleWork.hours.to),
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
    print(endDate);
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
                      _selectTime(context, isStartDate = true, _realStartDay);
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
                      child: Text(
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
                        _selectTime(context, isStartDate = false, _realEndDate);
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
                        child: Text(
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
                value: status == null ? _scheduleWork.status : status,
                items: [
                  DropdownMenuItem(
                    child: new Text("Chưa gặp"),
                    value: ScheduleWorkType.notMeet,
                  ),
                  DropdownMenuItem(
                    child: new Text("Đã gặp"),
                    value: ScheduleWorkType.meet,
                  ),
                  DropdownMenuItem(
                    child: new Text("Hẹn gặp lần sau"),
                    value: ScheduleWorkType.later,
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
                    print(_realStartDay);
                    print(_realEndDate);
                    if (!_realEndDate.isAfter(_realStartDay)) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Thông báo'),
                            content: Container(
                              child: Text('Thời gian bắt đầu không được lớn hơn thời gian kết thúc!'),
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
                    _scheduleWorkDetailBloc.dispatch(ButtonPressed(
                        scheduleId: _scheduleWork.id,
                        realStartTime: _realStartDay,
                        realEndTime: _realEndDate,
                        purpose: _purposeController.text,
                        status: status == null ? _scheduleWork.status : status,
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
