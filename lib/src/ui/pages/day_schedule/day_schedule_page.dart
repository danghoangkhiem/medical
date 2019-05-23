import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:medical/src/utils.dart';
import 'package:medical/src/ui/widgets/loading_indicator.dart';

import 'package:medical/src/models/day_schedule_model.dart';
import 'package:medical/src/blocs/day_schedule/day_schedule.dart';

class DateSchedulePage extends StatefulWidget {
  final DateTime date;

  DateSchedulePage({this.date});

  @override
  _DateSchedulePageState createState() {
    return new _DateSchedulePageState();
  }
}

class _DateSchedulePageState extends State<DateSchedulePage> {
  final ScrollController _controller = ScrollController();

  DayScheduleListModel _dayScheduleList;
  DayScheduleBloc _dayScheduleBloc;

  bool _isLoading = false;

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
      throttle(200, () {
        if (_isLoading != true) {
          _isLoading = true;
          _dayScheduleBloc.dispatch(LoadMore());
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
// TODO: implement build
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text("Lịch làm việc trong ngày"),
      ),
      body: Container(
        child: new Column(
          children: <Widget>[
            Expanded(
              flex: 8,
              child: BlocListener(
                bloc: _dayScheduleBloc,
                listener: (BuildContext context, DayScheduleState state) {
                  if (state is ReachMax) {
                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text('Got all the data!'),
                    ));
                    _controller.removeListener(_scrollListener);
                  }
                  if (state is Failure) {
                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text(state.errorMessage),
                      backgroundColor: Colors.redAccent,
                    ));
                  }
                  if (state is Loaded) {
                    if (state.isLoadMore) {
                      _dayScheduleList.addAll(state.dayScheduleList);
                      _isLoading = false;
                    } else {
                      _dayScheduleList = state.dayScheduleList;
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
                          onTap: (){
                            Navigator.pop(context);
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
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      new Container(
                                        child: new Text(
                                          "Từ " + DateFormat('hh:mm').format(_dayScheduleList[index].startTime) + " đến " + DateFormat('hh:mm').format(_dayScheduleList[index].endTime) ,
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black54),
                                        ),
                                      ),
                                      new SizedBox(
                                        height: 7,
                                      ),
                                      new Container(
                                        margin: EdgeInsets.only(left: 20),
                                        child: new Text(
                                          _dayScheduleList[index].position + " : " + _dayScheduleList[index].doctorName,
                                          style: new TextStyle(
                                              fontSize: 18, fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      new SizedBox(
                                        height: 2,
                                      ),
                                      new Container(
                                        margin: EdgeInsets.only(left: 20),
                                        child: new Text(
                                          _dayScheduleList[index].addressType + " : " + _dayScheduleList[index].addressName,
                                          style: new TextStyle(
                                              fontSize: 18, fontWeight: FontWeight.bold),
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
                                      child: new Icon(
                                        Icons.flash_on,
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

  Widget test() {
    Column(
      children: <Widget>[
        Container(
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Container(
                      child: new Text(
                        "Từ 08:00 đến 09:30",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54),
                      ),
                    ),
                    new SizedBox(
                      height: 7,
                    ),
                    new Container(
                      margin: EdgeInsets.only(left: 20),
                      child: new Text(
                        "BS: Nguyễn Hữu Lộc",
                        style: new TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    new SizedBox(
                      height: 2,
                    ),
                    new Container(
                      margin: EdgeInsets.only(left: 20),
                      child: new Text(
                        "BV: Chợ Rẫy",
                        style: new TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
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
                    child: new Icon(
                      Icons.flash_on,
                      color: Colors.green,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
        Container(
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Container(
                      child: new Text(
                        "Từ 08:00 đến 09:30",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54),
                      ),
                    ),
                    new SizedBox(
                      height: 7,
                    ),
                    new Container(
                      margin: EdgeInsets.only(left: 20),
                      child: new Text(
                        "BS: Nguyễn Hữu Lộc",
                        style: new TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    new SizedBox(
                      height: 2,
                    ),
                    new Container(
                      margin: EdgeInsets.only(left: 20),
                      child: new Text(
                        "BV: Chợ Rẫy",
                        style: new TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
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
                    child: new Icon(
                      Icons.flash_on,
                      color: Colors.green,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
        Container(
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Container(
                      child: new Text(
                        "Từ 08:00 đến 09:30",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54),
                      ),
                    ),
                    new SizedBox(
                      height: 7,
                    ),
                    new Container(
                      margin: EdgeInsets.only(left: 20),
                      child: new Text(
                        "BS: Nguyễn Hữu Lộc",
                        style: new TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    new SizedBox(
                      height: 2,
                    ),
                    new Container(
                      margin: EdgeInsets.only(left: 20),
                      child: new Text(
                        "BV: Chợ Rẫy",
                        style: new TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
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
                    child: new Icon(
                      Icons.flash_on,
                      color: Colors.green,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
        Container(
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Container(
                      child: new Text(
                        "Từ 08:00 đến 09:30",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54),
                      ),
                    ),
                    new SizedBox(
                      height: 7,
                    ),
                    new Container(
                      margin: EdgeInsets.only(left: 20),
                      child: new Text(
                        "BS: Nguyễn Hữu Lộc",
                        style: new TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    new SizedBox(
                      height: 2,
                    ),
                    new Container(
                      margin: EdgeInsets.only(left: 20),
                      child: new Text(
                        "BV: Chợ Rẫy",
                        style: new TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
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
                    child: new Icon(
                      Icons.flash_on,
                      color: Colors.green,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
        Container(
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Container(
                      child: new Text(
                        "Từ 08:00 đến 09:30",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54),
                      ),
                    ),
                    new SizedBox(
                      height: 7,
                    ),
                    new Container(
                      margin: EdgeInsets.only(left: 20),
                      child: new Text(
                        "BS: Nguyễn Hữu Lộc",
                        style: new TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    new SizedBox(
                      height: 2,
                    ),
                    new Container(
                      margin: EdgeInsets.only(left: 20),
                      child: new Text(
                        "BV: Chợ Rẫy",
                        style: new TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
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
                    child: new Icon(
                      Icons.flash_on,
                      color: Colors.green,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
