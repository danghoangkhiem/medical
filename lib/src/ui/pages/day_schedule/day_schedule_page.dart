import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:medical/src/utils.dart';
import 'package:medical/src/ui/widgets/loading_indicator.dart';
import 'package:medical/src/models/day_schedule_model.dart';
import 'package:medical/src/blocs/day_schedule/day_schedule.dart';
import 'package:medical/src/ui/pages/day_schedule/day_schedule_detail_page.dart';

class DateSchedulePage extends StatefulWidget {

  //define
  final DateTime date;
  DateSchedulePage({this.date});

  @override
  _DateSchedulePageState createState() {
    return new _DateSchedulePageState();
  }
}

class _DateSchedulePageState extends State<DateSchedulePage> {
  //define
  final ScrollController _controller = ScrollController();
  DayScheduleListModel _dayScheduleList;
  DayScheduleBloc _dayScheduleBloc;
  bool _isLoading = false;
  bool _isReachMax = false;

  @override
  void initState() {
    _dayScheduleList = DayScheduleListModel.fromJson([]);
    _dayScheduleBloc = DayScheduleBloc();
    _dayScheduleBloc.dispatch(DayScheduleFilter(date: widget.date));
    _controller.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _dayScheduleBloc?.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      throttle(10, () {
        if (_isLoading != true) {
          _isLoading = true;
          _dayScheduleBloc.dispatch(LoadMore());
        }
      });
    }
  }

  Widget inputDate(DateTime startTime, DateTime endTime) {
    return Container(
      child: new Text(
        convertTime(startTime) + ' đến ' + convertTime(endTime),
        style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.blueAccent),
      ),
    );
  }

  String convertTime(DateTime time) {
    return time.hour > 12
        ? "${time.hour - 12}:${time.minute} PM"
        : "${time.hour}:${time.minute.toString()} AM";
  }

  Widget inputName(String role, String name) {
    return Container(
      margin: EdgeInsets.only(left: 20),
      child: Text(
        role + " : " + name,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget inputAddress(String address){
    return Container(
      margin: EdgeInsets.only(left: 20),
      child: new Text(
        'Địa điểm : ' + address,
        style: new TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
// TODO: implement build
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text("Lịch làm việc " +
            widget.date.day.toString() +
            '/' +
            widget.date.month.toString() +
            '/' +
            widget.date.year.toString()),
      ),
      body: Container(
        child: new Column(
          children: <Widget>[
            Expanded(
              flex: 8,
              child: BlocListener(
                bloc: _dayScheduleBloc,
                listener: (BuildContext context, DayScheduleState state) {
                  Scaffold.of(context).removeCurrentSnackBar();
                  if (state is NoRecordsFound) {
                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text('Không có dữ liệu được tìm thấy!'),
                      backgroundColor: Colors.redAccent,
                    ));
                  }
                  if (state is ReachMax) {
                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text('Đã hiển thị tất cả dữ liệu!'),
                      backgroundColor: Colors.blueAccent,
                    ));
                    _isLoading = false;
                    _isReachMax = true;
                  }
                  if (state is Failure) {
                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text(state.errorMessage),
                      backgroundColor: Colors.redAccent,
                    ));
                  }
                  if (state is Loaded) {
                    if (state.isLoadMore) {
                      if (state.dayScheduleList != null) {
                        _dayScheduleList.addAll(state.dayScheduleList);
                      }
                      _isLoading = false;
                    } else {
                      _dayScheduleList = state.dayScheduleList;
                      _isReachMax = false;
                    }
                  }
                },
                child: BlocBuilder(
                  bloc: _dayScheduleBloc,
                  builder: (BuildContext context, DayScheduleState state) {
                    if (state is Loading && !state.isLoadMore) {
                      return LoadingIndicator();
                    }
                    return ListView.builder(
                      controller: _controller,
                      itemCount: _isLoading
                          ? _dayScheduleList.length + 1
                          : _dayScheduleList.length,
                      itemBuilder: (BuildContext context, int index) {
                        if (_isLoading && index == _dayScheduleList.length) {
                          return SizedBox(
                            height: 50,
                            child: Align(
                                alignment: Alignment.center,
                                child: CircularProgressIndicator()),
                          );
                        }
                        return InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    DayScheduleDetailPage(
                                      daySchedule: _dayScheduleList[index],
                                    ),
                              ),
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: 1,
                                      style: BorderStyle.solid,
                                      color: Colors.grey[300])),
                              color: Colors.white,
                            ),
                            height: 100,
                            child: new Row(
                              children: <Widget>[
                                new Expanded(
                                  child: new Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      inputDate(
                                          _dayScheduleList[index].realStartTime,
                                          _dayScheduleList[index].realEndTime),
                                      SizedBox(
                                        height: 6,
                                      ),
                                      inputName(_dayScheduleList[index].role,_dayScheduleList[index].doctorName),
                                      new SizedBox(
                                        height: 2,
                                      ),
                                      inputAddress(_dayScheduleList[index].location)
                                    ],
                                  ),
                                ),
                                new Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    new Padding(
                                      padding: EdgeInsets.only(right: 20),
                                      child: new Icon(
                                        Icons.edit,
                                        color: Colors.green,
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
