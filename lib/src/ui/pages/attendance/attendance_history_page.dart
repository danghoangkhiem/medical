import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:medical/src/blocs/attendence/attendance_bloc.dart';
import 'package:medical/src/blocs/attendence/attendance_event.dart';
import 'package:medical/src/blocs/attendence/attendance_state.dart';
import 'package:medical/src/models/models.dart';
import 'package:medical/src/resources/attendance_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical/src/ui/widgets/loading_indicator.dart';

class AttendanceHistoryPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return new AttendanceHistoryPageState();
  }
}
class AttendanceHistoryPageState extends State<AttendanceHistoryPage>{

  AttendanceBloc _blocAttendance;

  AttendanceRepository _attendanceRepository = AttendanceRepository();

  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  DateTime starDay;
  DateTime endDay;



  @override
  void initState() {
    super.initState();
    _blocAttendance = AttendanceBloc(attendanceRepository: _attendanceRepository);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.blueAccent,
        title: new Text("Lịch sử chấm công"),
      ),
      body: new Container(
        child: new Column(
          children: <Widget>[
            new Expanded(
                flex: 3,
                child: new Form(
                    key: _formKey,
                    child: new ListView(
                      children: <Widget>[
                        new Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          child: new Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              new SizedBox(height: 20,),
                              new Row(
                                children: <Widget>[
                                  new Text("Từ ngày ", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black54),),
                                  new SizedBox(width: 30,),
                                  new Flexible(
                                    child: DateTimePickerFormField(
                                      inputType: InputType.date,
                                      format: DateFormat("dd-MM-yyyy"),
                                      initialDate: DateTime.now(),
                                      lastDate: endDay,
                                      editable: false,
                                      decoration: InputDecoration(
                                        labelText: 'Chọn ngày bắt đầu',
                                        labelStyle: new TextStyle(fontWeight: FontWeight.normal, color: Colors.grey),
                                        hasFloatingPlaceholder: false,
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.blueAccent, width: 2)
                                        ),
                                        border: OutlineInputBorder(),
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 10),
                                      ),
                                      style: new TextStyle(fontSize: 18, color: Colors.blueAccent, fontWeight: FontWeight.bold),
                                      onChanged: (dt) {
                                        if(dt != null){
                                          setState(() {
                                            starDay = dt;

                                          });
                                        }
                                      },
                                    ),
                                  )
                                ],
                              ),
                              new SizedBox(height: 10,),
                              new Row(
                                children: <Widget>[
                                  new Text("Đến ngày ", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black54),),
                                  new SizedBox(width: 20,),
                                  new Flexible(
                                    child: DateTimePickerFormField(
                                      inputType: InputType.date,
                                      format: DateFormat("dd-MM-yyyy"),
                                      initialDate: DateTime.now(),
                                      lastDate: DateTime.now(),
                                      firstDate: starDay,
                                      editable: false,
                                      decoration: InputDecoration(
                                        labelText: 'Chọn ngày kết thúc',
                                        labelStyle: new TextStyle(fontWeight: FontWeight.normal, color: Colors.grey),
                                        hasFloatingPlaceholder: false,
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.blueAccent, width: 2)
                                        ),
                                        border: OutlineInputBorder(),
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 10),
                                      ),
                                      style: new TextStyle(fontSize: 18, color: Colors.blueAccent, fontWeight: FontWeight.bold),
                                      onChanged: (dt) {
                                        if(dt != null){
                                          setState(() {
                                            endDay = dt;
                                            //print(endDay.millisecondsSinceEpoch);
                                          });
                                        }
                                      },
                                    ),
                                  )
                                ],
                              ),
                              new SizedBox(
                                height: 10,
                              ),
                              new Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.blueAccent,
                                ),
                                height: 42,
                                child: FlatButton(
                                    onPressed: (){
                                      if(starDay !=null && endDay!=null){
                                        //print("tìm $starDay - $endDay");
                                        _blocAttendance.dispatch(GetAttendance(starDay: starDay, endDay: endDay, offset: 0, limit: 10));
                                      }
                                      else{
                                        print("Chua du dieu kien tim");
                                      }
                                    },
                                    child: new Text("Tìm", style: new TextStyle(fontSize: 18, color: Colors.white),)
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    )
                )
            ),
            new Expanded(
                flex: 6,
                child: new Container(
                  height: double.infinity,
                  color: Colors.white,
                  child: BlocBuilder<AttendanceEvent, AttendanceState>(bloc: _blocAttendance, builder: (context, state){

                    if(state is AttendanceLoading){
                      return LoadingIndicator();
                    }
                    if(state is AttendanceLoaded){
                      return buildListView(state.attendance);
                    }
                    if(state is AttendanceFailure){
                      return Center(
                        child: new Text(state.error),
                      );
                    }

                    return Container(child: new Center(child: new Text("thông", style: TextStyle(color: Colors.white),),),);
                  }),
                )
            )
          ],
        ),
      ),
    );
  }

  Widget buildListView(AttendancesModel attendance) {
    return ListView.builder(
      itemCount: attendance.listAttendance.length,
        itemBuilder: (BuildContext context, int index){
        return buildContainer(attendance.listAttendance[index]);
    });
  }

  Widget buildContainer(AttendanceItem item) {
    print("ok thong:" );
    print(item.timeIn);
    return new Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        height: 100,
        color: Colors.white,
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Text(item.location.name, style: new TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
            new SizedBox(height: 10,),
            new Container(
              margin: EdgeInsets.only(left: 20),
              child: new Row(
                children: <Widget>[
                  new Container(
                    margin: EdgeInsets.only(right: 15),
                    child: new Icon(Icons.check_circle, color: Colors.green,),
                  ),
                  new Container(
                    child: new Text(item.timeIn.toString(), style: new TextStyle(fontSize: 16, color: Colors.black54),),
                  )
                ],
              ),
            ),
            new SizedBox(height: 3,),
            new Container(
              margin: EdgeInsets.only(left: 20),
              child: new Row(
                children: <Widget>[
                  new Container(
                    margin: EdgeInsets.only(right: 15),
                    child: new Icon(Icons.check_circle, color: Colors.deepOrange,),
                  ),
                  new Container(
                    //kiem tra co hay khong
                    child: new Text(item.timeOut.toString(), style: new TextStyle(fontSize: 16, color: Colors.black54),),
                  )
                ],
              ),
            )
          ],
        ),
      );
  }
}

