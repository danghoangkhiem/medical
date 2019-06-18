import 'package:flutter/material.dart';
import 'package:date_utils/date_utils.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:medical/src/blocs/schedule_work/schedule_work.dart';

import 'package:medical/src/models/schedule_work_model.dart';

import 'schedule_work_create_page.dart';

import 'package:medical/src/ui/widgets/loading_indicator.dart';

class ScheduleWorkPage extends StatefulWidget {
  @override
  _ScheduleWorkPageState createState() => _ScheduleWorkPageState();
}

class _ScheduleWorkPageState extends State<ScheduleWorkPage>
    with TickerProviderStateMixin {
  DateTime _selectedDay;
  Map<DateTime, List<ScheduleWorkModel>> _visibleEvents;
  List<ScheduleWorkModel> _selectedEvents;
  AnimationController _controller;
  bool _isOverlapping;

  ScheduleWorkBloc _scheduleWorkBloc;

  @override
  void initState() {
    super.initState();
    _scheduleWorkBloc = ScheduleWorkBloc();
    _selectedDay = DateTime.now();
    _selectedEvents = [];
    _visibleEvents = {};

    DateTime _startDate =
        Utils.firstDayOfWeek(Utils.firstDayOfMonth(_selectedDay));
    DateTime _endDate = Utils.lastDayOfWeek(Utils.lastDayOfMonth(_selectedDay));

    _scheduleWorkBloc.dispatch(EventList(
      startDate: _startDate,
      endDate: _endDate,
    ));

    _controller = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _controller.forward();
    _isOverlapping = false;
  }

  @override
  void dispose() {
    _scheduleWorkBloc?.dispose();
    _controller?.dispose();
    super.dispose();
  }

  void _onDaySelected(DateTime day, List events) {
    _controller.forward(from: 0.0);
    _selectedEvents =
        _visibleEvents.containsKey(day) ? _visibleEvents[day] : [];
    _scheduleWorkBloc.dispatch(DaySelected(day: day));
  }

  void _onVisibleDaysChanged(
      DateTime first, DateTime last, CalendarFormat format) {
    _scheduleWorkBloc.dispatch(EventList(startDate: first, endDate: last));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text("Lên kế hoạch làm việc"),
      ),
      body: BlocListener(
        bloc: _scheduleWorkBloc,
        listener: (BuildContext context, ScheduleWorkState state) {
          if (state.daySelected != null) {
            _selectedDay = state.daySelected;
          }
          if (state.schedules != null && state.daySelected == null) {
            _visibleEvents = {};
            for (int i = 0; i < state.schedules.length; i++) {
              if (state.schedules[i].date is! DateTime) {
                continue;
              }
              var dateKey = DateTime(
                state.schedules[i].date.year,
                state.schedules[i].date.month,
                state.schedules[i].date.day,
              );
              if (!_visibleEvents.containsKey(dateKey)) {
                _visibleEvents
                    .addAll(<DateTime, List<ScheduleWorkModel>>{dateKey: []});
              }
              _visibleEvents[dateKey].add(state.schedules[i]);
            }
          }
          if (state.isLoading && !_isOverlapping) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return WillPopScope(
                  onWillPop: () async => false,
                  child: LoadingIndicator(),
                );
              },
            ).then((_) => _isOverlapping = false);
            _isOverlapping = true;
          }
          if (_isOverlapping && !state.isLoading) {
            Navigator.of(context).pop();
          }
        },
        child: BlocBuilder(
          bloc: _scheduleWorkBloc,
          builder: (BuildContext context, ScheduleWorkState state) {
            if (state.errorMessage != null) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.of(context).pop();
                showDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Có lỗi xảy ra!'),
                      content: Container(
                        child: Text(state.errorMessage.toString()),
                      ),
                      actions: <Widget>[
                        FlatButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('OK!'),
                        )
                      ],
                    );
                  },
                );
              });
              return Container();
            }
            return Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                _buildTableCalendarWithBuilders(),
                Expanded(
                  child: _buildEventList(),
                ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => ScheduleWorkCreatePage()));
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }

  Widget _buildTableCalendarWithBuilders() {
    return TableCalendar(
      locale: 'en_US',
      events: _visibleEvents,
      initialCalendarFormat: CalendarFormat.month,
      formatAnimation: FormatAnimation.slide,
      startingDayOfWeek: StartingDayOfWeek.monday,
      availableGestures: AvailableGestures.all,
      availableCalendarFormats: const {
        CalendarFormat.month: 'Month',
        //CalendarFormat.twoWeeks: '2 Weeks',
        //CalendarFormat.week: 'Week',
      },
      calendarStyle: CalendarStyle(
        outsideDaysVisible: true,
        markersMaxAmount: 99,
        weekendStyle: TextStyle().copyWith(color: Colors.blue[800]),
      ),
      daysOfWeekStyle: DaysOfWeekStyle(
        weekendStyle: TextStyle().copyWith(color: Colors.blue[600]),
      ),
      headerStyle: HeaderStyle(
        centerHeaderTitle: true,
        formatButtonVisible: false,
      ),
      builders: CalendarBuilders(
        selectedDayBuilder: (context, date, _) {
          return FadeTransition(
            opacity: Tween(begin: 0.0, end: 1.0).animate(_controller),
            child: Container(
              margin: const EdgeInsets.all(4.0),
              padding: const EdgeInsets.only(top: 5.0, left: 6.0),
              color: Colors.deepOrange[300],
              width: 100,
              height: 100,
              child: Text(
                '${date.day}',
                style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          );
        },
        todayDayBuilder: (context, date, _) {
          return Container(
            margin: const EdgeInsets.all(4.0),
            padding: const EdgeInsets.only(top: 5.0, left: 6.0),
            color: Colors.amber[400],
            width: 100,
            height: 100,
            child: Text(
              '${date.day}',
              style: TextStyle().copyWith(fontSize: 16.0),
            ),
          );
        },
        markersBuilder: (context, date, events, _) {
          final children = <Widget>[];
          if (events.isNotEmpty) {
            children.add(
              Positioned(
                right: 1,
                bottom: 1,
                child: _buildEventsMarker(date, events),
              ),
            );
          }
          return children;
        },
      ),
      onDaySelected: _onDaySelected,
      onVisibleDaysChanged: _onVisibleDaysChanged,
    );
  }

  Widget _buildEventsMarker(DateTime date, List events) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Utils.isSameDay(date, _selectedDay)
            ? Colors.brown[500]
            : Utils.isSameDay(date, DateTime.now())
                ? Colors.brown[300]
                : Colors.blue[400],
      ),
      width: 16.0,
      height: 16.0,
      child: Center(
        child: Text(
          '${events.length}',
          style: TextStyle().copyWith(
            color: Colors.white,
            fontSize: 12.0,
          ),
        ),
      ),
    );
  }

  Widget _buildEventList() {
    return Material(
      color: Colors.grey[200],
      child: ListView(
        children: _selectedEvents
            .map((ScheduleWorkModel event) => Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 0.8),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  margin: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 4.0),
                  child: ListTile(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(event.partner?.location?.name),
                      ],
                    ),
                    onTap: () => print('$event tapped!'),
                  ),
                ))
            .toList(),
      ),
    );
  }
}
