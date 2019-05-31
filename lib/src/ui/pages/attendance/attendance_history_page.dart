import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:medical/src/utils.dart';
import '../../../blocs/attendence/attendance.dart';
import 'package:medical/src/models/models.dart';
import 'package:medical/src/resources/attendance_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical/src/ui/widgets/loading_indicator.dart';

class AttendanceHistoryPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new AttendanceHistoryPageState();
  }
}

class AttendanceHistoryPageState extends State<AttendanceHistoryPage> {
  ScrollController _scrollController = new ScrollController();

  AttendanceBloc _blocAttendance;

  AttendanceRepository _attendanceRepository = AttendanceRepository();

  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  DateTime _startDate;
  DateTime _endDate;
  DateTime _now;

  AttendancesModel attendancesModel;

  bool _isLoading = false;
  bool _isReachMax = false;

  void _scrollListener() {
    if(_isReachMax){
      return;
    }
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      throttle(200, () {
        if (_isLoading != true) {
          _isLoading = true;
          _blocAttendance.dispatch(LoadMore());
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _now = DateTime.now();
    _startDate =
        _endDate = DateTime.parse(DateFormat('yyyy-MM-dd').format(_now));

    attendancesModel = AttendancesModel.fromJson([]);

    _blocAttendance =
        AttendanceBloc(attendanceRepository: _attendanceRepository);

    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _blocAttendance?.dispose();
    _scrollController.dispose();
    super.dispose();
  }

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
                              new SizedBox(
                                height: 20,
                              ),
                              new Row(
                                children: <Widget>[
                                  new Text(
                                    "Từ ngày ",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black54),
                                  ),
                                  new SizedBox(
                                    width: 30,
                                  ),
                                  new Flexible(
                                    child: DateTimePickerFormField(
                                      inputType: InputType.date,
                                      format: DateFormat("dd-MM-yyyy"),
                                      initialDate: _endDate ?? _now,
                                      lastDate: _endDate ?? _now,
                                      initialValue: _startDate,
                                      editable: false,
                                      decoration: InputDecoration(
                                        labelText: 'Chọn ngày bắt đầu',
                                        labelStyle: new TextStyle(
                                            fontWeight: FontWeight.normal,
                                            color: Colors.grey),
                                        hasFloatingPlaceholder: false,
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.blueAccent,
                                                width: 2)),
                                        border: OutlineInputBorder(),
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 10),
                                      ),
                                      style: new TextStyle(
                                          fontSize: 18,
                                          color: Colors.blueAccent,
                                          fontWeight: FontWeight.bold),
                                      onChanged: (dt) {
                                        if (dt != null) {
                                          setState(() {
                                            _startDate = dt;
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
                              new Row(
                                children: <Widget>[
                                  new Text(
                                    "Đến ngày ",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black54),
                                  ),
                                  new SizedBox(
                                    width: 20,
                                  ),
                                  new Flexible(
                                    child: DateTimePickerFormField(
                                      inputType: InputType.date,
                                      format: DateFormat("dd-MM-yyyy"),
                                      initialDate: _startDate ?? _now,
                                      firstDate: _startDate,
                                      initialValue: _endDate,
                                      lastDate: _now,
                                      editable: false,
                                      decoration: InputDecoration(
                                        labelText: 'Chọn ngày kết thúc',
                                        labelStyle: new TextStyle(
                                            fontWeight: FontWeight.normal,
                                            color: Colors.grey),
                                        hasFloatingPlaceholder: false,
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.blueAccent,
                                                width: 2)),
                                        border: OutlineInputBorder(),
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 10),
                                      ),
                                      style: new TextStyle(
                                          fontSize: 18,
                                          color: Colors.blueAccent,
                                          fontWeight: FontWeight.bold),
                                      onChanged: (dt) {
                                        if (dt != null) {
                                          setState(() {
                                            _endDate = dt;
                                            //print(endDay.millisecondsSinceEpoch);
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
                                    onPressed: () {
                                      if (_startDate != null &&
                                          _endDate != null) {
                                        _isReachMax = false;
                                        //print("tìm $starDay - $endDay");
                                        _blocAttendance.dispatch(GetAttendance(
                                            startDate: _startDate,
                                            endDate: _endDate,
                                            ));
                                      } else {
                                        print("Chua du dieu kien tim");
                                      }
                                    },
                                    child: new Text(
                                      "Tìm",
                                      style: new TextStyle(
                                          fontSize: 18, color: Colors.white),
                                    )),
                              )
                            ],
                          ),
                        ),
                      ],
                    ))),
            new Expanded(
                flex: 6,
                child: new Stack(
                  children: <Widget>[
                    new Container(
                      height: double.infinity,
                      color: Colors.white,
                      child: BlocListener(
                        bloc: _blocAttendance,
                        listener: (BuildContext context, state) {
                          if (state is ReachMax) {
                            Scaffold.of(context).removeCurrentSnackBar();
                            Scaffold.of(context).showSnackBar(SnackBar(
                              duration: Duration(milliseconds: 1500),
                              content: Text('Đã hiển thị tất cả dữ liệu'),
                            ));
                            _isLoading = false;
                            _isReachMax = true;
                            //_scrollController.removeListener(_scrollListener);
                          }
                          if(state is AttendanceEmpty){
                            Scaffold.of(context).removeCurrentSnackBar();
                            Scaffold.of(context).showSnackBar(SnackBar(
                              duration: Duration(milliseconds: 1500),
                              content: Text('Không có dữ liệu'),
                            ));
                          }
                          if (state is AttendanceFailure) {
                            Scaffold.of(context).removeCurrentSnackBar();
                            Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text(state.error),
                              backgroundColor: Colors.redAccent,
                            ));
                          }
                          if (state is AttendanceLoaded) {
                            if (state.isLoadMore) {
                              attendancesModel.listAttendance
                                  .addAll(state.attendance.listAttendance);
                              _isLoading = false;
                            } else {
                              attendancesModel.listAttendance =
                                  state.attendance.listAttendance;
                            }
                          }
                        },
                        child: BlocBuilder(
                            bloc: _blocAttendance,
                            builder: (context, state) {
                              if (state is AttendanceLoading && !state.isLoadMore) {
                                return LoadingIndicator();
                              }
                              return ListView.builder(
                                controller: _scrollController,
                                itemCount: _isLoading
                                    ? attendancesModel.listAttendance.length + 1
                                    : attendancesModel.listAttendance.length,
                                itemBuilder: (BuildContext context, int index) {
                                  if (_isLoading && index == attendancesModel.listAttendance.length) {
                                    return SizedBox(
                                      height: 50,
                                      child: Align(
                                          alignment: Alignment.center,
                                          child: CircularProgressIndicator()),
                                    );
                                  }
                                  return _buildRow(attendancesModel.listAttendance[index]);
                                },
                              );

                            }),
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(AttendanceItem item) {
    return new Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      height: 100,
      color: Colors.white,
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Text(
            item.location.name,
            style: new TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          new SizedBox(
            height: 10,
          ),
          new Container(
            margin: EdgeInsets.only(left: 20),
            child: new Row(
              children: <Widget>[
                new Container(
                  margin: EdgeInsets.only(right: 15),
                  child: new Icon(
                    Icons.check_circle,
                    color: Colors.green,
                  ),
                ),
                item.timeIn !=null ? new Container(
                  child: new Text(
                    DateFormat('dd-MM-yyyy hh:mm:ss').format(item.timeIn),
                    style: new TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                ): Container()
              ],
            ),
          ),
          new SizedBox(
            height: 3,
          ),
          new Container(
            margin: EdgeInsets.only(left: 20),
            child: new Row(
              children: <Widget>[
                new Container(
                  margin: EdgeInsets.only(right: 15),
                  child: new Icon(
                    Icons.check_circle,
                    color: Colors.deepOrange,
                  ),
                ),
                item.timeOut != null ? new Container(
                  //kiem tra co hay khong
                  child: new Text(
                    DateFormat('dd-MM-yyyy hh:mm:ss').format(item.timeOut),
                    style: new TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                ): Container()
              ],
            ),
          )
        ],
      ),
    );
  }
}
