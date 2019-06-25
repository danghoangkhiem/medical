import 'package:flutter/material.dart';

import 'package:medical/src/blocs/consumer/consumer.dart';

import 'package:medical/src/models/additional_field_model.dart';

class ConsumerStepFiveForm extends StatefulWidget {
  final ConsumerBloc consumerBloc;

  ConsumerStepFiveForm({Key key, @required this.consumerBloc})
      : assert(consumerBloc != null),
        assert(consumerBloc.additionalFields.samples != null),
        super(key: key);

  @override
  _ConsumerStepFiveFormState createState() => _ConsumerStepFiveFormState();
}

class _ConsumerStepFiveFormState extends State<ConsumerStepFiveForm> {
  ConsumerBloc get _consumerBloc => widget.consumerBloc;
  AdditionalFieldListModel _fields;
  AdditionalFieldListModel _cachedFields;

  @override
  void initState() {
    super.initState();
    _fields = AdditionalFieldListModel.fromJson(
        _consumerBloc.additionalFields.pointOfSaleMaterials.toJson());
    _cachedFields =
        _consumerBloc.currentState.consumer.additionalData.pointOfSaleMaterials;
    _fields.append(_cachedFields);
  }

  Future<void> _resetValueFields() async {
    int index = 0;
    await Future.forEach(_fields.toList(), (AdditionalFieldModel field) {
      _fields[index] = field..value = null;
      index++;
    });
  }

  int get _selectedValue =>
      _fields.firstWhere((item) => item.value != null, orElse: () => null)?.key;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Thông tin POSM",
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
                return RadioListTile<int>(
                  title: Text(_fields[index].label),
                  value: _fields[index].key,
                  groupValue: _selectedValue,
                  onChanged: (Object value) async {
                    await _resetValueFields();
                    setState(() {
                      _fields[index].value = 1;
                      _consumerBloc.currentState.consumer.additionalData
                          .pointOfSaleMaterials = _fields;
                    });
                  },
                );
              }),
        ],
      ),
    );
  }
}
