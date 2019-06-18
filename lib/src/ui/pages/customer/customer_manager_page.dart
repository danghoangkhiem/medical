import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:medical/src/utils.dart';

//widget
import 'package:medical/src/ui/widgets/loading_indicator.dart';

//model
import 'package:medical/src/models/customer_manage_model.dart';

//bloc
import 'package:medical/src/blocs/customer_manage/customer_manage.dart';

//page
import 'package:medical/src/ui/pages/consumer/consumer_page.dart';

//test
import 'package:medical/src/ui/pages/day_schedule/day_schedule_page.dart';
import 'package:medical/src/ui/pages/day_coaching/day_coaching_page.dart';

class CustomerManagePage extends StatefulWidget {
  @override
  _CustomerManagePageState createState() {
    return new _CustomerManagePageState();
  }
}

class _CustomerManagePageState extends State<CustomerManagePage> {
  //define
  String _customerType;
  String _customerStatus;
  bool _isLoading = false;
  bool _isReachMax = false;
  CustomerManagerListModel _customerManagerList;
  CustomerManageBloc _customerManageBloc;
  final ScrollController _controller = ScrollController();

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
      throttle(10, () {
        if (_isLoading != true) {
          _isLoading = true;
          _customerManageBloc.dispatch(LoadMore());
        }
      });
    }
  }

  //widget input (select type & status + button search)
  Widget inputSearch() {
    return Container(
      height: 170,
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          inputType(),
          SizedBox(
            height: 10,
          ),
          inputStatus(),
          SizedBox(
            height: 10,
          ),
          buttonSearch(),
        ],
      ),
    );
  }

  String resetCustomerManagerList(value) {
    setState(() {
      _customerManagerList = CustomerManagerListModel.fromJson([]);
    });
    return value;
  }

  Widget inputType() {
    return Row(
      children: <Widget>[
        new Container(
          margin: EdgeInsets.only(right: 46),
          child: new Text(
            "Chọn loại",
            style: TextStyle(
                fontSize: 16,
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
                value: resetCustomerManagerList(_customerType),
                items: [
                  DropdownMenuItem(
                      value: CustomerType.leadType.toString(),
                      child:
                          new Text('Lead', style: TextStyle(fontSize: 16.0))),
                  DropdownMenuItem(
                      value: CustomerType.userType.toString(),
                      child:
                          new Text('User', style: TextStyle(fontSize: 16.0))),
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
    );
  }

  Widget inputStatus() {
    return Row(
      children: <Widget>[
        new Container(
          margin: EdgeInsets.only(right: 4),
          child: new Text(
            "Chọn tình trạng",
            style: TextStyle(
                fontSize: 16,
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
                value: resetCustomerManagerList(_customerStatus),
                items: [
                  DropdownMenuItem(
                      value: CustomerStatus.oldStatus.toString(),
                      child: new Text('Cũ', style: TextStyle(fontSize: 16.0))),
                  DropdownMenuItem(
                      value: CustomerStatus.newStatus.toString(),
                      child: new Text('Mới', style: TextStyle(fontSize: 16.0))),
                  DropdownMenuItem(
                      value: CustomerStatus.receiveStatus.toString(),
                      child: new Text(
                        'Đã nhận Sampling',
                        style: TextStyle(fontSize: 16.0),
                      )),
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
    );
  }

  Widget buttonSearch() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.blueAccent,
      ),
      height: 42,
      child: FlatButton(
        onPressed: () {
          _customerManageBloc.dispatch(CustomerManageEventFilter(
              customerType: _customerType, customerStatus: _customerStatus));
        },
        child: new Text(
          "Tìm",
          style: new TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
    );
  }

  //widget output (output list customer)
  Widget outputSearch() {
    return Expanded(
      flex: 2,
      child: BlocListener(
        bloc: _customerManageBloc,
        listener: (BuildContext context, CustomerManageState state) {
          Scaffold.of(context).removeCurrentSnackBar();
          if (state is NoRecordsFound) {
            //Scaffold.of(context).removeCurrentSnackBar();
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text('Không có dữ liệu được tìm thấy!'),
              backgroundColor: Colors.red,
            ));
          }
          if (state is ReachMax) {
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text('Đã hiển thị tất cả dữ liệu!'),
              backgroundColor: Colors.blue,
            ));
            _isLoading = false;
            _isReachMax = true;
          }
          if (state is Failure) {
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text(state.errorMessage),
              backgroundColor: Colors.redAccent,
            ));
          }
          if (state is Loaded) {
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text(
                  'Lưu ý: Bạn nên đồng bộ dữ liệu để có được danh sách mới nhất!'),
              backgroundColor: Colors.red,
            ));
            if (state.isLoadMore) {
              if (state.customerManagerList != null) {
                _customerManagerList.addAll(state.customerManagerList);
              }
              _isLoading = false;
            } else {
              _customerManagerList = state.customerManagerList;
              _isReachMax = false;
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
                if (_isLoading && index == _customerManagerList.length) {
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
                          width: 1),
                    ),
                  ),
                  height: 46,
                  child: InkWell(
                    onTap: () {
                      /*Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              DateCoachingPage(date: DateTime.now()),
                        ),
                      );*/
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          _customerManagerList[index].name,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          _customerManagerList[index].phone,
                          style: TextStyle(fontSize: 16, color: Colors.grey),
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
            child: Icon(
              Icons.person_add,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            inputSearch(),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Khách hàng',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Số điện thoại',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            Divider(),
            outputSearch(),
          ],
        ),
      ),
    );
  }
}
