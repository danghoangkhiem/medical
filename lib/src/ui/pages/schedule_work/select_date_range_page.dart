import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:medical/src/blocs/schedule_work_create/schedule_work_create.dart';
import 'package:medical/src/blocs/schedule_work/schedule_work.dart';

import 'package:medical/src/models/place_model.dart';
import 'package:medical/src/models/partner_model.dart';
import 'package:medical/src/models/hours_model.dart';

import 'package:medical/src/ui/widgets/date_range_picker.dart';
import 'package:medical/src/ui/widgets/time_range_slider.dart';
import 'package:medical/src/ui/widgets/loading_indicator.dart';

class SelectDateRangePage extends StatefulWidget {
  final DateTime selectedDate;
  final PlaceModel selectedPlace;
  final PartnerModel selectedPartner;
  final ScheduleWorkBloc scheduleWorkBloc;

  SelectDateRangePage({
    Key key,
    @required this.selectedDate,
    @required this.selectedPlace,
    @required this.selectedPartner,
    @required this.scheduleWorkBloc,
  }) : super(key: key);

  @override
  _SelectDateRangePageState createState() => _SelectDateRangePageState();
}

class _SelectDateRangePageState extends State<SelectDateRangePage> {
  ScheduleWorkCreateBloc _scheduleWorkCreateBloc;
  ScheduleWorkBloc get _scheduleWorkBloc => widget.scheduleWorkBloc;

  DateTime _firstDateRange;
  DateTime _lastDateRange;
  List<TimeRangeSlider> _timeRangeSliderList;
  Map<DateTime, Map<String, dynamic>> _schedules;

  bool _isOverlapping;

  @override
  void initState() {
    _scheduleWorkCreateBloc = ScheduleWorkCreateBloc();
    _firstDateRange = widget.selectedDate;
    _lastDateRange = _firstDateRange.add(Duration(days: 7));
    _schedules = {};
    _isOverlapping = false;
    _timeRangeSliderList =
        _generateTimeRangeSliderList(_firstDateRange, _lastDateRange);
    super.initState();
  }

  List<TimeRangeSlider> _generateTimeRangeSliderList(
      DateTime from, DateTime to) {
    _schedules = {};
    var length = to.difference(from).inHours ~/ 24 + 1;
    var generator = (int index) {
      var _date = from.add(Duration(days: index));
      _schedules[_date] = <String, dynamic>{
        'date': _date,
        'partnerId': widget.selectedPartner.id,
        'hours': HoursModel(
          from: _date,
          to: _date.add(Duration(hours: 21)),
        ),
      };
      return TimeRangeSlider(
        date: _date,
        onChanged: (DateTime startTime, DateTime endTime) {
          _schedules[_date]['hours'] = HoursModel(
            from: startTime,
            to: endTime,
          );
        },
      );
    };
    return List.generate(length, generator);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text('Chọn phạm vi ngày'),
      ),
      body: BlocListener(
        bloc: _scheduleWorkCreateBloc,
        listener: (BuildContext context, ScheduleWorkCreateState state) {
          if (state is Loading) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return LoadingIndicator(
                  opacity: 0.1,
                );
              },
            ).then((_) => _isOverlapping = false);
            _isOverlapping = true;
          }
          if (state is Success && _isOverlapping) {
            Navigator.of(context, rootNavigator: true).pop();
          }
          if (state is Success) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Thành công'),
                  content: Container(
                    child: Text('Đã lên kế hoạch làm việc thành công'),
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
          if (state is Failure) {
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text(state.error),
              backgroundColor: Colors.redAccent,
            ));
          }
          if (state is DateRangePicked) {
            _timeRangeSliderList =
                _generateTimeRangeSliderList(state.startDate, state.endDate);
          }
        },
        child: _buildPage(),
      ),
    );
  }

  Container _buildPage() {
    return Container(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          DateRangePicker(
            onChanged: (List<DateTime> picked) {
              _scheduleWorkCreateBloc.dispatch(
                  DateRange(startDate: picked[0], endDate: picked[1]));
            },
            initialFirstDate: _firstDateRange,
            initialLastDate: _lastDateRange,
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: BlocBuilder(
              bloc: _scheduleWorkCreateBloc,
              builder: (BuildContext context, _) {
                return Container(
                  color: Colors.grey[100],
                  child: ListView(
                    padding: const EdgeInsets.only(top: 24),
                    children: _timeRangeSliderList,
                  ),
                );
              },
            ),
          ),
          _buildButtonAction()
        ],
      ),
    );
  }

  Widget _buildButtonAction() {
    return Material(
      elevation: 5,
      child: Container(
        height: 65,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(left: 5),
                decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(4)),
                child: FlatButton(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  onPressed: () {
                    _scheduleWorkCreateBloc
                        .dispatch(Schedule(schedules: _schedules));
                  },
                  child: Text(
                    'Lên lịch',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
