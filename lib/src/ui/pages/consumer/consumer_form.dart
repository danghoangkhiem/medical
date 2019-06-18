import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:medical/src/blocs/consumer/consumer.dart';

import 'consumer_step_1_form.dart';
import 'consumer_step_2_form.dart';
import 'consumer_step_3_form.dart';
import 'consumer_step_4_form.dart';
import 'consumer_step_5_form.dart';

class ConsumerForm extends StatefulWidget {
  final ConsumerBloc consumerBloc;
  final GlobalKey<FormState> formKey;

  ConsumerForm({Key key, @required this.consumerBloc, @required this.formKey})
      : super(key: key);

  @override
  _ConsumerFormState createState() => _ConsumerFormState();
}

class _ConsumerFormState extends State<ConsumerForm> {
  GlobalKey<FormState> get _formKey => widget.formKey;
  ConsumerBloc get _consumerBloc => widget.consumerBloc;

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        autovalidate: false,
        child: Container(
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              BlocBuilder(
                  bloc: _consumerBloc,
                  builder: (BuildContext context, ConsumerState state) {
                    if (state is Stepped && state.error != null) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Xảy ra lỗi'),
                              content: Container(
                                child: Text(state.error.toString()),
                              ),
                              actions: <Widget>[
                                FlatButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Đóng lại'),
                                )
                              ],
                            );
                          }
                        );
                      });
                    }
                    if (state.currentStep == 0 || state.currentStep == 1) {
                      return ConsumerStepOneForm(consumerBloc: _consumerBloc);
                    }
                    if (state.currentStep == 2) {
                      return ConsumerStepTwoForm(consumerBloc: _consumerBloc);
                    }
                    if (state.currentStep == 3) {
                      return ConsumerStepThreeForm(consumerBloc: _consumerBloc);
                    }
                    if (state.currentStep == 4) {
                      return ConsumerStepFourForm(consumerBloc: _consumerBloc);
                    }
                    if (state.currentStep == 5) {
                      return ConsumerStepFiveForm(consumerBloc: _consumerBloc);
                    }
                    return Align(
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(),
                    );
                  })
            ],
          ),
        ));
  }
}
