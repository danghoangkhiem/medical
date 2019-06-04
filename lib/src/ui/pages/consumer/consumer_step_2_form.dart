import 'package:flutter/material.dart';

import 'package:medical/src/blocs/consumer/consumer.dart';

import 'package:medical/src/models/additional_field_model.dart';

class ConsumerStepTwoForm extends StatefulWidget {
  final ConsumerBloc consumerBloc;

  ConsumerStepTwoForm({Key key, @required this.consumerBloc})
      : assert(consumerBloc != null),
        assert(consumerBloc.additionalFields.samples != null),
        super(key: key);

  @override
  _ConsumerStepTwoFormState createState() => _ConsumerStepTwoFormState();
}

class _ConsumerStepTwoFormState extends State<ConsumerStepTwoForm> {
  ConsumerBloc get _consumerBloc => widget.consumerBloc;
  AdditionalFieldListModel _fields;
  AdditionalFieldListModel _cachedFields;

  @override
  void initState() {
    super.initState();
    _fields = AdditionalFieldListModel.fromJson(
        _consumerBloc.additionalFields.samples.toJson());
    _cachedFields = _consumerBloc.currentState.consumer.additionalData.samples;
    _fields.append(_cachedFields);
  }

  @override
  void dispose() {
    _consumerBloc.currentState.consumer.additionalData.samples = _fields;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Thông tin sampling",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.blueAccent),
          ),
          SizedBox(
            height: 15,
          ),
          ListView.builder(
              shrinkWrap: true,
              itemCount: _fields.length,
              itemBuilder: (BuildContext context, int index) {
                return CheckboxListTile(
                  value: _fields[index].value != null &&
                      _fields[index].value as bool,
                  onChanged: (bool value) {
                    setState(() {
                      _fields[index].value = value;
                    });
                  },
                  title: Text(
                    _fields[index].label,
                    style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                  controlAffinity: ListTileControlAffinity.leading,
                );
              }),
          TextFormField(
            validator: (String value) {
              if (value.isEmpty) {
                return 'Vui lòng nhập lý do';
              }
            },
            onSaved: (String value) {
              _consumerBloc.currentState.consumer.description = value;
            },
            initialValue:
            _consumerBloc.currentState.consumer?.description,
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
              hintText: 'Lý do sampling nhiều hơn một mẫu'
            ),
            maxLines: 5,
          ),
        ],
      ),
    );
  }
}
