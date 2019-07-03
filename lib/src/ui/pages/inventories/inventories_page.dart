import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical/src/blocs/inventories/inventories_bloc.dart';
import 'package:medical/src/blocs/inventories/inventories_event.dart';
import 'package:medical/src/blocs/inventories/inventories_state.dart';
import 'package:medical/src/blocs/type/type_bloc.dart';
import 'package:medical/src/blocs/type/type_event.dart';
import 'package:medical/src/blocs/type/type_state.dart';
import 'package:medical/src/models/models.dart';
import 'package:medical/src/resources/inventories_repository.dart';
import 'package:medical/src/resources/type_repository.dart';

class Inventories extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new InventoriesState();
  }
}

class InventoriesState extends State<Inventories> {
  //form
  int select;
  DateTime startDate;
  DateTime endDate;
  DateTime _now;

  TypeBloc _blocType;
  TypeRepository _typeRepository = TypeRepository();

  InventoriesBloc _blocInventories;
  InventoriesRepository _inventoriesRepository = InventoriesRepository();

  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    _now = DateTime.now();
    startDate = endDate = DateTime.parse(DateFormat('yyyy-MM-dd').format(_now));

    _blocType = TypeBloc(typeRepository: _typeRepository);
    _blocInventories =
        InventoriesBloc(inventoriesRepository: _inventoriesRepository);

    _blocType.dispatch(GetType());
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
        backgroundColor: Colors.blueAccent,
        title: new Text("Phiếu xuất nhập tồn"),
      ),
      body: new Container(
        child: new Column(
          children: <Widget>[
            new Container(
              height: 230,
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
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 10),
                                    ),
                                    style: new TextStyle(
                                        fontSize: 18,
                                        color: Colors.blueAccent,
                                        fontWeight: FontWeight.bold),
                                    onChanged: (dt) {
                                      setState(() {
                                        startDate = dt;
                                      });
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
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 10),
                                    ),
                                    style: new TextStyle(
                                        fontSize: 18,
                                        color: Colors.blueAccent,
                                        fontWeight: FontWeight.bold),
                                    onChanged: (dt) {
                                      setState(() {
                                        endDate = dt;
                                      });
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
                                new Container(
                                  margin: EdgeInsets.only(right: 24),
                                  child: new Text(
                                    "Chọn loại",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black54),
                                  ),
                                ),
                                Flexible(
                                  child: new BlocBuilder(
                                      bloc: _blocType,
                                      builder: (BuildContext context, state) {
                                        if (state is TypeLoading) {
                                          return Container();
                                        }
                                        if (state is TypeLoaded) {
                                          return new Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10),
                                            height: 40,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.blueAccent,
                                                    width: 2,
                                                    style: BorderStyle.solid),
                                                borderRadius:
                                                BorderRadius.circular(4)),
                                            child:
                                            DropdownButtonHideUnderline(
                                              child: DropdownButton(
                                                isExpanded: true,
                                                value: select,
                                                items: state.type.type
                                                    .map((item) {
                                                  return new DropdownMenuItem(
                                                      value: item.id,
                                                      child: new Text(
                                                          item.name));
                                                }).toList(),
                                                onChanged: (int newVal) {
                                                  setState(() {
                                                    select = newVal;
                                                    print("ok ok thong thong");
                                                    print(select);
                                                  });
                                                },
                                                style: new TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.blueAccent,
                                                    fontWeight:
                                                    FontWeight.bold),
                                              ),
                                            ),
                                          );
                                        }
                                        if (state is TypeFailure) {
                                          return Center(
                                            child: new Text(state.error),
                                          );
                                        }
                                        return Container();
                                      }),
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
                                        endDate != null &&
                                        select != null) {
                                      _blocInventories.dispatch(
                                          GetInventories(
                                              starDay: startDate,
                                              endDay: endDate,
                                              value: select));
                                    } else {
                                      _scaffoldKey.currentState.showSnackBar(
                                          SnackBar(
                                            backgroundColor: Colors.deepOrange,
                                            content: Text('Không đủ điều kiện tìm kiếm'),
                                            duration: Duration(milliseconds: 1500),
                                          ));
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
                    ],
                  )),
            ),
            new Expanded(
                flex: 8,
                child: new Container(
                  child: new Column(
                    children: <Widget>[
                      new Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                        height: 55,
                        color: Colors.grey[200],
                        child: Table(
                          columnWidths: {0: FractionColumnWidth(0.6)},
                          children: [
                            new TableRow(children: [
                              new Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  new Text(
                                    "Tên sản phẩm",
                                    style: new TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                              new Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  new Text(
                                    "Nhập",
                                    style: new TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                              new Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  new Text(
                                    "Xuất",
                                    style: new TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                              new Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  new Text(
                                    "Còn",
                                    style: new TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                            ])
                          ],
                        ),
                      ),
//reach data
                      new Expanded(
                          child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: SingleChildScrollView(
                          child: BlocListener(
                              bloc: _blocInventories,
                              listener: (BuildContext context, state){
                                if(state is InventoriesEmpty){
                                  Scaffold.of(context).removeCurrentSnackBar();
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                    duration: Duration(milliseconds: 1500),
                                    content: Text('Không có dữ liệu'),
                                    backgroundColor: Colors.redAccent,
                                  ));
                                }
                                if(state is InventoriesFailure){
                                  Scaffold.of(context).removeCurrentSnackBar();
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                    duration: Duration(milliseconds: 1500),
                                    content: Text('Lỗi khi tải dữ liệu'),
                                    backgroundColor: Colors.redAccent,
                                  ));
                                }
                              },
                            child: BlocBuilder(
                                bloc: _blocInventories,
                                builder: (BuildContext context, state) {
                                  if (state is InventoriesLoading) {
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
                                  if (state is InventoriesLoaded) {
                                    return Table(
                                      columnWidths: {0: FractionColumnWidth(0.6)},
                                      children: state
                                          .inventoriesModel.listInventories
                                          .map((item) {
                                        return TableRow(children: [
                                          SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: new Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              children: <Widget>[
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 10),
                                                  child: new Text(
                                                    item.label,
                                                    style:
                                                    new TextStyle(fontSize: 14),
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
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 10),
                                                child: new Text(
                                                  item.import.toString(),
                                                  style:
                                                  new TextStyle(fontSize: 14),
                                                ),
                                              ),
                                            ],
                                          ),
                                          new Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: <Widget>[
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 10),
                                                child: new Text(
                                                  item.export.toString(),
                                                  style:
                                                  new TextStyle(fontSize: 14),
                                                ),
                                              ),
                                            ],
                                          ),
                                          new Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: <Widget>[
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 10),
                                                child: new Text(
                                                  item.stock.toString(),
                                                  style:
                                                  new TextStyle(fontSize: 14),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ]);
                                      }).toList(),
                                    );
                                  }
//                                  if (state is InventoriesFailure) {
//                                    return Center(
//                                      child: new Text("Có lỗi " + state.error),
//                                    );
//                                  }
                                  return Container();
                                }),
                          ),
                        ),
                      ))
                    ],
                  ),
                )),
            new Expanded(
                flex: 1,
                child: new Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  alignment: Alignment.center,
                  width: double.infinity,
                  color: Colors.grey[200],
                  child: BlocBuilder(
                      bloc: _blocInventories,
                      builder: (BuildContext context, state) {
                        if (state is InventoriesLoading) {
                          return Container();
                        }
                        if (state is InventoriesLoaded) {
                          return Table(
                            columnWidths: {0: FractionColumnWidth(0.6)},
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
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    new Text(
                                      state.listSum[0].toString(),
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
                                      state.listSum[1].toString(),
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
                                      state.listSum[2].toString(),
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

//                        if (state is InventoriesFailure) {
//                          return Center(
//                            child: new Text(state.error),
//                          );
//                        }
                        return Container();
                      }),
                ))
          ],
        ),
      ),
    );
  }

  ListView buildListView(InventoriesModel inventories) {
    return ListView.builder(
        itemCount: inventories.listInventories.length,
        itemBuilder: (BuildContext context, int index) {
          return buildContainer(inventories.listInventories[index]);
        });
  }

  Widget buildContainer(InventoriesItem item) {
    return Container(
      height: 60,
      padding: EdgeInsets.symmetric(horizontal: 40),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
              bottom: BorderSide(
                  style: BorderStyle.solid,
                  width: 1,
                  color: Colors.grey[200]))),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
              child: new Text(
            item.label,
            style: new TextStyle(fontSize: 18),
          )),
          Expanded(
              child: new Container(
            margin: EdgeInsets.only(left: 35),
            child: new Text(
              item.import.toString(),
              style: new TextStyle(fontSize: 18),
            ),
          )),
          Expanded(
              child: new Container(
            margin: EdgeInsets.only(left: 20),
            child: new Text(
              item.export.toString(),
              style: new TextStyle(fontSize: 18),
            ),
          )),
          new Text(
            item.stock.toString(),
            style: new TextStyle(fontSize: 18),
          )
        ],
      ),
    );
  }
}
