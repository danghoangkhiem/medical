import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:medical/src/blocs/synchronization/synchronization.dart';

import 'synchronization_result_page.dart';

class SynchronizationPage extends StatefulWidget {
  @override
  _SynchronizationPageState createState() => _SynchronizationPageState();
}

class _SynchronizationPageState extends State<SynchronizationPage> {
  @override
  Widget build(BuildContext context) {
    final SynchronizationBloc _bloc =
        BlocProvider.of<SynchronizationBloc>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text("Đồng bộ dữ liệu"),
      ),
      body: Container(
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
                        _bloc.currentState.isSynchronized
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
                        _bloc.currentState.isSynchronized
                            ? ''
                            : 'Vui lòng đồng bộ dữ liệu',
                        style: TextStyle(color: Colors.black54, fontSize: 16),
                      ),
                    )
                  ],
                )),
            _bloc.currentState.isSynchronized
                ? Container()
                : Expanded(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Colors.blueAccent,
                      ),
                      width: double.infinity,
                      margin:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: FlatButton(
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        SynchronizationResultPage()));
                          },
                          child: Text(
                            'Đồng bộ dữ liệu',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          )),
                    ))
          ],
        ),
      ),
    );
  }
}
