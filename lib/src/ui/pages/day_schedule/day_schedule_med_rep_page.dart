import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical/src/blocs/day_schedule_med_rep/day_schedule_med_rep_bloc.dart';
import 'package:medical/src/blocs/day_schedule_med_rep/day_schedule_med_rep_event.dart';
import 'package:medical/src/blocs/day_schedule_med_rep/day_schedule_med_rep_state.dart';


import 'package:medical/src/models/day_schedule_med_rep_model.dart';
import 'package:medical/src/resources/day_schedule_med_rep_repository.dart';

import 'package:medical/src/ui/widgets/loading_indicator.dart';
import 'package:medical/src/utils.dart';

// ignore: must_be_immutable
class DayScheduleMedRep extends StatefulWidget {

  final DateTime date;
  final int userId;

  DayScheduleMedRep({this.date, this.userId});

  @override
  State<StatefulWidget> createState() {
    return new DayScheduleMedRepState(userId: userId, date: date);
  }
}

class DayScheduleMedRepState extends State<DayScheduleMedRep> {

  final DateTime date;
  final int userId;


  DayScheduleMedRepState({this.date, this.userId});

  ScrollController _scrollController = new ScrollController();
  DayScheduleMedRepBloc _blocDayScheduleMedRep;
  DayScheduleMedRepRepository _dayScheduleMedRepRepository = DayScheduleMedRepRepository();

  DayScheduleMedRepModel dayScheduleMedRepModel;

  bool _isLoading = false;
  bool _isReachMax = false;

  void _scrollListener() {
    if(_isReachMax){
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

    print("thongthong");
    print(userId);
    print(date);

    dayScheduleMedRepModel = DayScheduleMedRepModel.fromJson([]);
    _blocDayScheduleMedRep =
        DayScheduleMedRepBloc(dayScheduleMedRepRepository: _dayScheduleMedRepRepository);
    _blocDayScheduleMedRep.dispatch(GetDayScheduleMedRep(
      date: DateTime.now(),
      userId: userId
    ));

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
        ? "${time.hour - 12}:${time.minute}PM"
        : "${time.hour}:${time.minute.toString()}AM";
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
              listener: (BuildContext context, state){
                if (state is ReachMax) {
                  Scaffold.of(context).removeCurrentSnackBar();
                  Scaffold.of(context).showSnackBar(SnackBar(
                    duration: Duration(milliseconds: 1500),
                    content: Text('Đã hiển thị tất cả dữ liệu'),
                  ));
                  _isLoading = false;
                  _isReachMax = true;
                }
                if(state is DayScheduleMedRepEmpty){
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
                      return LoadingIndicator(opacity: 0,);
                    }
                    return ListView.builder(
                      controller: _scrollController,
                      itemCount: _isLoading
                          ? dayScheduleMedRepModel.listDayScheduleMedRep.length + 1
                          : dayScheduleMedRepModel.listDayScheduleMedRep.length,
                      itemBuilder: (BuildContext context, int index) {
                        if (_isLoading && index == dayScheduleMedRepModel.listDayScheduleMedRep.length) {
                          return SizedBox(
                            height: 50,
                            child: Align(
                                alignment: Alignment.center,
                                child: CircularProgressIndicator()),
                          );
                        }
                        return _buildRow(dayScheduleMedRepModel.listDayScheduleMedRep[index]);
                      },
                    );

                  }),

            ),
          )
      ),
    );
  }

  Widget _buildRow(DayScheduleMedRepItem item) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
            bottom: BorderSide(
                width: 1,
                style: BorderStyle.solid,
                color: Colors.grey[300])),
        color: Colors.white,
      ),
      height: 100,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: (){

          },
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
                        item.partnerModel.name != null ? item.partnerModel.name : 'N/A',
                        style: new TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
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
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
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
                        icon: Icon(Icons.add_circle, color: Colors.blueAccent,),
                        onPressed: (){

                        }
                    ),
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
