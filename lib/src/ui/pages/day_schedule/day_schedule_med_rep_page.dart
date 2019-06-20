import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical/src/blocs/manage_area/manage_area_event.dart';
import 'package:medical/src/blocs/manage_area/manage_area_bloc.dart';
import 'package:medical/src/blocs/manage_area/manage_area_state.dart';
import 'package:medical/src/models/day_schedule_med_rep_model.dart';
import 'package:medical/src/resources/manage_area_repository.dart';
import 'package:medical/src/ui/pages/manage_area/manage_area_page.dart';
import 'package:medical/src/ui/widgets/loading_indicator.dart';
import 'package:medical/src/utils.dart';

class DayScheduleMedRep extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new DayScheduleMedRepState();
  }
}

class DayScheduleMedRepState extends State<DayScheduleMedRep> {

  ScrollController _scrollController = new ScrollController();
  ManageAreaBloc _blocManageArea;
  ManageAreaRepository _manageAreaRepository = ManageAreaRepository();

  DayScheduleMedRepModel manageAreaModel;

  bool _isLoading = false;
  bool _isReachMax = false;

  void _scrollListener() {
    if(_isReachMax){
      return;
    }
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      throttle(10, () {
        if (_isLoading != true) {
          _isLoading = true;
          _blocManageArea.dispatch(LoadMore());
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();

    manageAreaModel = DayScheduleMedRepModel.fromJson([]);
    _blocManageArea =
        ManageAreaBloc(manageAreaRepository: _manageAreaRepository);
    _blocManageArea.dispatch(GetManageArea(
      date: DateTime.now(),
    ));

    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _blocManageArea?.dispose();
    _scrollController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text("Lịch làm việc trong ngày"),
      ),
      body: SafeArea(
          child: new Container(
            child: BlocListener(
              bloc: _blocManageArea,
              listener: (BuildContext context, state){
                if (state is ReachMax) {
                  Scaffold.of(context).removeCurrentSnackBar();
                  Scaffold.of(context).showSnackBar(SnackBar(
                    duration: Duration(milliseconds: 1500),
                    content: Text('Đã hiển thị tất cả dữ liệu'),
                  ));
                  _isLoading = false;
                  _isReachMax = true;
                }
                if(state is ManageAreaEmpty){
                  Scaffold.of(context).removeCurrentSnackBar();
                  Scaffold.of(context).showSnackBar(SnackBar(
                    duration: Duration(milliseconds: 1500),
                    content: Text('Không có dữ liệu'),
                  ));
                }
                if (state is ManageAreaFailure) {
                  Scaffold.of(context).removeCurrentSnackBar();
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text(state.error),
                    backgroundColor: Colors.redAccent,
                  ));
                }
                if (state is ManageAreaLoaded) {
                  if (state.isLoadMore) {
                    manageAreaModel.listDayScheduleMedRep
                        .addAll(state.manageArea.listDayScheduleMedRep);
                    _isLoading = false;
                  } else {
                    manageAreaModel.listDayScheduleMedRep =
                        state.manageArea.listDayScheduleMedRep;
                  }
                }
              },
              child: BlocBuilder(
                  bloc: _blocManageArea,
                  builder: (context, state) {
                    if (state is ManageAreaLoading && !state.isLoadMore) {
                      return LoadingIndicator(opacity: 0,);
                    }
                    return ListView.builder(
                      controller: _scrollController,
                      itemCount: _isLoading
                          ? manageAreaModel.listDayScheduleMedRep.length + 1
                          : manageAreaModel.listDayScheduleMedRep.length,
                      itemBuilder: (BuildContext context, int index) {
                        if (_isLoading && index == manageAreaModel.listDayScheduleMedRep.length) {
                          return SizedBox(
                            height: 50,
                            child: Align(
                                alignment: Alignment.center,
                                child: CircularProgressIndicator()),
                          );
                        }
                        return _buildRow(manageAreaModel.listDayScheduleMedRep[index]);
                      },
                    );

                  }),

            ),
          )
      ),
    );
  }

  Widget _buildRow(DayScheduleMedRepItem item) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
            bottom: BorderSide(
                width: 1,
                style: BorderStyle.solid,
                color: Colors.grey[300])),
        color: Colors.white,
      ),
      height: 100,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: (){
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => ManageArea(item)));
          },
          child: new Row(
            children: <Widget>[
              new Expanded(
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: new Text(
                        "Từ ${item.startTime.hour}:${item.startTime.minute} đến ${item.endTime.hour}:${item.endTime.minute}",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54),
                      ),
                    ),
                    new SizedBox(
                      height: 7,
                    ),
                    new Container(
                      padding: EdgeInsets.only(left: 20),
                      margin: EdgeInsets.only(left: 20),
                      child: new Text(
                        item.doctorName,
                        style: new TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    new SizedBox(
                      height: 2,
                    ),
                    new Container(
                      padding: EdgeInsets.only(left: 20),
                      margin: EdgeInsets.only(left: 20),
                      child: new Text(
                        "${item.addressType}: ${item.addressName}",
                        style: new TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
              new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Padding(
                    padding: EdgeInsets.only(right: 20),
                    child: new IconButton(
                        icon: Icon(Icons.add_circle, color: Colors.blueAccent,),
                        onPressed: (){
                        }
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}