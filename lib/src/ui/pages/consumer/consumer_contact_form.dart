import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';

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
        if (state is Stepped) {
          return _buildContactForm(state.consumer);
        }
        return Container();
      },
    );
  }

  Widget _buildContactForm(ConsumerModel consumer) {
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
                onSaved: (String value) {
                  _consumerBloc.currentState.consumer.name = value;
                },
                enabled: !_consumerBloc.hasFound,
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
                      EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 17,
        ),
        _ExpectedDateOfBirthFormField(
          consumerBloc: _consumerBloc,
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
                enabled: !_consumerBloc.hasFound,
                initialValue: consumer?.email,
                keyboardType: TextInputType.emailAddress,
                validator: (String value) {
                  String pattern =
                      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$";
                  RegExp regex = RegExp(pattern);
                  if (value.isNotEmpty && regex.hasMatch(value) != true) {
                    return 'Địa chỉ email nhập vào không hợp lệ';
                  }
                },
                onSaved: (String value) {
                  _consumerBloc.currentState.consumer.email = value;
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
                      EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class _ExpectedDateOfBirthFormField extends StatefulWidget {
  final ConsumerBloc consumerBloc;

  _ExpectedDateOfBirthFormField({Key key, @required this.consumerBloc})
      : super(key: key);

  @override
  _ExpectedDateOfBirthFormFieldState createState() =>
      _ExpectedDateOfBirthFormFieldState();
}

class _ExpectedDateOfBirthFormFieldState
    extends State<_ExpectedDateOfBirthFormField> {
  ConsumerBloc get _consumerBloc => widget.consumerBloc;

  ExpectedDateOfBirthType _selectedType;

  DateTime _expectedDateOfBirth;

  @override
  void initState() {
    super.initState();
    _selectedType = ExpectedDateOfBirthType.date;
    _expectedDateOfBirth =
        _consumerBloc.currentState.consumer?.expectedDateOfBirth;
  }

  void _onChanged(ExpectedDateOfBirthType value) {
    setState(() {
      _selectedType = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          width: double.infinity,
          height: 50,
          child: Row(
            children: <Widget>[
              Flexible(
                child: RadioListTile(
                  title: Text(
                    "Ngày sự sinh",
                    style: TextStyle(fontSize: 14),
                  ),
                  value: ExpectedDateOfBirthType.date,
                  groupValue: _selectedType,
                  onChanged: _onChanged,
                ),
              ),
              Flexible(
                child: RadioListTile(
                  title: Text(
                    "Tuần thai",
                    style: TextStyle(fontSize: 14),
                  ),
                  value: ExpectedDateOfBirthType.week,
                  groupValue: _selectedType,
                  onChanged: _onChanged,
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 17,
        ),
        _selectedType == ExpectedDateOfBirthType.date
            ? _buildDate()
            : _buildWeek(),
      ],
    );
  }

  int _expectedDateOfBirthToPregnancyWeek(DateTime date) {
    DateTime _now = DateTime.now();
    if (date == null || date.compareTo(_now.subtract(Duration(days: 7))) <= 0) {
      return null;
    }
    return 40 - (date.difference(_now).inDays / 7).floor();
  }

  DateTime _pregnancyWeekToExpectedDateOfBirth(int week) {
    if (week == null || week > 40 || week < 1) {
      return null;
    }
    return DateTime.now().add(Duration(days: ((40 - week) * 7) + 1));
  }

  Widget _buildDate() {
    return Container(
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
          DateTimePickerFormField(
            enabled: !_consumerBloc.hasFound,
            inputType: InputType.date,
            format: DateFormat('dd/MM/yyyy'),
            initialValue: _expectedDateOfBirth,
            validator: (_) {
              if (_expectedDateOfBirth == null) {
                return 'Ngày dự sinh không hợp lệ';
              }
            },
            onChanged: (DateTime value) {
              _expectedDateOfBirth = value;
            },
            onSaved: (_) {
              _consumerBloc.currentState.consumer.expectedDateOfBirth =
                  _expectedDateOfBirth;
            },
            style: TextStyle(
                fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey[350], width: 1)),
              border: OutlineInputBorder(),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildWeek() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                "Tuần thai",
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
            enabled: !_consumerBloc.hasFound,
            initialValue:
                _expectedDateOfBirthToPregnancyWeek(_expectedDateOfBirth)
                    ?.toString(),
            validator: (_) {
              if (_expectedDateOfBirth == null) {
                return 'Tuần thai không hợp lệ';
              }
            },
            onFieldSubmitted: (String value) {
              _expectedDateOfBirth =
                  _pregnancyWeekToExpectedDateOfBirth(int.tryParse(value));
            },
            onSaved: (_) {
              _consumerBloc.currentState.consumer.expectedDateOfBirth =
                  _expectedDateOfBirth;
            },
            keyboardType: TextInputType.number,
            style: TextStyle(
                fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey[350], width: 1)),
              border: OutlineInputBorder(),
              contentPadding:
                  EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 14),
            ),
          )
        ],
      ),
    );
  }
}

enum ExpectedDateOfBirthType { date, week }
