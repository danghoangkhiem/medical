import 'package:flutter/material.dart';

import 'package:medical/src/blocs/consumer/consumer.dart';

import 'consumer_search_form.dart';
import 'consumer_contact_form.dart';

class ConsumerStepOneForm extends StatelessWidget {
  final ConsumerBloc _consumerBloc;

  ConsumerStepOneForm({Key key, @required ConsumerBloc consumerBloc})
      : assert(consumerBloc != null),
        _consumerBloc = consumerBloc,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30),
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
          ),
        ],
      ),
    );
  }
}
