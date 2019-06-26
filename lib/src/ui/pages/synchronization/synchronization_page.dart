import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:medical/src/blocs/synchronization/synchronization.dart';

import 'synchronization_result_page.dart';

import 'package:medical/src/models/user_model.dart';

import 'package:medical/src/ui/widgets/loading_indicator.dart';

class SynchronizationPage extends StatefulWidget {
  final UserModel user;

  SynchronizationPage({Key key, @required this.user}) : super(key: key);

  @override
  _SynchronizationPageState createState() => _SynchronizationPageState();
}

class _SynchronizationPageState extends State<SynchronizationPage> {
  SynchronizationBloc _synchronizationBloc;

  @override
  void initState() {
    _synchronizationBloc = BlocProvider.of<SynchronizationBloc>(context);
    _synchronizationBloc
        .dispatch(SynchronizationEvent.check(userId: widget.user.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text("Đồng bộ dữ liệu"),
      ),
      body: BlocBuilder(
          bloc: _synchronizationBloc,
          builder: (BuildContext context, SynchronizationState state) {
            if (state.isSynchronizing && state.process == state.total) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (BuildContext context) =>
                        SynchronizationResultPage()));
              });
            }
            if (state.isSynchronizing) {
              return LoadingIndicator();
            }
            return _buildPage();
          }),
    );
  }

  Widget _buildPage() {
    return Container(
      child: Column(
        children: <Widget>[
          Expanded(
              flex: 6,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.cloud_upload,
                    color: Colors.blueAccent,
                    size: 100,
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 5, top: 20),
                    child: Text(
                      _synchronizationBloc.currentState.isSynchronized
                          ? 'Dữ liệu đã được đồng bộ'
                          : 'Dữ liệu chưa được đồng bộ',
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    child: Text(
                      _synchronizationBloc.currentState.isSynchronized
                          ? ''
                          : 'Vui lòng đồng bộ dữ liệu',
                      style: TextStyle(color: Colors.black54, fontSize: 16),
                    ),
                  )
                ],
              )),
          Material(
            elevation: 5,
            child: Container(
              height: 65,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: Container(
                        margin: EdgeInsets.only(left: 5),
                        decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius: BorderRadius.circular(4)),
                        child: FlatButton(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            onPressed: () {
                              _synchronizationBloc.dispatch(
                                  SynchronizationEvent.synchronize(
                                      userId: widget.user.id));
                            },
                            child: Text(
                              "Đồng bộ dữ liệu",
                              style: TextStyle(
                                  fontSize: 16, color: Colors.white),
                            )),
                      ))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}



