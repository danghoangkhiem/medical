import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:medical/src/blocs/consumer/consumer.dart';

import 'package:medical/src/models/consumer_model.dart';

class ConsumerContactForm extends StatefulWidget {
  final ConsumerBloc consumerBloc;

  ConsumerContactForm({Key key, @required this.consumerBloc}) : super(key: key);

  @override
  _ConsumerContactFormState createState() => _ConsumerContactFormState();
}

class _ConsumerContactFormState extends State<ConsumerContactForm> {
  ConsumerBloc get _consumerBloc => widget.consumerBloc;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _consumerBloc,
      builder: (BuildContext context, ConsumerState state) {
        if (state is Searching) {
          return Container(
            padding: const EdgeInsets.only(top: 20),
            alignment: Alignment.center,
            child: CircularProgressIndicator(),
          );
        }
        if (state is FinishedSearching || state is Stepped) {
          return _buildForm(_consumerBloc.consumer);
        }
        return Container();
      },
    );
  }

  Widget _buildForm(ConsumerModel consumer) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 17,
        ),
        Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Họ và tên",
                style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
              SizedBox(
                height: 5,
              ),
              TextFormField(
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Họ và tên không được bỏ trống';
                  }
                },
                initialValue: consumer?.name,
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                      BorderSide(color: Colors.grey[350], width: 1)),
                  border: OutlineInputBorder(),
                  contentPadding:
                  EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 17,
        ),
        Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    "Ngày dự sinh",
                    style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              TextFormField(
                initialValue: consumer?.dateOf?.toIso8601String(),
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                      BorderSide(color: Colors.grey[350], width: 1)),
                  border: OutlineInputBorder(),
                  contentPadding:
                  EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 17,
        ),
        Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    "Địa chỉ email",
                    style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              TextFormField(
                initialValue: consumer?.email,
                keyboardType: TextInputType.emailAddress,
                validator: (String value) {
                  String pattern =
                      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$";
                  RegExp regex = RegExp(pattern);
                  if (regex.hasMatch(value) != true) {
                    return 'Địa chỉ email nhập vào không hợp lệ';
                  }
                },
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                      BorderSide(color: Colors.grey[350], width: 1)),
                  border: OutlineInputBorder(),
                  contentPadding:
                  EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
