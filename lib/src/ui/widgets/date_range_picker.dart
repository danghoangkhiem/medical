import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:date_range_picker/date_range_picker.dart' as _DateRangePicker;

typedef DateRangePickerCallback = Function(List<DateTime> dateRangePicked);

class DateRangePicker extends StatefulWidget {
  final DateRangePickerCallback onChanged;
  final DateTime initialFirstDate;
  final DateTime initialLastDate;
  final DateTime firstDate;
  final DateTime lastDate;

  DateRangePicker({
    Key key,
    @required this.onChanged,
    @required this.initialFirstDate,
    @required this.initialLastDate,
    this.firstDate,
    this.lastDate,
  }) : super(key: key);

  @override
  _DateRangePickerState createState() => _DateRangePickerState();
}

class _DateRangePickerState extends State<DateRangePicker> {
  List<DateTime> _dateRangePicked;
  Function get _onChanged => widget.onChanged;

  @override
  void initState() {
    super.initState();
    _dateRangePicked = [widget.initialFirstDate, widget.initialLastDate];
  }

  void onTap() async {
    final List<DateTime> picked = await _DateRangePicker.showDatePicker(
      context: context,
      initialFirstDate: _dateRangePicked[0],
      initialLastDate: _dateRangePicked[1],
      firstDate: widget.firstDate ?? DateTime(1979),
      lastDate: widget.lastDate ?? DateTime(2099),
    );
    if (picked != null && picked.length == 2) {
      setState(() {
        _dateRangePicked = picked;
        _onChanged(_dateRangePicked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
                style: BorderStyle.solid, width: 1, color: Colors.grey[300]),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 20),
          height: 40,
          child: Text(
            '${DateFormat('dd/MM/y').format(_dateRangePicked[0])}'
                ' - '
                '${DateFormat('dd/MM/y').format(_dateRangePicked[1])}',
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}