import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medical/src/blocs/kpi_date_detail/kpi_date_detail_bloc.dart';
import 'package:medical/src/blocs/kpi_date_detail/kpi_date_detail_event.dart';
import 'package:medical/src/blocs/kpi_date_detail/kpi_date_detail_state.dart';
import 'package:medical/src/models/kpi_date_detail_model.dart';
import 'package:medical/src/resources/kpi_date_detail_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical/src/ui/widgets/loading_indicator.dart';

class KpiDateDetail extends StatefulWidget {
  DateTime byDate;

  KpiDateDetail({this.byDate});

  @override
  State<StatefulWidget> createState() {
    return new KpiDateDetailState(byDate: byDate);
  }
}

class KpiDateDetailState extends State<KpiDateDetail> {
  DateTime byDate;

  KpiDateDetailState({this.byDate});

  KpiDateDetailBloc _blocKpiDateDetail;
  KpiDateDetailRepository _kpiDateDetailRepository = KpiDateDetailRepository();

  @override
  void initState() {
    super.initState();
    _blocKpiDateDetail =
        KpiDateDetailBloc(kpiDateDetailRepository: _kpiDateDetailRepository);

    _blocKpiDateDetail.dispatch(GetReportKpiDayDetail(byDate: byDate));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text("Thống kê KPI"),
      ),
      body: new Container(
        child: new Column(
          children: <Widget>[
            new Expanded(
                flex: 1,
                child: new Container(
                    margin: EdgeInsets.only(left: 20),
                    color: Colors.white,
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        new Text(
                          "Ngày: ",
                          style: new TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54),
                        ),
                        new Text(
                          DateFormat('dd-MM-yyyy').format(byDate),
                          style: new TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        )
                      ],
                    ))),
            new Expanded(
                flex: 9,
                child: new Container(
                  child: BlocBuilder(
                      bloc: _blocKpiDateDetail,
                      builder: (BuildContext context, state) {
                        if(state is ReportKpiDayDetailLoading){
                          return LoadingIndicator();
                        }
                        if (state is ReportKpiDayDetailLoaded) {
                          return ListView.builder(
                              itemCount: state.reportKpiDayDetailModel
                                  .listKpiDayDetailItem.length,
                              itemBuilder: (BuildContext context, index) {
                                return buildContainer(state.reportKpiDayDetailModel.listKpiDayDetailItem[index]);
                              });
                        }
                        if(state is ReportKpiDayDetailFailure){
                          return Center(
                            child: new Text(state.error),
                          );
                        }
                        return Container();
                      }),
                ))
          ],
        ),
      ),
    );
  }

  Container buildContainer(ReportKpiDayDetailItemModel item) {
    return new Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  color: Colors.white, style: BorderStyle.solid, width: 1)),
          color: Colors.grey[200]),
      height: 60,
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          new Container(
            margin: EdgeInsets.only(right: 20),
            child: new Text(
              item.name,
              style: new TextStyle(fontSize: 14),
            ),
          ),
          new Flexible(
            child: new Text(
              item.hospital,
              style: new TextStyle(fontSize: 14),
            ),
          )
        ],
      ),
    );
  }
}
