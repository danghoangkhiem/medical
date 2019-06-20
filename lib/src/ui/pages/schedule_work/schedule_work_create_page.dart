import 'package:flutter/material.dart';

class ScheduleWorkCreatePage extends StatefulWidget {
  final DateTime day;

  ScheduleWorkCreatePage({Key key, @required this.day}) : super(key: key);

  @override
  _ScheduleWorkCreatePageState createState() => _ScheduleWorkCreatePageState();
}

class _ScheduleWorkCreatePageState extends State<ScheduleWorkCreatePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text('Thêm lịch hẹn'),
      ),
      body: Container(

      ),
    );
  }
}