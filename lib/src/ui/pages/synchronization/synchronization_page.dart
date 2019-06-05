import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:medical/src/blocs/synchronization/synchronization.dart';

import 'synchronization_result_page.dart';

import 'package:medical/src/models/user_model.dart';

import 'package:medical/src/ui/widgets/loading_indicator.dart';

import 'package:medical/src/resources/consumer_repository.dart';

class SynchronizationPage extends StatefulWidget {
  final UserModel user;

  SynchronizationPage({Key key, @required this.user}) : super(key: key);

  @override
  _SynchronizationPageState createState() => _SynchronizationPageState();
}

class _SynchronizationPageState extends State<SynchronizationPage> {
  SynchronizationBloc _synchronizationBloc;
  ConsumerRepository _consumerRepository = ConsumerRepository();

  getAll() async {
    List consumers = await _consumerRepository.getAll();
    print('Consumer Total: ${consumers.length}');
  }

  @override
  Widget build(BuildContext context) {
    _synchronizationBloc = BlocProvider.of<SynchronizationBloc>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text("Đồng bộ dữ liệu"),
      ),
      body: BlocBuilder(
          bloc: _synchronizationBloc,
          builder: (BuildContext context, SynchronizationState state) {
            if (state.isSynchronizing) {
              return LoadingIndicator();
            }
            if (state.isSynchronizing && state.process == state.total) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            SynchronizationResultPage()));
              });
            }
            getAll();
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
                          fontSize: 22,
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
          Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.blueAccent,
                ),
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: FlatButton(
                    onPressed: () {
                      _synchronizationBloc.dispatch(
                          SynchronizationEvent.synchronize(
                              userId: widget.user.id));
                    },
                    child: Text(
                      'Đồng bộ dữ liệu',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    )),
              )),
        ],
      ),
    );
  }
}
