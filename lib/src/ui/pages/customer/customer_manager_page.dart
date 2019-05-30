import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:medical/src/utils.dart';

import 'package:medical/src/ui/widgets/loading_indicator.dart';

import 'package:medical/src/models/customer_manage_model.dart';
import 'package:medical/src/blocs/customer_manage/customer_manage.dart';

import 'package:medical/src/ui/pages/consumer/consumer_page.dart';

//test
import 'package:medical/src/ui/pages/day_schedule/day_schedule_page.dart';

class CustomerManagePage extends StatefulWidget {
  @override
  _CustomerManagePageState createState() {
    return new _CustomerManagePageState();
  }
}

class _CustomerManagePageState extends State<CustomerManagePage> {
  String _customerType;
  String _customerStatus;

  final ScrollController _controller = ScrollController();

  CustomerManagerListModel _customerManagerList;
  CustomerManageBloc _customerManageBloc;

  bool _isLoading = false;

  @override
  void initState() {
    _customerManagerList = CustomerManagerListModel.fromJson([]);
    _customerManageBloc = CustomerManageBloc();
    _controller.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _customerManageBloc?.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      throttle(200, () {
        if (_isLoading != true) {
          _isLoading = true;
          _customerManageBloc.dispatch(LoadMore());
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text(
          "Quản lý khách hàng",
          style: new TextStyle(
              fontFamily: "Comfortaa", fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => ConsumerPage()));
            },
            child: Icon(Icons.person_add, color: Colors.white,),
          ),
        ],
      ),
      body: new Container(
        child: new Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: ListView(
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: <Widget>[
                        new SizedBox(
                          height: 10,
                        ),
                        new Row(
                          children: <Widget>[
                            new Container(
                              margin: EdgeInsets.only(right: 74),
                              child: new Text(
                                "Chọn loại",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black54),
                              ),
                            ),
                            Flexible(
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                height: 40,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.blueAccent,
                                        width: 2,
                                        style: BorderStyle.solid),
                                    borderRadius: BorderRadius.circular(4)),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                    isExpanded: true,
                                    value: _customerType,
                                    items: [
                                      DropdownMenuItem(
                                          value:
                                              CustomerType.leadType.toString(),
                                          child: new Text('Lead')),
                                      DropdownMenuItem(
                                          value:
                                              CustomerType.userType.toString(),
                                          child: new Text('User')),
                                    ],
                                    onChanged: (value) {
                                      setState(() {
                                        _customerType = value;
                                      });
                                    },
                                    style: new TextStyle(
                                        fontSize: 18,
                                        color: Colors.blueAccent,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
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
                                "Chọn tình trạng",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black54),
                              ),
                            ),
                            Flexible(
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                height: 40,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.blueAccent,
                                        width: 2,
                                        style: BorderStyle.solid),
                                    borderRadius: BorderRadius.circular(4)),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                    isExpanded: true,
                                    value: _customerStatus,
                                    items: [
                                      DropdownMenuItem(
                                          value: CustomerStatus.newStatus
                                              .toString(),
                                          child: new Text('Cũ')),
                                      DropdownMenuItem(
                                          value: CustomerStatus.oldStatus
                                              .toString(),
                                          child: new Text('Mới')),
                                      DropdownMenuItem(
                                          value: CustomerStatus.receiveStatus
                                              .toString(),
                                          child: new Text('Đã nhận Sampling')),
                                    ],
                                    onChanged: (value) {
                                      setState(() {
                                        _customerStatus = value;
                                      });
                                    },
                                    style: new TextStyle(
                                      fontSize: 18,
                                      color: Colors.blueAccent,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.blueAccent,
                          ),
                          height: 42,
                          child: FlatButton(
                            onPressed: () {
                              _customerManageBloc.dispatch(
                                  CustomerManageEventFilter(
                                      customerType: _customerType,
                                      customerStatus: _customerStatus));
                            },
                            child: new Text(
                              "Tìm",
                              style: new TextStyle(
                                  fontSize: 18, color: Colors.white),
                            ),
                          ),
                        ),
                        new SizedBox(
                          height: 50,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: BlocListener(
                bloc: _customerManageBloc,
                listener: (BuildContext context, CustomerManageState state) {
                  if (state is ReachMax) {
                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text('Got all the data!'),
                    ));
                    _controller.removeListener(_scrollListener);
                  }
                  if (state is Failure) {
                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text(state.errorMessage),
                      backgroundColor: Colors.redAccent,
                    ));
                  }
                  if (state is Loaded) {
                    if (state.isLoadMore) {
                      _customerManagerList.addAll(state.customerManagerList);
                      _isLoading = false;
                    } else {
                      _customerManagerList = state.customerManagerList;
                    }
                  }
                },
                child: BlocBuilder(
                  bloc: _customerManageBloc,
                  builder: (BuildContext context, CustomerManageState state) {
                    if (state is Loading && !state.isLoadMore) {
                      return LoadingIndicator();
                    }
                    return ListView.builder(
                      controller: _controller,
                      itemCount: _isLoading
                          ? _customerManagerList.length + 1
                          : _customerManagerList.length,
                      itemBuilder: (BuildContext context, int index) {
                        if (_isLoading &&
                            index == _customerManagerList.length) {
                          return SizedBox(
                            height: 50,
                            child: Align(
                                alignment: Alignment.center,
                                child: CircularProgressIndicator()),
                          );
                        }
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: Colors.grey[200],
                                    style: BorderStyle.solid,
                                    width: 1)),
                            color: Colors.white,
                          ),
                          height: 50,
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      DateSchedulePage(date: DateTime.now()),
                                ),
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  _customerManagerList[index].name,
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.grey,
                                      fontStyle: FontStyle.italic),
                                ),
                                Text(
                                  _customerManagerList[index].phone,
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
