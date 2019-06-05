import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:medical/src/utils.dart';
import 'package:medical/src/ui/widgets/loading_indicator.dart';

import 'package:medical/src/models/day_coaching_model.dart';
import 'package:medical/src/blocs/day_coaching/day_coaching.dart';
import 'package:medical/src/ui/pages/day_coaching/day_coaching_detail_page.dart';

class DateCoachingPage extends StatefulWidget {
  final DateTime date;

  DateCoachingPage({this.date});

  @override
  _DateCoachingPageState createState() {
    return new _DateCoachingPageState();
  }
}

class _DateCoachingPageState extends State<DateCoachingPage> {
  final ScrollController _controller = ScrollController();

  DayCoachingListModel _dayCoachingList;
  DayCoachingBloc _dayCoachingBloc;

  bool _isLoading = false;

  @override
  void initState() {
    _dayCoachingList = DayCoachingListModel.fromJson([]);
    _dayCoachingBloc = DayCoachingBloc();
    _dayCoachingBloc.dispatch(DayCoachingFilter(date: widget.date));
    _controller.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _dayCoachingBloc?.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      throttle(200, () {
        if (_isLoading != true) {
          _isLoading = true;
          _dayCoachingBloc.dispatch(LoadMore());
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
        title: Text("Lịch Coaching trong ngày"),
      ),
      body: Container(
        child: new Column(
          children: <Widget>[
            Expanded(
              flex: 8,
              child: BlocListener(
                bloc: _dayCoachingBloc,
                listener: (BuildContext context, DayCoachingState state) {
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
                      _dayCoachingList.addAll(state.dayCoachingList);
                      _isLoading = false;
                    } else {
                      _dayCoachingList = state.dayCoachingList;
                    }
                  }
                },
                child: BlocBuilder(
                  bloc: _dayCoachingBloc,
                  builder: (BuildContext context, DayCoachingState state) {
                    if (state is Loading && !state.isLoadMore) {
                      return LoadingIndicator();
                    }
                    return ListView.builder(
                      controller: _controller,
                      itemCount: _isLoading
                          ? _dayCoachingList.length + 1
                          : _dayCoachingList.length,
                      itemBuilder: (BuildContext context, int index) {
                        if (_isLoading && index == _dayCoachingList.length) {
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
                                    DayCoachingDetailPage(
                                      dayCoaching: _dayCoachingList[index],
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
                                      Container(
                                        child: new Text(
                                          "Từ " +
                                              DateFormat('hh:mm').format(
                                                  _dayCoachingList[index]
                                                      .startTime) +
                                              " đến " +
                                              DateFormat('hh:mm').format(
                                                  _dayCoachingList[index]
                                                      .endTime),
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black54),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 7,
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: 20),
                                        child: new Text(
                                          _dayCoachingList[index].position +
                                              " : " +
                                              _dayCoachingList[index]
                                                  .doctorName,
                                          style: new TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      new SizedBox(
                                        height: 2,
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: 20),
                                        child: new Text(
                                          _dayCoachingList[index].addressType +
                                              " : " +
                                              _dayCoachingList[index]
                                                  .addressName,
                                          style: new TextStyle(
                                              fontSize: 18,
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
}
