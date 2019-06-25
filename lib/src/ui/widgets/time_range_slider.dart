import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_range_slider/flutter_range_slider.dart';

typedef TimeRangeSliderCallback = void Function(
    DateTime startTime, DateTime endTime);

class TimeRangeSlider extends StatefulWidget {
  final DateTime date;
  final TimeRangeSliderCallback onChanged;

  TimeRangeSlider({Key key, @required this.date, @required this.onChanged})
      : super(key: key);

  @override
  _TimeRangeSliderState createState() => _TimeRangeSliderState();
}

class _TimeRangeSliderState extends State<TimeRangeSlider> {
  double _lowerValue;
  double _upperValue;

  DateTime _startTime;
  DateTime _endTime;

  TimeRangeSliderCallback get _onChanged => widget.onChanged;

  @override
  void initState() {
    super.initState();
    _lowerValue = 0.0;
    _upperValue = 21.0;
    _startTime = _generateTimeFromValue(_lowerValue);
    _endTime = _generateTimeFromValue(_upperValue);
  }

  DateTime _generateTimeFromValue(double value) {
    return DateTime(
      widget.date.year,
      widget.date.month,
      widget.date.day,
      value.toInt(),
      value > value.floor() ? 30 : 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 10,
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  '${DateFormat('EEEE', 'vi_VN').format(widget.date)}',
                  textAlign: TextAlign.start,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Text(
                  '${DateFormat('dd/MM/y').format(widget.date)}',
                  textAlign: TextAlign.end,
                ),
              ),
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: <Widget>[
              Container(
                alignment: Alignment.centerLeft,
                width: 45,
                child: Text(DateFormat('Hm').format(_startTime)),
              ),
              Expanded(
                child: RangeSlider(
                  valueIndicatorFormatter: (int index, double value) {
                    DateTime _date = _generateTimeFromValue(value);
                    return DateFormat('jm').format(_date);
                  },
                  min: 0.0,
                  max: 21.0,
                  lowerValue: _lowerValue,
                  upperValue: _upperValue,
                  divisions: 42,
                  showValueIndicator: true,
                  onChanged: (double newLowerValue, double newUpperValue) {
                    setState(() {
                      _lowerValue = newLowerValue;
                      _upperValue = newUpperValue;
                      _startTime = _generateTimeFromValue(_lowerValue);
                      _endTime = _generateTimeFromValue(_upperValue);
                      _onChanged(_startTime, _endTime);
                    });
                  },
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                width: 45,
                child: Text(DateFormat('Hm').format(_endTime)),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
