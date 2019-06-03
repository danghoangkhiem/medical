import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:medical/src/blocs/consumer/consumer.dart';

import 'consumer_form.dart';

import 'package:medical/src/ui/widgets/loading_indicator.dart';

class ConsumerPage extends StatefulWidget {
  @override
  _ConsumerPageState createState() => _ConsumerPageState();
}

class _ConsumerPageState extends State<ConsumerPage> {
  GlobalKey<FormState> _formKey;
  ConsumerBloc _consumerBloc;

  @override
  void initState() {
    _consumerBloc = ConsumerBloc();
    _consumerBloc.dispatch(GetAdditionalFields());
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
                ));
              });
            }
            if (state is Loading) {
              return LoadingIndicator();
            }
            return Container(
              child: Column(
                children: <Widget>[
                  Expanded(
                      flex: 6,
                      child: ConsumerForm(
                        consumerBloc: _consumerBloc,
                        formKey: _formKey,
                      )),
                  Expanded(
                    flex: 1,
                    child: _buildNextStepButton(),
                  )
                ],
              ),
            );
          }),
    );
  }

  Widget _buildNextStepButton() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Row(
        children: <Widget>[
          Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 5),
                decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(4)),
                child: FlatButton(
                    padding: EdgeInsets.symmetric(vertical: 13),
                    onPressed: () {
                      if (!_formKey.currentState.validate()) {
                        return;
                      }
                      _consumerBloc.dispatch(NextStepButtonPressed());
                    },
                    child: Text(
                      "TIẾP TỤC",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    )
                ),
              )
          )
        ],
      ),
    );
  }
}
