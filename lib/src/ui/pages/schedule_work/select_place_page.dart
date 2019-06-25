import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:medical/src/blocs/place/place.dart';
import 'package:medical/src/blocs/schedule_work/schedule_work.dart';

import 'package:medical/src/models/place_model.dart';

import 'package:medical/src/ui/widgets/loading_indicator.dart';

import 'select_partner_page.dart';

class SelectPlacePage extends StatefulWidget {
  final DateTime selectedDate;
  final ScheduleWorkBloc scheduleWorkBloc;

  SelectPlacePage({
    Key key,
    @required this.selectedDate,
    @required this.scheduleWorkBloc,
  }) : super(key: key);

  @override
  _SelectPlacePageState createState() => _SelectPlacePageState();
}

class _SelectPlacePageState extends State<SelectPlacePage> {
  PlaceBloc _placeBloc;

  @override
  void initState() {
    _placeBloc = PlaceBloc();
    _placeBloc.dispatch(FetchData());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text('Chọn địa bàn'),
      ),
      body: BlocBuilder(
        bloc: _placeBloc,
        builder: (BuildContext context, PlaceState state) {
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
            return _buildListView(state.places);
          }
          return Container();
        },
      ),
    );
  }

  Widget _buildListView(PlaceListModel places) {
    return ListView.separated(
      itemCount: places?.length,
      itemBuilder: (BuildContext context, int index) {
        return Material(
          color: Colors.transparent,
          child: InkWell(
            child: ListTile(
              leading: Icon(Icons.location_on),
              title: Text(places[index].name),
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => SelectPartnerPage(
                        selectedDate: widget.selectedDate,
                        selectedPlace: places[index],
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
