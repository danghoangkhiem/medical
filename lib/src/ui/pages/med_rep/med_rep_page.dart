import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical/src/blocs/med_rep/med_rep_event.dart';
import 'package:medical/src/blocs/med_rep/med_rep_bloc.dart';
import 'package:medical/src/blocs/med_rep/med_rep_state.dart';
import 'package:medical/src/models/medrep_of_medsup_model.dart';
import 'package:medical/src/resources/med_rep_repository.dart';
import 'package:medical/src/ui/pages/day_schedule/day_schedule_med_rep_page.dart';
import 'package:medical/src/ui/widgets/loading_indicator.dart';
import 'package:medical/src/utils.dart';


// ignore: must_be_immutable
class MedRepPage extends StatefulWidget{

  DateTime date;

  MedRepPage(this.date);

  @override
  State<StatefulWidget> createState() {

    return new MedRepPageState(this.date);
  }
}
class MedRepPageState extends State<MedRepPage>{

  DateTime date;

  MedRepPageState(this.date);

  ScrollController _scrollController = new ScrollController();
  MedRepBloc _blocMedRep;

  MedRepRepository _medRepRepository = MedRepRepository();

  MedRepModel medRepModel;

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
          _blocMedRep.dispatch(LoadMore());
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();


    medRepModel = MedRepModel.fromJson([]);

    _blocMedRep =
        MedRepBloc(medRepRepository: _medRepRepository);

    _blocMedRep.dispatch(GetMedRep());

    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _blocMedRep?.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.blueAccent,
        title: new Text("Quản lý địa bàn trong ngày"),
      ),
      body: new Container(
        child: BlocListener(
          bloc: _blocMedRep,
          listener: (BuildContext context, state){
            if (state is ReachMax) {
              Scaffold.of(context).removeCurrentSnackBar();
              Scaffold.of(context).showSnackBar(SnackBar(
                duration: Duration(milliseconds: 1500),
                content: Text('Đã hiển thị tất cả dữ liệu'),
              ));
              _isLoading = false;
              _isReachMax = true;
              //_scrollController.removeListener(_scrollListener);
            }
            if(state is MedRepEmpty){
              Scaffold.of(context).removeCurrentSnackBar();
              Scaffold.of(context).showSnackBar(SnackBar(
                duration: Duration(milliseconds: 1500),
                content: Text('Không có dữ liệu'),
              ));
            }
            if (state is MedRepFailure) {
              Scaffold.of(context).removeCurrentSnackBar();
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text(state.error),
                backgroundColor: Colors.redAccent,
              ));
            }
            if (state is MedRepLoaded) {
              if (state.isLoadMore) {
                medRepModel.listMedRep
                    .addAll(state.medRep.listMedRep);
                _isLoading = false;
              } else {
                medRepModel.listMedRep =
                    state.medRep.listMedRep;
              }
            }
          },
          child: BlocBuilder(
              bloc: _blocMedRep,
              builder: (BuildContext context, state){
                if(state is MedRepLoading && !state.isLoadMore){
                  return LoadingIndicator(opacity: 0,);
                }
                return ListView.builder(
                  controller: _scrollController,
                    itemCount: _isLoading
                        ? medRepModel.listMedRep.length + 1
                        : medRepModel.listMedRep.length,
                    itemBuilder: (BuildContext context, int index){
                      if (_isLoading && index == medRepModel.listMedRep.length) {
                        return SizedBox(
                          height: 50,
                          child: Align(
                              alignment: Alignment.center,
                              child: CircularProgressIndicator()),
                        );
                      }
                      return _buildRow(medRepModel.listMedRep[index]);
                    },
                );
              }
          ),
        ),
      ),
    );
  }

  Widget _buildRow(MedRepItem item) {
    return InkWell(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => DayScheduleMedRep(date: date,userId: item.userId,)));
      },
      child: ListTile(
        title: new Text(item.name != null ? item.name : 'N/A'),
        subtitle: new Text("Mã số nhân viên"),
        trailing: new Icon(Icons.assignment_ind, color: Colors.blueAccent,),
      ),
    );
  }

}




