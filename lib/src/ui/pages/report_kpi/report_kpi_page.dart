import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:medical/src/blocs/report_kpi_date/report_kpi_date_bloc.dart';
import 'package:medical/src/blocs/report_kpi_date/report_kpi_date_event.dart';
import 'package:medical/src/blocs/report_kpi_date/report_kpi_date_state.dart';
import 'package:medical/src/blocs/report_kpi_month/report_kpi_month_bloc.dart';
import 'package:medical/src/blocs/report_kpi_month/report_kpi_month_event.dart';
import 'package:medical/src/blocs/report_kpi_month/report_kpi_month_state.dart';
import 'package:medical/src/models/report_kpi_day_model.dart';
import 'package:medical/src/models/report_kpi_month_model.dart';
import 'package:medical/src/resources/report_kpi_date_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical/src/resources/report_kpi_month_repository.dart';
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

  final ScrollController _scrollController = ScrollController();

  final ScrollController _scrollControllerMonth = ScrollController();

  bool _isLoadingMonth = false;
  bool _isLoading = false;

  ReportKpiDayModel listReportKpiDay;
  ReportKpiMonthModel listReportKpiMonth;

  int _count = 0;
  int _countMonth = 0;



  void _scrollListener() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      throttle(200, () {
        if (_isLoading != true) {
          _isLoading = true;
          print("Load more");
          _blocReportKpiDay.dispatch(GetReportKpiDayMore());

        }
      });
    }
  }

  void _scrollListenerMonth() {
    if (_scrollControllerMonth.position.pixels == _scrollControllerMonth.position.maxScrollExtent) {
      throttle(200, () {
        if (_isLoadingMonth != true) {
          _isLoadingMonth = true;
          print("Load more month");
          _blocReportKpiMonth.dispatch(GetReportKpiMonthMore());

        }
      });
    }
  }

  DateTime starDate;
  DateTime endDate;

  int offsetKpi = 0;
  int offsetKpiMonth = 0;


  ReportKpiDayBloc _blocReportKpiDay;
  ReportKpiMonthBloc _blocReportKpiMonth;


  ReportKpiDayRepository _reportKpiDayRepository = ReportKpiDayRepository();

  ReportKpiMonthRepository _reportKpiMonthRepository = ReportKpiMonthRepository();

  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  @override
  void initState() {

    super.initState();
    selectedDate = initialDate;
    listReportKpiMonth = ReportKpiMonthModel.fromJson([]);
    listReportKpiDay = ReportKpiDayModel.fromJson([]);
    _blocReportKpiDay = ReportKpiDayBloc(reportKpiDayRepository: _reportKpiDayRepository);
    _blocReportKpiMonth = ReportKpiMonthBloc(reportKpiMonthRepository: _reportKpiMonthRepository);
    _scrollController.addListener(_scrollListener);
    _scrollControllerMonth.addListener(_scrollListenerMonth);
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
                                                  print("Du dieu kien tim");
                                                  _blocReportKpiDay.dispatch(GetReportKpiDay(starDay: starDate, endDay: endDate, offset: offsetKpi, limit: 10));
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
                                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                                  height: 50,
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
                                      controller: _scrollController,
                                      child: BlocListener(
                                        bloc: _blocReportKpiDay,
                                        listener: (BuildContext context, ReportKpiDayState state){
                                          if (state is ReachMax) {
                                            Scaffold.of(context).removeCurrentSnackBar();
                                            Scaffold.of(context).showSnackBar(SnackBar(
                                              content: Text('Got all the data!'),
                                            ));
                                            _scrollController.removeListener(_scrollListener);
                                          }
                                          if (state is ReportKpiDayFailure) {
                                            Scaffold.of(context).removeCurrentSnackBar();
                                            Scaffold.of(context).showSnackBar(SnackBar(
                                              content: Text(state.error),
                                              backgroundColor: Colors.redAccent,
                                            ));
                                          }
                                          if (state is ReportKpiDayLoaded) {
                                            setState(() {
                                              _count = state.countKpi;
                                            });
                                            if (state.isLoadMore) {
                                              listReportKpiDay.listKpiDayItem.addAll(state.reportKpiDayModel.listKpiDayItem);
                                              _isLoading = false;
                                            } else {
                                              listReportKpiDay.listKpiDayItem = state.reportKpiDayModel.listKpiDayItem;
                                            }
                                          }
                                        },
                                        child: BlocBuilder(
                                            bloc: _blocReportKpiDay,
                                            builder: (BuildContext context, state){
                                              if (state is ReportKpiDayLoading && !state.isLoadMore) {
                                                return WillPopScope(
                                                  onWillPop: () async {
                                                    return true;
                                                  },
                                                  child: Container(
                                                    padding: EdgeInsets.only(top: 30),
                                                    color: Colors.transparent,
                                                    child: new Center(
                                                      child: new CircularProgressIndicator(),
                                                    ),
                                                  ),
                                                );
                                              }
                                              return Stack(
                                                children: <Widget>[
                                                  Table(
                                                    columnWidths: {0: FractionColumnWidth(0.4), 1: FractionColumnWidth(0.4)},
                                                    children: listReportKpiDay.listKpiDayItem.map((item){
                                                      return TableRow(
                                                          children: [
                                                            new Row(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              children: <Widget>[
                                                                Padding(
                                                                  padding: EdgeInsets.symmetric(vertical: 10),
                                                                  child:  new Text(DateFormat('dd-MM-yyyy').format(item.date), style: new TextStyle(fontSize: 16),),
                                                                ),
                                                              ],
                                                            ),
                                                            new Row(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              children: <Widget>[
                                                                Padding(
                                                                  padding: EdgeInsets.symmetric(vertical: 10),
                                                                  child: new Text(item.countVisit.toString(), style: new TextStyle(fontSize: 16),),
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
                                                      );
                                                    }).toList(),
                                                  ),
                                                  _isLoading ? Positioned(
                                                      bottom: 0,
                                                      left: 0,
                                                      child: Container(
                                                        padding: EdgeInsets.only(bottom: 10),
                                                        width: MediaQuery.of(context).size.width,
                                                        alignment: Alignment.center,
                                                        child: new Row(
                                                          children: <Widget>[
                                                            Spacer(),
                                                            CircularProgressIndicator(),
                                                            Spacer(),
                                                          ],
                                                        ),
                                                      )
                                                  ) : Container()
                                                ],
                                              );
                                            }
                                        ),
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
                            child: BlocBuilder(
                                bloc: _blocReportKpiDay,
                                builder: (BuildContext context, state){

                                  if(state is ReportKpiDayFailure){
                                    return new Text("Dữ liệu không hoạt động");
                                  }
                                  return Table(
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
                                                  child: new Text(_count.toString(), style: new TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
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
                                  );
                                }
                            ),
                          )
                      )
                    ],
                  ),
                ),
                new Container(
                  child: new Column(
                    children: <Widget>[
                      new Expanded(
                          flex: 4,
                          child: new Column(
                            children: <Widget>[
                              new Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.blueAccent,style: BorderStyle.solid,width: 1),
                                  color: Colors.white,
                                ),
                                width: double.infinity,
                                margin: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                                child: new FlatButton(
                                    onPressed: (){
                                      showMonthPicker(
                                          context: context,
                                          initialDate: selectedDate ?? initialDate)
                                          .then((date) => setState(() {
                                        selectedDate = date;
                                        print(selectedDate);
                                        if(selectedDate.year.toInt() > 0){
                                          existDate = true;
                                        }
                                        else{
                                          existDate = false;
                                        }
                                      }));
                                    },
                                    child: existDate ? new Text("${selectedDate?.month}/${selectedDate?.year}", style: new TextStyle(fontWeight: FontWeight.bold,fontSize: 18, color: Colors.blueAccent),) : new Text("Chọn tháng", style: new TextStyle(fontWeight: FontWeight.bold,fontSize: 18, color: Colors.blueAccent),)
                                ),
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
                                    onPressed: (){
                                      if(selectedDate != null){
                                        print("Du dieu kien tim kiem");
                                        print(selectedDate);
                                        _blocReportKpiMonth.dispatch(GetReportKpiMonth(starMonth: selectedDate, offset: offsetKpiMonth, limit: 10));
                                      }
                                      else{
                                        print("Ko ok cho lam");
                                      }

                                    },
                                    child: new Text("Tìm", style: new TextStyle(fontSize: 18, color: Colors.white),)
                                ),
                              )
                            ],
                          )
                      ),
                      new Expanded(
                          flex: 10,
                          child: new Container(
                            color: Colors.grey[200],
                            child: new Column(
                              children: <Widget>[
                                new Container(
                                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                                  height: 50,
                                  color: Colors.grey[200],
                                  child: Table(
                                    columnWidths: {0: FractionColumnWidth(0.4), 1: FractionColumnWidth(0.4)},
                                    children: [
                                      TableRow(
                                          children: [
                                            new Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: <Widget>[
                                                new Text("Họ tên", style: new TextStyle(fontSize: 16),),
                                              ],
                                            ),
                                            new Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: <Widget>[
                                                new Text("Loại", style: new TextStyle(fontSize: 16),),
                                              ],
                                            ),
                                            new Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: <Widget>[
                                                new Text("Số lần", style: new TextStyle(fontSize: 16),),
                                              ],
                                            ),
                                          ]
                                      ),
                                    ],
                                  ),
                                ),
//reach data
                                new Expanded(
                                    child: Container(
                                      color: Colors.white,
                                      child: SingleChildScrollView(
                                        controller: _scrollControllerMonth,
                                        child: BlocListener(
                                          bloc: _blocReportKpiMonth,
                                          listener: (BuildContext context, ReportKpiMonthState state){
                                            if (state is ReachMaxx) {
                                              Scaffold.of(context).removeCurrentSnackBar();
                                              Scaffold.of(context).showSnackBar(SnackBar(
                                                content: Text('Got all the data!'),
                                              ));
                                              _scrollControllerMonth.removeListener(_scrollListenerMonth);
                                            }
                                            if (state is ReportKpiMonthFailure) {
                                              Scaffold.of(context).removeCurrentSnackBar();
                                              Scaffold.of(context).showSnackBar(SnackBar(
                                                content: Text(state.error),
                                                backgroundColor: Colors.redAccent,
                                              ));
                                            }
                                            if (state is ReportKpiMonthLoaded) {
                                              setState(() {
                                                _countMonth = state.countKpi;
                                              });
                                              if (state.isLoadMore) {
                                                listReportKpiMonth.listKpiMonthItem.addAll(state.reportKpiMonthModel.listKpiMonthItem);
                                                _isLoadingMonth = false;
                                              } else {
                                                listReportKpiMonth.listKpiMonthItem = state.reportKpiMonthModel.listKpiMonthItem;
                                              }
                                            }
                                          },
                                          child: BlocBuilder(
                                              bloc: _blocReportKpiMonth,
                                              builder: (BuildContext context,ReportKpiMonthState state){

                                                if (state is ReportKpiMonthLoading && !state.isLoadMore) {
                                                  return WillPopScope(
                                                    onWillPop: () async {
                                                      return true;
                                                    },
                                                    child: Container(
                                                      padding: EdgeInsets.only(top: 30),
                                                      color: Colors.transparent,
                                                      child: new Center(
                                                        child: new CircularProgressIndicator(),
                                                      ),
                                                    ),
                                                  );
                                                }

                                                return Stack(
                                                  children: <Widget>[
                                                    new Container(
                                                      color: Colors.white,
                                                      width: MediaQuery.of(context).size.width,
                                                      padding: EdgeInsets.symmetric(horizontal: 20),
                                                      child: SingleChildScrollView(
                                                        child: Table(
                                                          columnWidths: {0: FractionColumnWidth(0.4), 1: FractionColumnWidth(0.4)},
                                                          children: listReportKpiMonth.listKpiMonthItem.map((item){
                                                            return TableRow(
                                                                children: [
                                                                  new Row(
                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                    children: <Widget>[
                                                                      Padding(
                                                                        padding: EdgeInsets.symmetric(vertical: 10),
                                                                        child:  new Text(item.name, style: new TextStyle(fontSize: 16),),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  new Row(
                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                    children: <Widget>[
                                                                      Padding(
                                                                        padding: EdgeInsets.symmetric(vertical: 10),
                                                                        child: new Text(item.type, style: new TextStyle(fontSize: 16),),
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
                                                                          child: new Text(item.count.toString(), style: new TextStyle(fontSize: 16),),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ]
                                                            );
                                                          }).toList(),
                                                        ),
                                                      ),
                                                    ),
                                                    _isLoadingMonth ? Positioned(
                                                        bottom: 0,
                                                        left: 0,
                                                        child: Container(
                                                          padding: EdgeInsets.only(bottom: 10),
                                                          width: MediaQuery.of(context).size.width,
                                                          alignment: Alignment.center,
                                                          child: new Row(
                                                            children: <Widget>[
                                                              Spacer(),
                                                              CircularProgressIndicator(),
                                                              Spacer(),
                                                            ],
                                                          ),
                                                        )
                                                    ) : Container()
                                                  ],
                                                );
                                              }
                                          ),
                                        ),
                                      ),
                                    )
                                )
                              ],
                            ),
                          )
                      ),
                      new Expanded(
                          flex: 1,
                          child: new Container(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            alignment: Alignment.centerRight,
                            width: double.infinity,
                            color: Colors.grey[300],
                            child: BlocBuilder(
                                bloc: _blocReportKpiMonth,
                                builder: (BuildContext context, state){
                                  return Table(
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
                                                  child: new Text(_countMonth.toString(), style: new TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
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
                                  );
                                }
                            ),
                          )
                      )
                    ],
                  ),
                ),
              ]
          ),
        )
    );
  }

}
















