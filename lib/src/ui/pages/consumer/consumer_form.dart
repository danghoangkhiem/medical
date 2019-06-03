import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:medical/src/blocs/consumer/consumer.dart';

import 'consumer_search_form.dart';
import 'consumer_contact_form.dart';

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
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: ListView(
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Thông tin khách hàng",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.blueAccent),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    ConsumerSearchForm(
                      consumerBloc: _consumerBloc,
                    ),
                    ConsumerContactForm(
                      consumerBloc: _consumerBloc,
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
