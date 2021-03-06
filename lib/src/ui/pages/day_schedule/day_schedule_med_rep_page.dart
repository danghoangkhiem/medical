import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical/src/blocs/day_schedule_med_rep/day_schedule_med_rep_bloc.dart';
import 'package:medical/src/blocs/day_schedule_med_rep/day_schedule_med_rep_event.dart';
import 'package:medical/src/blocs/day_schedule_med_rep/day_schedule_med_rep_state.dart';
import 'package:medical/src/blocs/schedule_coaching/schedule_coaching_bloc.dart';
import 'package:medical/src/blocs/schedule_coaching/schedule_coaching_event.dart';

import 'package:medical/src/models/day_schedule_med_rep_model.dart';
import 'package:medical/src/resources/day_schedule_med_rep_repository.dart';
import 'package:medical/src/ui/pages/schedule_coaching/schedule_coaching_page.dart';

import 'package:medical/src/ui/widgets/loading_indicator.dart';
import 'package:medical/src/utils.dart';

// ignore: must_be_immutable
class DayScheduleMedRep extends StatefulWidget {
  final DateTime date;
  final int userId;
  final ScheduleCoachingBloc scheduleCoachingBloc;

  DayScheduleMedRep({this.date, this.userId, this.scheduleCoachingBloc});

  @override
  State<StatefulWidget> createState() {
    return new DayScheduleMedRepState(userId: userId, date: date);
  }
}

class DayScheduleMedRepState extends State<DayScheduleMedRep> {

  ScheduleCoachingBloc get _scheduleCoachingBloc => widget.scheduleCoachingBloc;

  final DateTime date;
  final int userId;

  DayScheduleMedRepState({this.date, this.userId});

  ScrollController _scrollController = new ScrollController();
  DayScheduleMedRepBloc _blocDayScheduleMedRep;
  DayScheduleMedRepRepository _dayScheduleMedRepRepository =
      DayScheduleMedRepRepository();

  DayScheduleMedRepModel dayScheduleMedRepModel;

  bool _isLoading = false;
  bool _isReachMax = false;

  void _scrollListener() {
    if (_isReachMax) {
      return;
    }
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      throttle(10, () {
        if (_isLoading != true) {
          _isLoading = true;
          _blocDayScheduleMedRep.dispatch(LoadMore());
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();

//    print(userId);
    print("ola ola ola");
    print(date);

    dayScheduleMedRepModel = DayScheduleMedRepModel.fromJson([]);
    _blocDayScheduleMedRep = DayScheduleMedRepBloc(
        dayScheduleMedRepRepository: _dayScheduleMedRepRepository);
    _blocDayScheduleMedRep
        .dispatch(GetDayScheduleMedRep(date: date, userId: userId));

    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _blocDayScheduleMedRep?.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Widget inputDate(DateTime startTime, DateTime endTime) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
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

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text("Lịch làm việc trong ngày"),
      ),
      body: SafeArea(
          child: new Container(
        child: BlocListener(
          bloc: _blocDayScheduleMedRep,
          listener: (BuildContext context, state) {
            if (state is ReachMax) {
              Scaffold.of(context).removeCurrentSnackBar();
              Scaffold.of(context).showSnackBar(SnackBar(
                duration: Duration(milliseconds: 1500),
                content: Text('Đã hiển thị tất cả dữ liệu'),
              ));
              _isLoading = false;
              _isReachMax = true;
            }
            if (state is DayScheduleMedRepEmpty) {
              Scaffold.of(context).removeCurrentSnackBar();
              Scaffold.of(context).showSnackBar(SnackBar(
                duration: Duration(milliseconds: 1500),
                content: Text('Không có dữ liệu'),
              ));
            }
            if (state is DayScheduleMedRepFailure) {
              Scaffold.of(context).removeCurrentSnackBar();
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text(state.error),
                backgroundColor: Colors.redAccent,
              ));
            }



            if (state is AddScheduleSuccess) {

              Scaffold.of(context).removeCurrentSnackBar();
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text("Copy thành công."),
                backgroundColor: Colors.green,
              ));

              _scheduleCoachingBloc.dispatch(RefreshEventList());

              Navigator.of(context).pop();
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (BuildContext context) => DayScheduleMedRep(date: widget.date, userId: widget.userId,)));

            }

            if (state is AddScheduleFailure) {
              Scaffold.of(context).removeCurrentSnackBar();
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text("Copy thất bại"),
                backgroundColor: Colors.redAccent,
              ));
            }

            if (state is DayScheduleMedRepLoaded) {
              if (state.isLoadMore) {
                dayScheduleMedRepModel.listDayScheduleMedRep
                    .addAll(state.dayScheduleMedRep.listDayScheduleMedRep);
                _isLoading = false;
              } else {
                dayScheduleMedRepModel.listDayScheduleMedRep =
                    state.dayScheduleMedRep.listDayScheduleMedRep;
              }
            }
          },
          child: BlocBuilder(
              bloc: _blocDayScheduleMedRep,
              builder: (context, state) {
                if (state is DayScheduleMedRepLoading && !state.isLoadMore) {
                  return LoadingIndicator(
                    opacity: 0,
                    progressIndicatorColor: Colors.red,
                  );
                }
                return ListView.builder(
                  controller: _scrollController,
                  itemCount: _isLoading
                      ? dayScheduleMedRepModel.listDayScheduleMedRep.length + 1
                      : dayScheduleMedRepModel.listDayScheduleMedRep.length,
                  itemBuilder: (BuildContext context, int index) {
                    if (_isLoading &&
                        index ==
                            dayScheduleMedRepModel
                                .listDayScheduleMedRep.length) {
                      return SizedBox(
                        height: 50,
                        child: Align(
                            alignment: Alignment.center,
                            child: CircularProgressIndicator()),
                      );
                    }
                    return _buildRow(
                        dayScheduleMedRepModel.listDayScheduleMedRep[index]);
                  },
                );
              }),
        ),
      )),
    );
  }

  void _showDialog(
      DateTime date, int id, int userId, DateTime from, DateTime to) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          content: new Text("Copy lịch làm việc này ?"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Bỏ qua"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
              child: new Text("Đồng ý"),
              onPressed: () {
                print("đồng ý copy lịch");

                _blocDayScheduleMedRep.dispatch(AddSchedule(
                    date: date,
                    scheduleId: id,
                    userId: userId,
                    from: from,
                    to: to));




              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildRow(DayScheduleMedRepItem item) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
            bottom: BorderSide(
                width: 1, style: BorderStyle.solid, color: Colors.grey[300])),
        color: Colors.white,
      ),
      height: 100,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          child: new Row(
            children: <Widget>[
              new Expanded(
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    inputDate(item.startTime, item.endTime),
                    new SizedBox(
                      height: 7,
                    ),
                    new Container(
                      padding: EdgeInsets.only(left: 20),
                      margin: EdgeInsets.only(left: 20),
                      child: new Text(
                        item.partnerModel.name != null
                            ? "BS. " + item.partnerModel.name
                            : 'N/A',
                        style: new TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    new SizedBox(
                      height: 2,
                    ),
                    new Container(
                      padding: EdgeInsets.only(left: 20),
                      margin: EdgeInsets.only(left: 20),
                      child: new Text(
                        "${item.partnerModel.place.name}",
                        style: new TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
              new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Padding(
                    padding: EdgeInsets.only(right: 20),
                    child: new IconButton(
                        icon: Icon(
                          Icons.add_circle,
                          color: Colors.blueAccent,
                        ),
                        onPressed: () {
                          print("copy thong");
                          _showDialog(date, item.id, userId, item.startTime,
                              item.endTime);

//                          _blocDayScheduleMedRep.dispatch(AddSchedule(
//                              date: date,
//                              scheduleId: item.id,
//                              userId: userId,
//                              from: item.startTime,
//                              to: item.endTime));
                          print(item.startTime);
                          print(item.endTime);
                          print(date);
                          print(userId);
                          print(item.id);
                        }),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
