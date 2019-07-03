import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_range_slider/flutter_range_slider.dart';

typedef TimeRangeSliderCallback = void Function(
    DateTime startTime, DateTime endTime, bool isDisabled);

class TimeRangeSlider extends StatefulWidget {
  final DateTime date;
  final TimeRangeSliderCallback onChanged;
  final double min;
  final double max;
  final double lowerValue;
  final double upperValue;

  TimeRangeSlider({
    Key key,
    @required this.date,
    @required this.onChanged,
    this.min = 6.0,
    this.max = 21.0,
    this.lowerValue,
    this.upperValue,
  }) : super(key: key);

  @override
  _TimeRangeSliderState createState() => _TimeRangeSliderState();
}

class _TimeRangeSliderState extends State<TimeRangeSlider> {
  double get _minExceeded => widget.min - 0.5;
  double get _maxExceeded => widget.max + 0.5;

  double _lowerValue;
  double _upperValue;

  DateTime _startTime;
  DateTime _endTime;

  TimeRangeSliderCallback get _onChanged => widget.onChanged;

  bool get _isDisabled => _lowerValue < widget.min || _upperValue > widget.max;

  _TimeRangeSliderState();

  @override
  void initState() {
    super.initState();
    _lowerValue = widget.lowerValue ?? _minExceeded;
    _upperValue = widget.upperValue ?? _maxExceeded;
    _startTime = _generateTimeFromValue(_lowerValue);
    _endTime = _generateTimeFromValue(_upperValue);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _onChanged(_startTime, _endTime, _isDisabled);
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
                  style: TextStyle(
                      color: _isDisabled ? Colors.grey : Colors.black),
                  textAlign: TextAlign.start,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Text(
                  '${DateFormat('dd/MM/y').format(widget.date)}',
                  style: TextStyle(
                      color: _isDisabled ? Colors.grey : Colors.black),
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
                child: Text(
                  _isDisabled ? '__ : __' : DateFormat('Hm').format(_startTime),
                  style: TextStyle(
                      color: _isDisabled ? Colors.grey : Colors.black),
                ),
              ),
              Expanded(
                child: RangeSlider(
                  valueIndicatorFormatter: (int index, double value) {
                    if (value > widget.max || value < widget.min) {
                      return 'Không chọn giờ';
                    }
                    DateTime _date = _generateTimeFromValue(value);
                    return DateFormat('jm').format(_date);
                  },
                  min: _minExceeded,
                  max: _maxExceeded,
                  lowerValue: _lowerValue,
                  upperValue: _upperValue,
                  divisions: (_maxExceeded - _minExceeded).abs().ceil() * 2,
                  showValueIndicator: true,
                  onChanged: (double newLowerValue, double newUpperValue) {
                    setState(() {
                      _lowerValue = newLowerValue;
                      _upperValue = newUpperValue;
                      _startTime = _generateTimeFromValue(_lowerValue);
                      _endTime = _generateTimeFromValue(_upperValue);
                      _onChanged(_startTime, _endTime, _isDisabled);
                    });
                  },
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                width: 45,
                child: Text(
                  _isDisabled ? '__ : __' : DateFormat('Hm').format(_endTime),
                  style: TextStyle(
                      color: _isDisabled ? Colors.grey : Colors.black),
                ),
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
