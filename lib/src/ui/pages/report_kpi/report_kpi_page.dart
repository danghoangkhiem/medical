import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:medical/src/blocs/report_kpi_date/report_kpi_date_bloc.dart';
import 'package:medical/src/blocs/report_kpi_date/report_kpi_date_event.dart';
import 'package:medical/src/blocs/report_kpi_date/report_kpi_date_state.dart';
import 'package:medical/src/blocs/report_kpi_month/report_kpi_month_bloc.dart';
import 'package:medical/src/blocs/report_kpi_month/report_kpi_month_event.dart';
import 'package:medical/src/blocs/report_kpi_month/report_kpi_month_state.dart';
import 'package:medical/src/models/report_kpi_date_model.dart';
import 'package:medical/src/models/report_kpi_month_model.dart';
import 'package:medical/src/resources/report_kpi_date_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical/src/resources/report_kpi_month_repository.dart';
import 'package:medical/src/ui/pages/report_kpi/kpi_date_detail.dart';
import 'package:medical/src/ui/widgets/loading_indicator.dart';
import 'package:medical/src/utils.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

class ReportKpiPage extends StatefulWidget {
  @override
  _ReportKpiPageState createState() {
    return _ReportKpiPageState();
  }
}

class _ReportKpiPageState extends State<ReportKpiPage> {
  final DateTime initialDate = DateTime.now();

  DateTime selectedDate;

  bool existDate = true;

  int _count = 0;
  int _countMonth = 0;

  DateTime startDate;
  DateTime endDate;
  DateTime _now;

  int offsetKpi = 0;
  int offsetKpiMonth = 0;

  ReportKpiDateBloc _blocReportKpiDay;
  ReportKpiMonthBloc _blocReportKpiMonth;

  ReportKpiDateRepository _reportKpiDayRepository = ReportKpiDateRepository();

  ReportKpiMonthRepository _reportKpiMonthRepository =
      ReportKpiMonthRepository();

  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    _now = DateTime.now();
    startDate = endDate = DateTime.parse(DateFormat('yyyy-MM-dd').format(_now));

    selectedDate = initialDate;

    _blocReportKpiDay =
        ReportKpiDateBloc(reportKpiDateRepository: _reportKpiDayRepository);
    _blocReportKpiMonth =
        ReportKpiMonthBloc(reportKpiMonthRepository: _reportKpiMonthRepository);
  }

  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
        length: 2,
        child: new Scaffold(
          appBar: new AppBar(
            backgroundColor: Colors.blueAccent,
            title: new Text("Thống kê KPI"),
            bottom: new TabBar(tabs: <Widget>[
              new Tab(
                text: "KPI ngày",
              ),
              new Tab(
                text: "KPI tháng",
              )
            ]),
          ),
          body: new TabBarView(children: <Widget>[
            new Container(
              child: new Column(
                children: <Widget>[
                  new Container(
                    margin: EdgeInsets.only(top: 10),
                    height: 180,
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
                                  new SizedBox(
                                    height: 5,
                                  ),
                                  new Row(
                                    children: <Widget>[
                                      new Text(
                                        "Từ ngày ",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black54),
                                      ),
                                      new SizedBox(
                                        width: 30,
                                      ),
                                      new Flexible(
                                        child: DateTimePickerFormField(
                                          inputType: InputType.date,
                                          format: DateFormat("dd-MM-yyyy"),
                                          initialDate: endDate ?? _now,
                                          lastDate: endDate ?? _now,
                                          initialValue: startDate,
                                          editable: false,
                                          decoration: InputDecoration(
                                            labelText: 'Chọn ngày bắt đầu',
                                            labelStyle: new TextStyle(
                                                fontWeight: FontWeight.normal,
                                                color: Colors.grey),
                                            hasFloatingPlaceholder: false,
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.blueAccent,
                                                    width: 2)),
                                            border: OutlineInputBorder(),
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    vertical: 10,
                                                    horizontal: 10),
                                          ),
                                          style: new TextStyle(
                                              fontSize: 18,
                                              color: Colors.blueAccent,
                                              fontWeight: FontWeight.bold),
                                          onChanged: (dt) {
                                            if (dt != null) {
                                              setState(() {
                                                startDate = dt;
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
                                  new Row(
                                    children: <Widget>[
                                      new Text(
                                        "Đến ngày ",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black54),
                                      ),
                                      new SizedBox(
                                        width: 20,
                                      ),
                                      new Flexible(
                                        child: DateTimePickerFormField(
                                          inputType: InputType.date,
                                          format: DateFormat("dd-MM-yyyy"),
                                          initialDate: startDate ?? _now,
                                          firstDate: startDate,
                                          initialValue: endDate,
                                          lastDate: _now,
                                          editable: false,
                                          decoration: InputDecoration(
                                            labelText: 'Chọn ngày kết thúc',
                                            labelStyle: new TextStyle(
                                                fontWeight: FontWeight.normal,
                                                color: Colors.grey),
                                            hasFloatingPlaceholder: false,
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.blueAccent,
                                                    width: 2)),
                                            border: OutlineInputBorder(),
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    vertical: 10,
                                                    horizontal: 10),
                                          ),
                                          style: new TextStyle(
                                              fontSize: 18,
                                              color: Colors.blueAccent,
                                              fontWeight: FontWeight.bold),
                                          onChanged: (dt) {
                                            if (dt != null) {
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
                                        onPressed: () {
                                          if (startDate != null &&
                                              endDate != null) {
                                            print("Du dieu kien tim");
                                            _blocReportKpiDay.dispatch(
                                                GetReportKpiDay(
                                                    starDay: startDate,
                                                    endDay: endDate,
                                                    ));
                                          } else {
                                            print("Chua du dieu kien tim");
                                          }
                                        },
                                        child: new Text(
                                          "Tìm",
                                          style: new TextStyle(
                                              fontSize: 18,
                                              color: Colors.white),
                                        )),
                                  )
                                ],
                              ),
                            ),
                          ],
                        )),
                  ),
                  new Expanded(
                      child: new Container(
                    child: new Column(
                      children: <Widget>[
                        new Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          height: 50,
                          color: Colors.grey[200],
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              new Container(
                                child: new Text(
                                  "Ngày",
                                  style: new TextStyle(fontSize: 16),
                                ),
                              ),
                              new Container(
                                child: new Text(
                                  "Lượt viếng thăm",
                                  style: new TextStyle(fontSize: 16),
                                ),
                              )
                            ],
                          ),
                        ),
                        new Expanded(
                          child: Container(
                            child: BlocListener(
                              bloc: _blocReportKpiDay,
                              listener: (BuildContext context, state) {
                                if (state is ReportKpiEmpty) {
                                  Scaffold.of(context).removeCurrentSnackBar();
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                    duration: Duration(milliseconds: 1500),
                                    content: Text('Không có dữ liệu'),
                                  ));
                                }
                              },
                              child: BlocBuilder(
                                  bloc: _blocReportKpiDay,
                                  builder: (BuildContext context, state) {
                                    if (state is ReportKpiDateLoading) {
                                      return LoadingIndicator(
                                        opacity: 0,
                                      );
                                    }
                                    if (state is ReportKpiDateLoaded) {
                                      return ListView.builder(
                                          itemCount: state.reportKpiDateModel
                                              .listKpiDateItem.length,
                                          itemBuilder:
                                              (BuildContext context, index) {
                                            return buildContainer(state
                                                .reportKpiDateModel
                                                .listKpiDateItem[index]);
                                          });
                                    }
                                    if (state is ReportKpiDateFailure) {
                                      return Container(
                                        child: new Center(
                                          child: Text(state.error),
                                        ),
                                      );
                                    }
                                    return Container();
                                  }),
                            ),
                          ),
                        )
                      ],
                    ),
                  )),
                  new Container(
                    height: 40,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    alignment: Alignment.center,
                    width: double.infinity,
                    color: Colors.grey[200],
                    child: BlocBuilder(
                        bloc: _blocReportKpiDay,
                        builder: (BuildContext context, state) {
                          if (state is ReportKpiDateLoaded) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                new Container(
                                  child: new Text(
                                    "Tổng",
                                    style: new TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                new Container(
                                  child: new Text(
                                    state.countKpi.toString(),
                                    style: new TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            );
                          }
                          return Container();
                        }),
                  )
                ],
              ),
            ),
            new Container(
              child: new Column(
                children: <Widget>[
                  new Container(
                    height: 140,
                    child: new Column(
                      children: <Widget>[
                        new Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.blueAccent,
                                style: BorderStyle.solid,
                                width: 1),
                            color: Colors.white,
                          ),
                          width: double.infinity,
                          margin: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 20),
                          child: new FlatButton(
                              onPressed: () {
                                showMonthPicker(
                                        context: context,
                                        initialDate:
                                            selectedDate ?? initialDate)
                                    .then((date) => setState(() {
                                          selectedDate = date;
                                          print(selectedDate);
                                          if (selectedDate.year.toInt() > 0) {
                                            existDate = true;
                                          } else {
                                            existDate = false;
                                          }
                                        }));
                              },
                              child: existDate
                                  ? new Text(
                                      "${selectedDate?.month}/${selectedDate?.year}",
                                      style: new TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          color: Colors.blueAccent),
                                    )
                                  : new Text(
                                      "Chọn tháng",
                                      style: new TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          color: Colors.blueAccent),
                                    )),
                        ),
                        new Container(
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.blueAccent,
                          ),
                          height: 42,
                          child: FlatButton(
                              onPressed: () {
                                if (selectedDate != null) {
                                  print("Du dieu kien tim kiem");
                                  print(selectedDate);
                                  _blocReportKpiMonth
                                      .dispatch(GetReportKpiMonth(
                                    startMonth: selectedDate,
                                  ));
                                } else {
                                  print("Ko ok cho lam");
                                }
                              },
                              child: new Text(
                                "Tìm",
                                style: new TextStyle(
                                    fontSize: 18, color: Colors.white),
                              )),
                        )
                      ],
                    ),
                  ),
                  new Expanded(
                      flex: 10,
                      child: new Container(
                        color: Colors.grey[200],
                        child: new Column(
                          children: <Widget>[
                            new Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 15),
                              height: 50,
                              color: Colors.grey[200],
                              child: Table(
                                columnWidths: {
                                  0: FractionColumnWidth(0.6),
                                },
                                children: [
                                  TableRow(children: [
                                    new Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        new Text(
                                          "Họ tên",
                                          style: new TextStyle(fontSize: 16),
                                        ),
                                      ],
                                    ),
                                    new Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        new Text(
                                          "Loại",
                                          style: new TextStyle(fontSize: 16),
                                        ),
                                      ],
                                    ),
                                    new Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        new Text(
                                          "Số lần",
                                          style: new TextStyle(fontSize: 16),
                                        ),
                                      ],
                                    ),
                                  ]),
                                ],
                              ),
                            ),
//reach data
                            new Expanded(
                                child: Container(
                                  width: double.infinity,
                              color: Colors.white,
                              child: BlocListener(
                                  bloc: _blocReportKpiMonth,
                                  listener: (BuildContext context, state){
                                    if(state is ReportKpiMonthEmpty){
                                      Scaffold.of(context).removeCurrentSnackBar();
                                      Scaffold.of(context).showSnackBar(SnackBar(
                                        duration: Duration(milliseconds: 1500),
                                        content: Text('Không có dữ liệu'),
                                      ));
                                    }
                                  },
                                child: BlocBuilder(
                                    bloc: _blocReportKpiMonth,
                                    builder: (BuildContext context,
                                        ReportKpiMonthState state) {
                                      if (state is ReportKpiMonthLoading) {
                                        return LoadingIndicator(
                                          opacity: 0,
                                        );
                                      }
                                      if (state is ReportKpiMonthLoaded) {
                                        return new Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: SingleChildScrollView(
                                            child: Table(
                                              columnWidths: {
                                                0: FractionColumnWidth(0.6),
                                              },
                                              children: state.reportKpiMonthModel
                                                  .listKpiMonthItem
                                                  .map((item) {
                                                return TableRow(children: [
                                                  SingleChildScrollView(
                                                    scrollDirection:
                                                    Axis.horizontal,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                      children: <Widget>[
                                                        Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                              vertical: 10),
                                                          child: new Text(
                                                            item.name,
                                                            style: new TextStyle(
                                                                fontSize: 16),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  new Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                    children: <Widget>[
                                                      Padding(
                                                        padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 10),
                                                        child: new Text(
                                                          item.type,
                                                          style: new TextStyle(
                                                              fontSize: 16),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  new Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                    children: <Widget>[
                                                      Padding(
                                                        padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 10),
                                                        child: new InkWell(
                                                          onTap: () {},
                                                          child: new Text(
                                                            item.count.toString(),
                                                            style: new TextStyle(
                                                                fontSize: 16),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ]);
                                              }).toList(),
                                            ),
                                          ),
                                        );
                                      }
                                      return Container();
                                    }),
                              ),
                            ))
                          ],
                        ),
                      )),
                  new Container(
                    height: 40,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    alignment: Alignment.centerRight,
                    width: double.infinity,
                    color: Colors.grey[200],
                    child: BlocBuilder(
                        bloc: _blocReportKpiMonth,
                        builder: (BuildContext context, state) {
                          if(state is ReportKpiMonthLoaded){
                            return Table(
                              columnWidths: {
                                0: FractionColumnWidth(0.4),
                                1: FractionColumnWidth(0.6)
                              },
                              children: [
                                TableRow(children: [
                                  new Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      new Text(
                                        "Tổng",
                                        style: new TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  new Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      new Padding(
                                        padding: EdgeInsets.only(left: 15),
                                        child: new Text(
                                          state.countKpi.toString(),
                                          style: new TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )
                                    ],
                                  ),
                                  new Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      new Text(
                                        "",
                                        style: new TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  new Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      new Text(
                                        "",
                                        style: new TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ]),
                              ],
                            );
                          }
                          return Container();
                        }),
                  )
                ],
              ),
            ),
          ]),
        ));
  }

  Widget buildContainer(ReportKpiDateItemModel item) {
    return new Container(
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  color: Colors.grey[200],
                  width: 1,
                  style: BorderStyle.solid))),
      padding: EdgeInsets.symmetric(horizontal: 20),
      height: 50,
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          new Container(
            child: new Text(
              DateFormat('dd-MM-yyyy').format(item.date),
              style: new TextStyle(fontSize: 16),
            ),
          ),
          new Container(
            child: new Text(
              item.countVisit.toString(),
              style: new TextStyle(fontSize: 16),
            ),
          )
        ],
      ),
    );
  }
}
