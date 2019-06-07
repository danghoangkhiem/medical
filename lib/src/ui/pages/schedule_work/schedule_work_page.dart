import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:medical/src/ui/widgets/loading_indicator.dart';

class ScheduleWorkPage extends StatefulWidget {
  @override
  _ScheduleWorkPageState createState() => _ScheduleWorkPageState();
}

class _ScheduleWorkPageState extends State<ScheduleWorkPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text("Lên kế hoạch làm việc"),
      ),
      body: Container(
        child: LoadingIndicator(),
      ),
    );
  }
}
