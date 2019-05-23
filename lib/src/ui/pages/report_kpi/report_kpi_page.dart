import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:medical/src/blocs/report_kpi_date/report_kpi_date_bloc.dart';
import 'package:medical/src/blocs/report_kpi_date/report_kpi_date_event.dart';
import 'package:medical/src/resources/report_kpi_date_repository.dart';

class ReportKpiPage extends StatefulWidget {
  @override
  _ReportKpiPageState createState() {
    return _ReportKpiPageState();
  }
}

class _ReportKpiPageState extends State<ReportKpiPage> {

  DateTime starDate;
  DateTime endDate;
  int offsetkpi = 0;

  ReportKpiDayBloc _blocReportKpiDay;

  ReportKpiDayRepository _reportKpiDayRepository = ReportKpiDayRepository();

  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  @override
  void initState() {

    super.initState();
    _blocReportKpiDay = ReportKpiDayBloc(reportKpiDayRepository: _reportKpiDayRepository);
  }

  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
        length: 2,
        child: new Scaffold(
          appBar: new AppBar(
            title: new Text("Thống kê KPI"),
            bottom: new TabBar(
                tabs: <Widget>[
                  new Tab(
                    text: "KPI ngày",
                  ),
                  new Tab(
                    text: "KPI tháng",
                  )
                ]
            ),
          ),
          body: new TabBarView(
              children: <Widget>[
                new Container(
                  child: new Column(
                    children: <Widget>[
                      new Expanded(
                          flex: 4,
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
                                                      starDate = dt;
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
                                                      endDate = dt;
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
                                                if(starDate !=null && endDate!=null){
                                                  //print("tìm $starDay - $endDay");
                                                  _blocReportKpiDay.dispatch(GetReportKpiDay(starDay: starDate, endDay: endDate, offset: offsetkpi));

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
                          ),
                      ),
                      new Expanded(
                          flex: 7,
                          child: new Container(
                            child: new Column(
                              children: <Widget>[
                                new Container(
                                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                                  height: 55,
                                  color: Colors.grey[200],
                                  child: Table(
                                    columnWidths: {0: FractionColumnWidth(0.4), 1: FractionColumnWidth(0.4)},
                                    children: [
                                      TableRow(
                                          children: [
                                            new Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: <Widget>[
                                                new Text("Ngày", style: new TextStyle(fontSize: 16),),
                                              ],
                                            ),
                                            new Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: <Widget>[
                                                new Text("Lượt viếng thăm", style: new TextStyle(fontSize: 16),),
                                              ],
                                            ),
                                            new Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: <Widget>[
                                                new Text("", style: new TextStyle(fontSize: 16),),
                                              ],
                                            ),
                                          ]
                                      ),
                                    ],
                                  ),
                                ),
                                new Expanded(
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 20),
                                    child: SingleChildScrollView(
                                      child: Table(
                                        columnWidths: {0: FractionColumnWidth(0.4), 1: FractionColumnWidth(0.4)},
                                        children: [
                                          TableRow(
                                              children: [
                                                new Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: <Widget>[
                                                    Padding(
                                                      padding: EdgeInsets.symmetric(vertical: 10),
                                                      child: new Text("12-12-2019", style: new TextStyle(fontSize: 16),),
                                                    ),
                                                  ],
                                                ),
                                                new Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Padding(
                                                      padding: EdgeInsets.symmetric(vertical: 10),
                                                      child: new Text("15", style: new TextStyle(fontSize: 16),),
                                                    ),
                                                  ],
                                                ),
                                                new Row(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  children: <Widget>[
                                                    Padding(
                                                      padding: EdgeInsets.symmetric(vertical: 10),
                                                      child: new InkWell(
                                                        onTap: (){
                                                        },
                                                        child: new Text("chi tiết", style: new TextStyle(fontSize: 16, color: Colors.blueAccent),),
                                                      ),
                                                    ),
                                                  ],
                                                ),

                                              ]
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                      ),
                      new Expanded(
                          flex: 1,
                          child: new Container(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            alignment: Alignment.center,
                            width: double.infinity,
                            color: Colors.grey[200],
                            child: Table(
                              columnWidths: {0: FractionColumnWidth(0.5)},
                              children: [
                                TableRow(
                                    children: [
                                      new Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: <Widget>[
                                          new Text("Tổng", style: new TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                                        ],
                                      ),
                                      new Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          new Padding(
                                              padding: EdgeInsets.only(left: 15),
                                            child: new Text("20", style: new TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                                          )
                                        ],
                                      ),
                                      new Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          new Text("", style: new TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                                        ],
                                      ),
                                      new Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          new Text("", style: new TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                                        ],
                                      ),
                                    ]
                                ),
                              ],
                            ),
                          )
                      )
                    ],
                  ),
                ),
                new Container(
                  color: Colors.blueAccent,
                  child: new Center(
                    child: new Text("Thống kê theo tháng"),
                  ),
                ),
              ]
          ),
        )
    );
  }

}



