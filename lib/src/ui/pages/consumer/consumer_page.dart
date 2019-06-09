import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:medical/src/blocs/consumer/consumer.dart';
import 'package:medical/src/blocs/synchronization/synchronization.dart';

import 'consumer_form.dart';

import 'package:medical/src/ui/widgets/loading_indicator.dart';

class ConsumerPage extends StatefulWidget {
  @override
  _ConsumerPageState createState() => _ConsumerPageState();
}

class _ConsumerPageState extends State<ConsumerPage> {
  GlobalKey<FormState> _formKey;
  ConsumerBloc _consumerBloc;
  SynchronizationBloc _synchronizationBloc;

  @override
  void initState() {
    _synchronizationBloc = BlocProvider.of<SynchronizationBloc>(context);
    _consumerBloc = ConsumerBloc(synchronizationBloc: _synchronizationBloc);
    _consumerBloc.dispatch(AdditionalFields());
    _formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  void dispose() {
    _consumerBloc?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text("Thêm khách hàng"),
      ),
      body: BlocBuilder(
          bloc: _consumerBloc,
          builder: (BuildContext context, ConsumerState state) {
            if (state is Failure) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Scaffold.of(context).removeCurrentSnackBar();
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text(state.errorMessage),
                  backgroundColor: Colors.redAccent,
                  duration: Duration(seconds: 2),
                ));
              });
            }
            if (state is Added) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Scaffold.of(context).removeCurrentSnackBar();
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text('Đã thêm khách hàng thành công'),
                  backgroundColor: Colors.greenAccent,
                  duration: Duration(seconds: 2),
                ));
              });
            }
            if (state is FatalError) {
              return Container(
                child: Center(
                  child: Text(
                    state.errorMessage,
                    style: TextStyle(
                      color: Colors.redAccent,
                      fontSize: 16,
                    ),
                  ),
                ),
              );
            }
            if (state is Loading) {
              return LoadingIndicator();
            }
            return Column(
              children: <Widget>[
                Expanded(
                    flex: 6,
                    child: ConsumerForm(
                      consumerBloc: _consumerBloc,
                      formKey: _formKey,
                    )),
                _buildActionButton()
              ],
            );
          }),
    );
  }

  Widget _buildActionButton() {
    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: <Widget>[
          _consumerBloc.currentState.currentStep <= 1 ||
                  _consumerBloc.currentState.currentStep == 6
              ? Container()
              : _buildPrevStepButton(),
          _consumerBloc.currentState.currentStep == 6
              ? Container()
              : _buildNextStepButton()
        ],
      ),
    );
  }

  Widget _buildPrevStepButton() {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(left: 5),
        decoration: BoxDecoration(
            color: Colors.redAccent, borderRadius: BorderRadius.circular(4)),
        child: FlatButton(
            padding: EdgeInsets.symmetric(vertical: 13),
            onPressed: () {
              if (_consumerBloc.currentState.currentStep <= 1) {
                return;
              }
              _formKey.currentState.save();
              _consumerBloc.dispatch(PrevStep());
            },
            child: Text(
              "QUAY LẠI",
              style: TextStyle(fontSize: 16, color: Colors.white),
            )),
      ),
    );
  }

  Widget _buildNextStepButton() {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(left: 5),
        decoration: BoxDecoration(
            color: Colors.blueAccent, borderRadius: BorderRadius.circular(4)),
        child: FlatButton(
            padding: EdgeInsets.symmetric(vertical: 13),
            onPressed: () {
              if (_consumerBloc.currentState.currentStep == 0 ||
                  _formKey.currentState.mounted != true ||
                  _formKey.currentState.validate() != true) {
                return;
              }
              _formKey.currentState.save();
              _consumerBloc.dispatch(
                  NextStep(consumer: _consumerBloc.currentState.consumer));
            },
            child: Text(
              _consumerBloc.currentState.currentStep == 5
                  ? "LƯU LẠI"
                  : "TIẾP TỤC",
              style: TextStyle(fontSize: 16, color: Colors.white),
            )),
      ),
    );
  }
}
