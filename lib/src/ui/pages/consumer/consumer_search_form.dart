import 'package:flutter/material.dart';

import 'package:medical/src/blocs/consumer/consumer.dart';

import 'package:medical/src/utils.dart';

class ConsumerSearchForm extends StatefulWidget {
  final ConsumerBloc consumerBloc;

  ConsumerSearchForm({Key key, @required this.consumerBloc}) : super(key: key);

  @override
  _ConsumerSearchFormState createState() => _ConsumerSearchFormState();
}

class _ConsumerSearchFormState extends State<ConsumerSearchForm> {
  final TextEditingController _phoneNumberController = TextEditingController();

  ConsumerBloc get _consumerBloc => widget.consumerBloc;

  bool isValid;

  @override
  void initState() {
    super.initState();
    isValid = true;
    _phoneNumberController.text =
        _consumerBloc.currentState.consumer?.phoneNumber;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Điện thoại cá nhân",
          style: TextStyle(
              color: Colors.black54, fontWeight: FontWeight.bold, fontSize: 16),
        ),
        SizedBox(
          height: 5,
        ),
        TextField(
          controller: _phoneNumberController,
          keyboardType: TextInputType.phone,
          onChanged: (String value) {
            String pattern = r"^0[^0][0-9]{8}$";
            RegExp regex = RegExp(pattern);
            if (regex.hasMatch(value) != true) {
              setState(() {
                isValid = false;
              });
            } else {
              setState(() {
                isValid = true;
              });
            }
            debounce(500, () {
              if (!isValid) {
                return;
              }
              _consumerBloc.dispatch(
                  SearchPhoneNumber(phoneNumber: _phoneNumberController.text));
            });
          },
          style: TextStyle(
              fontSize: 16,
              color: isValid ? Colors.black : Colors.redAccent,
              fontWeight: FontWeight.bold),
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[350], width: 1)),
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          ),
        )
      ],
    );
  }
}
