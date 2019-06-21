import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:medical/src/blocs/partner/partner.dart';
import 'package:medical/src/blocs/schedule_work/schedule_work.dart';

import 'package:medical/src/models/place_model.dart';
import 'package:medical/src/models/partner_model.dart';

import 'package:medical/src/ui/widgets/loading_indicator.dart';

import 'select_date_range_page.dart';

class SelectPartnerPage extends StatefulWidget {
  final DateTime selectedDate;
  final PlaceModel selectedPlace;
  final ScheduleWorkBloc scheduleWorkBloc;

  SelectPartnerPage({
    Key key,
    @required this.selectedDate,
    @required this.selectedPlace,
    @required this.scheduleWorkBloc,
  }) : super(key: key);

  @override
  _SelectPartnerPageState createState() => _SelectPartnerPageState();
}

class _SelectPartnerPageState extends State<SelectPartnerPage> {
  PartnerBloc _partnerBloc;

  @override
  void initState() {
    _partnerBloc = PartnerBloc();
    _partnerBloc.dispatch(FetchData(placeId: widget.selectedPlace?.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text('Chọn khách hàng'),
      ),
      body: BlocBuilder(
        bloc: _partnerBloc,
        builder: (BuildContext context, PartnerState state) {
          if (state is Loading) {
            return LoadingIndicator();
          }
          if (state is Failure) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text(state.error.toString()),
                backgroundColor: Colors.redAccent,
              ));
            });
          }
          if (state is Success) {
            return _buildListView(state.partners);
          }
          return Container();
        },
      ),
    );
  }

  Widget _buildListView(PartnerListModel partners) {
    return ListView.separated(
      itemCount: partners?.length,
      itemBuilder: (BuildContext context, int index) {
        return Material(
          color: Colors.transparent,
          child: InkWell(
            child: ListTile(
              leading: Icon(Icons.supervised_user_circle),
              title: Text(partners[index].name),
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => SelectDateRangePage(
                        selectedDate: widget.selectedDate,
                        selectedPlace: widget.selectedPlace,
                        selectedPartner: partners[index],
                        scheduleWorkBloc: widget.scheduleWorkBloc,
                      )));
            },
          ),
        );
      },
      separatorBuilder: (BuildContext ctx, int index) => Divider(),
    );
  }
}
